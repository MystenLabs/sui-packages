module 0x58d97de074c467af8d18e5057ea53e4003a46033a4faa096c713ec85d5e688f9::gang {
    struct GANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANG>(arg0, 9, b"GANG", b"THUG LIFE", b"Bring back the memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXhufDfYvHxGqzadVmndVpeW9VRTbWCusfyB2mhK2h5W6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GANG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

