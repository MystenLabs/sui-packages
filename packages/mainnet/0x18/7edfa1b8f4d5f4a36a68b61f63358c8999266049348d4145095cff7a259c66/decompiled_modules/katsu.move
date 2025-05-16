module 0x187edfa1b8f4d5f4a36a68b61f63358c8999266049348d4145095cff7a259c66::katsu {
    struct KATSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATSU>(arg0, 6, b"KATSU", b"SUIKATSU", b"KATSU THE NEXT X100?! IM THE POWER OF X1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia77naxvrur77swijnsukbgrqx4gctmbbiwpyh3cofk4kuxowuaim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KATSU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

