module 0x7a2b93cded2d073e2c9939968278951f3ea0015da5ff2dd61e52e43fadedbc21::bmp {
    struct BMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMP>(arg0, 6, b"BMP", b"Blue Move Pump", x"4f4646494349414c20424c55454d4f564520544f4b454e204f4e204d4f564550554d502e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sk_Agauhd_400x400_1_f6ce3b686e_afe2e532e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

