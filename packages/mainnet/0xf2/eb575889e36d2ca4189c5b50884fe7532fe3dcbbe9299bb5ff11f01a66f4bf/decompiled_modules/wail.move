module 0xf2eb575889e36d2ca4189c5b50884fe7532fe3dcbbe9299bb5ff11f01a66f4bf::wail {
    struct WAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIL>(arg0, 6, b"WAIL", b"WAILORD", x"5761696c6f7264206973206f6e65206f6620746865206c61726765737420506f6bc3a96d6f6e20746f2068617665206265656e20646973636f76657265642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd3axogshpg5j6zjndclqjfxxyfvryvjkyiqfe4o4fmnoxr4gek4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

