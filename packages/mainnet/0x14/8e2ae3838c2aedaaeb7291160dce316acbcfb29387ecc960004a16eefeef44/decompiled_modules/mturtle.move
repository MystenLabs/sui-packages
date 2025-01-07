module 0x148e2ae3838c2aedaaeb7291160dce316acbcfb29387ecc960004a16eefeef44::mturtle {
    struct MTURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTURTLE>(arg0, 6, b"MTURTLE", b"Mbappe turtle", x"4b796c69616e206d656d650a48616c61204d616472696420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062519_4444e237e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTURTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTURTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

