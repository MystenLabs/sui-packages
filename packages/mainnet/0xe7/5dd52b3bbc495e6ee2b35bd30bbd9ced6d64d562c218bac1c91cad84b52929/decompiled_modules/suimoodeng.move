module 0xe75dd52b3bbc495e6ee2b35bd30bbd9ced6d64d562c218bac1c91cad84b52929::suimoodeng {
    struct SUIMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOODENG>(arg0, 6, b"SuiMooDeng", b"Sui Moo Deng", b"Your Favorite Hippo now ON #SUINETWORK, DOXXEDD DEV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Moo_Deng_67d397d770.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

