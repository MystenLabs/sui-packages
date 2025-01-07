module 0x8d14648eb9a52c6eeea2d27065a6bd0b205d54fd67635b07ff6c78ffbad971b2::testtoken {
    struct TESTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTOKEN>(arg0, 9, b"TT", b"Testtoken", b"Platform Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUHi2fr7CWu44wC5u4PzTrpx3tJepEzwmEXCm5PAakyG2?filename=Screenshot%202024-04-14%20at%206.18.30%E2%80%AFPM.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TESTTOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

