module 0xf314c748ff7b726d2016316af9c6d03269a281b951bf37b9389b3f6b42ce1ff5::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTT>(arg0, 6, b"TESTT", b"TEST", b"TEST123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiduexibnjfpuuuvlj2ptcbr2xprq3ec6bbk3xhsbku4a2nxuosyty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

