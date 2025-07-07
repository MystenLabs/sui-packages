module 0x4e0c79f55808d16b98cae171a80125bd6a507f464fb2f7f1bd1f4fa6f3adc9d2::hsss {
    struct HSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSSS>(arg0, 6, b"HSSS", b"Happy Self Sucking Snake", x"546869732073617373792073657270656e742073656c662066656c6c6174657320746f20737563636573730a0a2d48617320636f6d706f756e64696e67206175746f66656c6c6174696f20746f6b656e6f6d69637320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sassy_snake_98dce39c12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

