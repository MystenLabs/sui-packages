module 0xd61402156b16fa0a5dd81065e0c633cda7fb378eb3ca82f63b7480b9760537f3::meowl {
    struct MEOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWL>(arg0, 9, b"MEOWL", b"NVDA Cat", b"Viral Cat inside NVDA Box https://x.com/old_memory/status/2096333803308417351?s=46&t=BJWO9Wlnw9pVsCejvY6_0w.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/e1913229a3117f71e37f6e4a60b47c7dbcea1e6ee4681603330d86d61f78283e")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MEOWL>>(0x2::coin::mint<MEOWL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWL>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

