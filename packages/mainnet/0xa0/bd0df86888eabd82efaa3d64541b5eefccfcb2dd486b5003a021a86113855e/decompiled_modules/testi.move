module 0xa0bd0df86888eabd82efaa3d64541b5eefccfcb2dd486b5003a021a86113855e::testi {
    struct TESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTI>(arg0, 6, b"Testi", b"Test", b"Kekhehehhe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2334_8d0e3bc797.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

