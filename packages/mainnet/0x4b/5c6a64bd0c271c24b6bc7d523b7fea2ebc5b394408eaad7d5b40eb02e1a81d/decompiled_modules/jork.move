module 0x4b5c6a64bd0c271c24b6bc7d523b7fea2ebc5b394408eaad7d5b40eb02e1a81d::jork {
    struct JORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORK>(arg0, 9, b"JORK                              ", b"John Pork                                                         ", b"The greatest                                                                                                                                                                                                                                                                                                                                                                                                                                                          ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flopfun.com/icon/608499b3-765b-48de-96f9-3e313c4f9421.png                                                                                                                                                   ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

