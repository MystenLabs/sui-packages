module 0x60736cb6a9961c8c3b82c3de712b8c18fd382376cf4bc22d1616881622154445::ract {
    struct RACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACT>(arg0, 6, b"RACT", b"Ract by Matt Furie", x"4d6565742074686520524143542c207468652063617420776974682061747475747564652e20496e737069726564206279206c6567656e64617279206d656d652063686172616374657273204d61747420467572696520636861726163746572205241435420676f7420697473206f776e207477697374e280947468696e6b206f662061206d697363686965766f75732c2063756e6e696e67206361742074686174e280997320616c77617973206f6e6520737465702061686561642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731409141840.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

