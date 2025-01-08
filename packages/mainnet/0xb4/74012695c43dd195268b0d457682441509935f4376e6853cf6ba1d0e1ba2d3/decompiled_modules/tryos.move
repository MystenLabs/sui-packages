module 0xb474012695c43dd195268b0d457682441509935f4376e6853cf6ba1d0e1ba2d3::tryos {
    struct TRYOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYOS>(arg0, 9, b"TRYOS", b"TRYB", b"SDs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYOS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

