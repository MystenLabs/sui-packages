module 0xc6080ea0090c4946c3f6b30888273e8b3189062d130632257d01febf17e1f86e::d {
    struct D has drop {
        dummy_field: bool,
    }

    fun init(arg0: D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D>(arg0, 6, b"D", b"d", b"d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/0624886a312014f9f5286b71806e01d09af87d9234569486bc31ae120f5f96ac.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<D>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

