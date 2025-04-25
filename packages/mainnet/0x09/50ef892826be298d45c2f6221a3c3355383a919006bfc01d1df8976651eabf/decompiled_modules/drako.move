module 0x950ef892826be298d45c2f6221a3c3355383a919006bfc01d1df8976651eabf::drako {
    struct DRAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAKO>(arg0, 6, b"Drako", b"Drako Dragon", b"Drako The Dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9606_38277dcc2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

