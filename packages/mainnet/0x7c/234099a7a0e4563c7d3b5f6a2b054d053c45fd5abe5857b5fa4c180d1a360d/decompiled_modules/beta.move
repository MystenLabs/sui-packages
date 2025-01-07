module 0x7c234099a7a0e4563c7d3b5f6a2b054d053c45fd5abe5857b5fa4c180d1a360d::beta {
    struct BETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETA>(arg0, 9, b"BETA", b"BETA Token", b"BETA is the native token of BETAfi Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7taj6jfau6n3dri7agspzfnva7qbj5sizz5xc3lb56nmxpsyoiba.arweave.net/_MCfJKCnm7HFHwGk_JW1B-AU9kjOe3FtYe-ay75YcgI")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BETA>>(0x2::coin::mint<BETA>(&mut v2, 1000000000000000, arg1), @0xafe1cc0a5116afed42b4abbbbb916e190292c5de7a2093a14325adff6bfc8f75);
        0x2::transfer::public_transfer<0x2::coin::Coin<BETA>>(0x2::coin::mint<BETA>(&mut v2, 500000000000000, arg1), @0x66711c4ddb2c8e432a75ee189653075eb9e48cd654eea683543d77db85a66a74);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

