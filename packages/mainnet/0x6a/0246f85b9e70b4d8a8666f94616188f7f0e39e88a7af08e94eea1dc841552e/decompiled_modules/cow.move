module 0x6a0246f85b9e70b4d8a8666f94616188f7f0e39e88a7af08e94eea1dc841552e::cow {
    struct COW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COW>(arg0, 1, b"COW", b"GIRL", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COW>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COW>>(v1);
    }

    // decompiled from Move bytecode v6
}

