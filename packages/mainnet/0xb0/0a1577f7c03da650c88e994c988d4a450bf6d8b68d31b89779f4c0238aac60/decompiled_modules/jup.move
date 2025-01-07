module 0xb00a1577f7c03da650c88e994c988d4a450bf6d8b68d31b89779f4c0238aac60::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 9, b"JUP", b"JUPITER", b"Buy $JUP where you actually can", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jup.ag/svg/jupuary-cat.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUP>(&mut v2, 10000000420000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

