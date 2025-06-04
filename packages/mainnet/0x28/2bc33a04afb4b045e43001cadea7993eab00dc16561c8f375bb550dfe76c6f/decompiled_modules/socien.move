module 0x282bc33a04afb4b045e43001cadea7993eab00dc16561c8f375bb550dfe76c6f::socien {
    struct SOCIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCIEN>(arg0, 6, b"SOCIEN", b"Socien sui", b"So", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihefl4evjnajsh2hnbdv5mgai2meqq5wuierp5ypmu555ys4g7vta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOCIEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

