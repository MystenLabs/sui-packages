module 0xd465376dbaa7e8e789d70f02e62a0798b3c846b9433869b823b0d2e092d85e12::i_love_you {
    struct I_LOVE_YOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: I_LOVE_YOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I_LOVE_YOU>(arg0, 9, b"I LOVE YOU", x"e29da4efb88f49206c6f766520796f75", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<I_LOVE_YOU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I_LOVE_YOU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<I_LOVE_YOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

