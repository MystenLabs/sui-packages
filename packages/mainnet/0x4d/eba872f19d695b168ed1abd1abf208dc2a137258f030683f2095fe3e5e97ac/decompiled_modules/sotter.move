module 0x4deba872f19d695b168ed1abd1abf208dc2a137258f030683f2095fe3e5e97ac::sotter {
    struct SOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTTER>(arg0, 6, b"SOTTER", b"Sui Sotter", b"Sui mascot otter SOTTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigpwze2quohxj3bx3xs6fbd7mdwvzix6q5zl2xoq63675almjnst4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOTTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

