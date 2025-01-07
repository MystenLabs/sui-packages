module 0x4b313340fc48063178b97df5175cd4caecba6eef9402e871297277466a2c0adf::adrian {
    struct ADRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADRIAN>(arg0, 6, b"Adrian", b"AdrianDoge", b"Adrian is the best mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_4963333953687760422_y_c9a227a0af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

