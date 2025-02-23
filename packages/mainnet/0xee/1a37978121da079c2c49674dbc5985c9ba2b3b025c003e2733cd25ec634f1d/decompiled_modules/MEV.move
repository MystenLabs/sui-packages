module 0xee1a37978121da079c2c49674dbc5985c9ba2b3b025c003e2733cd25ec634f1d::MEV {
    struct MEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEV>(arg0, 9, b"MEV", b"MEV", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEV>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEV>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEV>>(0x2::coin::mint<MEV>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

