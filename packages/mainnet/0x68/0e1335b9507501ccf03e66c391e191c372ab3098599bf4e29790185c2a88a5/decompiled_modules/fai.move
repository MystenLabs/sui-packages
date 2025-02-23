module 0x680e1335b9507501ccf03e66c391e191c372ab3098599bf4e29790185c2a88a5::fai {
    struct FAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAI>(arg0, 6, b"FAI", b"Forexai", x"466f72657820414920284641492920e280932054686520436f696e2053686170696e672074686520467574757265206f6620466f7265782054726164696e670a0a466f72657820414920284641492920697320612070696f6e656572696e6720636f696e207468617420636f6d62696e6573206172746966696369616c20696e74656c6c6967656e636520616e6420666f7265782074726164696e672c206272696e67696e67206120736d6172742c207472616e73706172656e7420616e64206175746f6d617465642065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/73fa5bfd-8285-4b1b-a492-f232768876fc.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

