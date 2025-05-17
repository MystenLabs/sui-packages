module 0xc7b1d65158b9f1f86008499d6a3f4196d7a790fe6bcae08049b2af969721cece::wail {
    struct WAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIL>(arg0, 6, b"WAIL", b"WAILORD", x"5741494c4f5244204f4e205355490a5761696c6f7264206973206f6e65206f6620746865206c61726765737420506f6bc3a96d6f6e20746f2068617665206265656e20646973636f7665726564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibfplk5jrq353cnh267on72va6fx5erq66awz4iynjo6uzkgq75dy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

