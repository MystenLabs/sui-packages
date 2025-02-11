module 0x6616e9f9227b8a7f5f7e13f783b9023b48fc2c1de954cd307ccc3664a3e38f34::kish {
    struct KISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISH>(arg0, 6, b"KISH", b"Kinky Fish", b"Kinky Fish loves to swim with the Sui waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_25_02_10_23_20_42_603_07f293bfee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

