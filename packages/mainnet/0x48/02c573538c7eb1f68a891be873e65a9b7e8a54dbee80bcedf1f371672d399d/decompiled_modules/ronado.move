module 0x4802c573538c7eb1f68a891be873e65a9b7e8a54dbee80bcedf1f371672d399d::ronado {
    struct RONADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONADO>(arg0, 6, b"RONADO", b"CRISTIANO RONADO", x"4920414d20524f4e41444f0a492057494e204555524f530a4920414d20504f52545547410a5355554949494949", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmf9wTVZEsGyiXDGzzjxgta3vtSuHPkfzoUxXZqdo5LQ8Q")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RONADO>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RONADO>(12594399885314053402, v0, v1, 0x1::string::utf8(b"https://x.com/ronadosui"), 0x1::string::utf8(b"https://ronado.lol"), 0x1::string::utf8(b"https://t.me/ronadosui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

