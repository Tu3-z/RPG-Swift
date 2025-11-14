//
//  main.swift
//  rpg-arthurgoncalvesandrade
//
//  Created by ARTHUR GONCALVES ANDRADE on 14/11/25.
//

import Foundation

enum Classe {
    case Arqueiro
    case Guerreiro
    case Mago
}

func typewriter(_ text: String, speed: useconds_t = 50000) {
    for char in text {
        print(char, terminator: "")
        fflush(stdout)
        usleep(speed)
    }
    print("")
}

struct Personagem {
    var nome: String
    var classe: Classe
    var vida: Int
    var defesa: Int
    var ataques: [String: Int]
}

struct Dracula {
    let nome: String = "Dracula"
    var vida: Int = 120
    let frases =
        [
            "Eu sinto o cheiro da sua culpa… pesada, podre. Você a carrega como quem abraça um cadáver que se recusa a enterrar.",
           "Diz que procura redenção, mas seus passos ainda sangram o nome daquela que você deixou para trás. Nem suas preces acreditam em você.",
           "Ah… esse olhar. A vergonha sempre revela mais que qualquer lâmina. Fala mais alto que seus gritos.",
           "Você tenta me enfrentar, mas não consegue enfrentar o espelho. Seu maior inimigo não sou eu — é o que você fez quando ela pediu para você ficar.",
           "O pecado que você esconde… eu o provo como vinho. Amargo. Inacabado. Humano demais.",
           "Que ironia. Você ergue a espada como se ainda tivesse algo a proteger. Mas aquilo que amava… você deixou morrer antes mesmo de eu tocar nela.",
           "Sua coragem vacila toda vez que pronuncio o nome dela — como uma ferida antiga que nunca cicatrizou, só apodreceu em silêncio.",
            "Dói, não é? Ver que até eu conheço seus arrependimentos melhor do que você jamais teve coragem de admitir.",
            "Você carrega fantasmas… mas nenhum deles teme você. Todos ainda lhe sussurram o que perdeu.",
            "Sua dor é o banquete perfeito. Cada erro, cada mentira… uma taça diferente para eu saborear enquanto observo você desmoronar."
        ]
    let ataques =
    [
        10, 20, 30
        ]
}

struct Vampiro {
    let nome: String = "Vampiro Rasgado"
    var vida: Int = 50
    let ataques =
    [
        2, 4, 8
    ]
}

let magoAtaques =

[
    "Chama Funebre": 5,
    "Correntes da Penumbra": 10,
    "Lamento Abissal:": 15
]

let guerreiroAtaques =
[
    "Golpe Esfolador": 6,
    "Investida do Carnical": 12,
    "Ira Sanguinaria": 24
]

let arqueiroAtaques =
[
    "Flecha Fendessombra": 5,
    "Disparo Funebre": 16,
    "Chuva de Ossos": 21,
    
]

func menu() {
    print("=============Xtranho=============")
    print("[1] Jogar")
    print("[2] Sair")
}

func criarPersona() -> Personagem {
    print("Qual seu nome jovem arrependido?")
    let nome = readLine() ?? "SemNome"

    print("Olá \(nome)! Escolha sua classe...")
    print("[1] Arqueiro\n[2] Guerreiro\n[3] Mago")

    let classeEscolhida = Int(readLine() ?? "0") ?? 0

    switch classeEscolhida {
    case 1:
        return Personagem(nome: nome, classe: .Arqueiro, vida: 100, defesa: 20, ataques: arqueiroAtaques)
    case 2:
        return Personagem(nome: nome, classe: .Guerreiro, vida: 150, defesa: 50, ataques: guerreiroAtaques)
    case 3:
        return Personagem(nome: nome, classe: .Mago, vida: 90, defesa: 10, ataques: magoAtaques)
    default:
        print("Opção inválida. Definindo Arqueiro por padrão.")
        return Personagem(nome: nome, classe: .Arqueiro, vida: 100, defesa: 20, ataques: arqueiroAtaques)
    }
}

func historia() {
    typewriter("Voce sabe o que fez.")
    typewriter("Nao vai esconder o que lhe foi destinado.")
    typewriter("Fez uma rosa sangrar, o ceu fechar. Se arrepende?")
    print("[1] Onde eu to?\n[2] O que eu fiz?")
    let op = Int(readLine() ?? "0") ?? 0
    
    if op == 1 {
        print("No inferno.")
        print("Siga sua jornada, maculado")
    }
    
    else if op == 2 {
        print(".....")
        print("Siga sua jornada, maculado")
    }
}

func rolarDado() -> Int {
    return Int.random(in: 1...2)
}

func batalhaNormal(personagem: Personagem, inimigo: Vampiro) {
    print("Encontrou \(inimigo.nome)!")
    var atualP = personagem.vida
    var atualI = inimigo.vida
    
    while true {
        if atualP <= 0 {
            print("Voce morreu. Fim de jogo.")
            exit(0)
        }
        
        else if atualI <= 0 {
            print("\(inimigo.nome) derrotado! Siga em frente, maculado")
            break
        }
        
        else {
            print("==============SEU TURNO==============")
            for k in personagem.ataques.keys {
                print("* \(k)", terminator: " ")
                print("")
            }
            
            let op = readLine() ?? ""
            if let dano = personagem.ataques[op] {
                var dado = rolarDado()
                print("Voce causou \(dano * (dado)) de dano!")
                atualI -= dano * (dado)
                if atualI < 0 {
                    atualI = 0
                }
                print("Vida de \(inimigo.nome): \(atualI)")
            }
            
            if atualI <= 0 {
                continue
            }
            let escolherGolpe = Int.random(in: 0...2)
            let danoInimigo = inimigo.ataques[escolherGolpe] * rolarDado()
            print("\(inimigo.nome) causou \(danoInimigo) de dano!")
            atualP -= danoInimigo
            print("Sua vida: \(atualP)")
            
        }
    }
    
}


func boss(personagem: Personagem, inimigo: Dracula) {
    let morteDracula = """
    Quando sua lâmina finalmente atravessa o peito de Drácula, não é sangue que escorre — é escuridão. Uma névoa espessa, quase viva, exala do ferimento enquanto ele ri… baixo, fraco, mas ainda assim cruel.

    Ele cai de joelhos, apoiando-se no chão como quem segura o próprio túmulo.
    Os olhos vermelhos encaram você pela última vez, não com ódio… mas com um luto estranho. Um luto por você.

    “Então é assim que termina?” — sua voz falha, mas ainda corta fundo. — “Você acredita mesmo que a morte me silencia? Que me cala?”

    Um sorriso torto, quase piedoso, surge nos lábios dele.

    “Eu só fui o espelho… nada além da sombra que o seu próprio coração projetou.”

    A névoa que o envolve começa a devorar seu corpo, consumindo-o lentamente, como um castigo ritualístico.

    “Ouça bem…” — ele diz, enquanto metade do rosto já se dissolve —
    “…eu não sou o seu maior monstro.”

    A mão dele se desfaz no ar, mas a voz continua, sussurrada, ecoando como se viesse de dentro de você:

    “Ela ainda espera… no lugar onde você a deixou.”

    A escuridão o engole por completo.
    E antes que desapareça, sua última frase corta como uma confissão arrancada à força:

    “Mate-me quantas vezes quiser. Mas até encarar o que fez… você continuará sendo meu.”

    Silêncio.
    A sala fica vazia.
    Mas o peso das palavras dele… permanece.
    """
    
    print("===============BOSS FIGHT===============")
    print("Encontrou \(inimigo.nome)!")
    var atualP = personagem.vida
    var atualI = inimigo.vida
    
    while true {
        if atualP <= 0 {
            print("Voce morreu. Fim de jogo.")
            exit(0)
        }
        
        else if atualI <= 0 {
            print("")
            print("==========BOSS DERROTADO==========")
            print(morteDracula)
            print("\(inimigo.nome) derrotado!")
            print("Fim de jogo, so sobra o vazio, igual ao que restou de voce.")
            break
        }
        
        else {
            print("==============SEU TURNO==============")
            for k in personagem.ataques.keys {
                print("* \(k)", terminator: " ")
                print("")
            }
            
            let op = readLine() ?? ""
            if let dano = personagem.ataques[op] {
                var dado = rolarDado()
                print("Voce causou \(dano * (dado)) de dano!")
                atualI -= dano * (dado)
                if atualI < 0 {
                    atualI = 0
                }
                print("Vida de \(inimigo.nome): \(atualI)")
            }
            
            if atualI <= 0 {
                continue
            }
            print("==============TURNO INIMIGO==============")
            let escolherGolpe = Int.random(in: 0...2)
            let escolherFala = Int.random(in: 0...9)
            let danoInimigo = inimigo.ataques[escolherGolpe]
            print(inimigo.frases[escolherFala])
            print("\(inimigo.nome) causou \(danoInimigo) de dano!")
            atualP -= danoInimigo
            print("Sua vida: \(atualP)")
            
        }
    }
}


func play() {
    menu()
    let op = Int(readLine() ?? "0") ?? 0
    
    if op == 2 {
        exit(0)
    }
    
    else {
        historia()
        let personagem = criarPersona()
        let vampiro = Vampiro()
        let dracula = Dracula()
        batalhaNormal(personagem: personagem, inimigo: vampiro)
        boss(personagem: personagem, inimigo: dracula)
    }
}

play()


