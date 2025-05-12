module 0x88931fbf32362ec70b637fbe44564dcc16bbb3f877863532c3ccaca40230711c::calty {
    struct CALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALTY>(arg0, 6, b"CALTY", b"CALTYCAP", b"Our mission is to create the most community-driven meme token in the SUI ecosystem, where everyone can build, grow, and earn together. We aim to provide a fun, transparent, and inclusive space where every member contributes to shaping the future of CALTYCAP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqensoohuzgkyuaezlocm2wsoiaih5me3jyofqlrgevxv6pry5uu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CALTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

