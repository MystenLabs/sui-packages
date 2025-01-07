module 0xbd8ca372ed85a5b15ceac2ab771ea0ea65940855282edbd5aba52acd746e70ff::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIN", b"SUI NIGGA", b"DEXes over CEXes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUH69sCoZCiubx9NyHQjgu787tPk44oVDZeE4VPbUCb6B")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIN>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIN>(14472058349443983631, v0, v1, 0x1::string::utf8(b"https://x.com/SuiGigga_tokenhttps://x.com/SuiGigga_token"), 0x1::string::utf8(b"https://suinigga.com"), 0x1::string::utf8(b"https://t.me/suigigga"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

