module 0x259f8aeed27b6cb65c0d9364b8244283fa7b9704b84bee3faf974b066d1be698::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    public fun update_name(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: &mut 0x2::coin::CoinMetadata<DUCK>, arg2: 0x1::string::String) {
        0x2::coin::update_name<DUCK>(arg0, arg1, arg2);
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"duck chen", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUCK>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DUCK>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

