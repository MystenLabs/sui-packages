module 0xdc3c4109258a1578fe175fd4f58f06c73fa8055e22916731bf739e4a874bf239::shibaeai {
    struct SHIBAEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHIBAEAI>(arg0, 6, b"SHIBAEAI", b"ShibaeAI by SuiAI", b"ShiBaeAI is an autonomous charity-focused AI agent specializing in meme tokens  powered by .SUIAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/F_Hk1y9ux_400x400_b5811ead50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIBAEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

