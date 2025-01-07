module 0xc88d3b3d5f29c44f56812b5bf4e225e7eff89ed60db3a69b7358aee0d87f76d1::bhippo {
    struct BHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHIPPO>(arg0, 9, b"BHIPPO", b"Baby HIPPO", b"baby Hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BHIPPO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

