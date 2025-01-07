module 0x16cc1afb669e303bc5aec239118c91471ffbabf9aea7879147ee428e81530abd::dud {
    struct DUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUD>(arg0, 6, b"DUD", b"Hop Aggrevator", b"It works just try again. Refresh. Restart. Refresh.Close apps. Refresh.Restart.Refresh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8877_b7fd116f56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

