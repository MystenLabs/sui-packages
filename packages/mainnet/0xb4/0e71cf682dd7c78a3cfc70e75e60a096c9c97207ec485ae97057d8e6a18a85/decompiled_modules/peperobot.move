module 0xb40e71cf682dd7c78a3cfc70e75e60a096c9c97207ec485ae97057d8e6a18a85::peperobot {
    struct PEPEROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEROBOT>(arg0, 6, b"PEPEROBOT", b"Peperobot", b"$Peperobot belongs to the entire community, and the development team will give up control after initialization.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEROBOT>>(v1);
        0x2::coin::mint_and_transfer<PEPEROBOT>(&mut v2, 420690000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPEROBOT>>(v2);
    }

    // decompiled from Move bytecode v6
}

