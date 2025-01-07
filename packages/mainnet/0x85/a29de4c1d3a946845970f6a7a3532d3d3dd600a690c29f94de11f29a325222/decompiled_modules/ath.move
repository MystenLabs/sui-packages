module 0x85a29de4c1d3a946845970f6a7a3532d3d3dd600a690c29f94de11f29a325222::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"ATH 100K", b"BTC ATH 100K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4c144e85_2a31_412f_9f2d_8299a66cd476_eb8f8bab48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

