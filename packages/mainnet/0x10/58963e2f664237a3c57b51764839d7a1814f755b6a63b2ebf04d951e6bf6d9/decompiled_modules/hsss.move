module 0x1058963e2f664237a3c57b51764839d7a1814f755b6a63b2ebf04d951e6bf6d9::hsss {
    struct HSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSSS>(arg0, 6, b"HSSS", b"Happy Self Sucking Snake", x"546869732073617373792073657270656e742073656c662066656c6c6174657320746f20737563636573730a0a48617320436f6d70756e64696e67204175746f2046656c6c6174696f20546f6b656e6f6d696373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sassy_snake_3069148d4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

