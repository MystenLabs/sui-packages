module 0xedc8289678fed28f49ae317a9621ff2b213a3910ee105dcadf393b11e75bcdad::solar {
    struct SOLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAR>(arg0, 6, b"SOLAR", b"Solar AI", b"The Solar Conspiracy Research Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifzutu3di55bk2n7hlo5ya4jiozx5bomvewunwiizaghblyw4jxoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOLAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

