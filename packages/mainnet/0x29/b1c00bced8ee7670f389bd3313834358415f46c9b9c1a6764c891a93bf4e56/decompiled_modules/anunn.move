module 0x29b1c00bced8ee7670f389bd3313834358415f46c9b9c1a6764c891a93bf4e56::anunn {
    struct ANUNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANUNN>(arg0, 9, b"ANUNN", b"ANUNNAKI", b"ai trading token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmXTk48xKDPPHG36aQxSGRYpkQ8ajbRkYWRGgjwzdBfeH5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANUNN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUNN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

