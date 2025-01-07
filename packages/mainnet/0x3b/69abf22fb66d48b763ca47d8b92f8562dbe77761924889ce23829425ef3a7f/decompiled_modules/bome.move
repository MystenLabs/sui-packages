module 0x3b69abf22fb66d48b763ca47d8b92f8562dbe77761924889ce23829425ef3a7f::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 9, b"BOME", b"BOOK OF MEME SUI", b"Memecoin on the most Degen Suichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmRGmFU7rh16UQ3hwopBSPao479ubQxfxRP51yMgRwTtkC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

