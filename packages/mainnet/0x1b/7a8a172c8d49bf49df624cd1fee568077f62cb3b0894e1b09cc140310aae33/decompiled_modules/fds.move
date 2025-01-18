module 0x1b7a8a172c8d49bf49df624cd1fee568077f62cb3b0894e1b09cc140310aae33::fds {
    struct FDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDS>(arg0, 6, b"FDS", b"SFDDSFDS", b"DSFFFDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_52320d5c6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

