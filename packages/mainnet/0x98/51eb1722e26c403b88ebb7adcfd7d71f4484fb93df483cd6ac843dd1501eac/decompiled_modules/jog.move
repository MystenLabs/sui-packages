module 0x9851eb1722e26c403b88ebb7adcfd7d71f4484fb93df483cd6ac843dd1501eac::jog {
    struct JOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOG>(arg0, 6, b"JOG", b"JogjaSUI", x"426f726e206f6e20544f4e2c2067726f77206f6e205355490a0a4a4f472069732074686520636f6d6d756e69747920746f6b656e20746861742077696c6c206272696e6720636f6d6d756e6974792062656e65666974206f66206265696e672069747320686f6c646572730a0a496e2053554920776520686f6c642120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000343341_bc94afa9c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

