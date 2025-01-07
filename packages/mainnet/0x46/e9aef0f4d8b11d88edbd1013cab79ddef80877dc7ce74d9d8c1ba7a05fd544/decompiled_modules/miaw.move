module 0x46e9aef0f4d8b11d88edbd1013cab79ddef80877dc7ce74d9d8c1ba7a05fd544::miaw {
    struct MIAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAW>(arg0, 6, b"MIAW", b"miaw on sui", b"$MIAW GOES TO SUI CHAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silly_cat_bc620c9a69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

