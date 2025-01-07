module 0x86651a35d3897705badfff5b7b7e15205b6cb17600589367c057a01a91a32d50::xar {
    struct XAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAR>(arg0, 6, b"XAR", b"XARRATHYIA", x"54686520586172726174687969612066616d696c792069732072656e6f776e656420666f72206265696e6720727574686c657373206b696c6c6572732c20726561647920746f20646f2077686174657665722069742074616b657320746f206163686965766520746865697220676f616c732e0a0a546865697220616374696f6e73206172652073796e6f6e796d6f757320776974682070726f666974206578706c6f73696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/37_d180a7020d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

