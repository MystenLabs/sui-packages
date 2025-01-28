module 0x83f83da5650045796706b00f00e6532cd51d103e09d4f09fe714e46452b60fab::billym2k {
    struct BILLYM2K has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLYM2K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLYM2K>(arg0, 9, b"BillyM2k", b"Shibetoshi Nakamoto ", x"7468652064756d626173732077686f206d61646520646f6765636f696e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfKZYcPqP3EHubZDKQ448C3Sx7sfVWovDh3EPMUdkiU7o")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BILLYM2K>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLYM2K>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLYM2K>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

