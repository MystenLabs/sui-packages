module 0x64148e9110d7331ad1b4803032d1c2359521422d4640b673642012000ada3c2e::aptaptaptapt {
    struct APTAPTAPTAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APTAPTAPTAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APTAPTAPTAPT>(arg0, 6, b"APTAPTAPTAPT", b"APT", b"APTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPTAPT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_i_i_012baab7cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APTAPTAPTAPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APTAPTAPTAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

