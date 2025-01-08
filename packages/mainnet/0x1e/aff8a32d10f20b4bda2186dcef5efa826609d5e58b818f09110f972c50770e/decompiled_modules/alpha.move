module 0x53ed1d57e30287e50439d654f1d172659ff2079767303ae11b8459cd483c76fe::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"ALPHA Token", b"ALPHA is the native token of AlphaFi Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://7taj6jfau6n3dri7agspzfnva7qbj5sizz5xc3lb56nmxpsyoiba.arweave.net/_MCfJKCnm7HFHwGk_JW1B-AU9kjOe3FtYe-ay75YcgI")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHA>>(0x2::coin::mint<ALPHA>(&mut v2, 1000000000000000, arg1), @0xafe1cc0a5116afed42b4abbbbb916e190292c5de7a2093a14325adff6bfc8f75);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHA>>(0x2::coin::mint<ALPHA>(&mut v2, 500000000000000, arg1), @0xa86125653d497b4f7ced6d5543e5a7f16be948fdc3276faeed34246dfd5af2e6);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

