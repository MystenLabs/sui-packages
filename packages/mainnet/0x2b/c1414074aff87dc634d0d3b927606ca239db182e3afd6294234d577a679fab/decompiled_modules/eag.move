module 0x2bc1414074aff87dc634d0d3b927606ca239db182e3afd6294234d577a679fab::eag {
    struct EAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EAG>(arg0, 6, b"EAG", b"EAGLE by SuiAI", b"Meme coin for fun. only goal is to become more valuable than $DRA. Make value through the power of community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000018647_82905ff919.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EAG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

