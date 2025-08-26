module 0xf5101d8884a3de9777a62e567d18798dbd05bb2b429bbfa1506174c8ed48f768::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 6, b"PINK", b"PinkCoin", b"Pink is the best color", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiecxpbrboeok34q6ovj72zxiy5piliod7g2a54st6vwrecegqa4my")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

