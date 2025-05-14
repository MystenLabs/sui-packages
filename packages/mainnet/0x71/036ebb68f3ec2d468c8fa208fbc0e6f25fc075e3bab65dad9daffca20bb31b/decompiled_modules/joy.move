module 0x71036ebb68f3ec2d468c8fa208fbc0e6f25fc075e3bab65dad9daffca20bb31b::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY", b"YOUR MONEY HAPPY PILL", b"Joy is a positive emotion characterized by feelings of happiness, delight, and contentment, often arising from meaningful experiences, achievements, or connections with others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwcfc3qoqvmnugha4aonbi4p2iftcbklfl3vb5ftjphmmcn6f6ma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

