module 0xcb3faf74e0ae8f4dda4f81ba8deb0470ae68edda833403b9576637eb7e4ae72f::tcoin {
    struct TCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCOIN>(arg0, 6, b"TCOIN", b"titcoin", b"Breast Mode On", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihe2fozwgrnd75ttwhjnesqjcl2qpzn63u54j7ail2esyrxsle24i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

