module 0xf8c3be97a6e6d1d14c3f6669f1408d5005d86ced5806204dd4a904546712f055::ones {
    struct ONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONES>(arg0, 6, b"ONES", b"#1 SUI", b"SUI Community Hat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000172_7aa70698f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

