module 0x2f072125dd5ded41266fe9b77fd601864d8c93d5c187a234cfc4d616125d1b1::tsetaha {
    struct TSETAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSETAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSETAHA>(arg0, 6, b"tsetaha", b"testesgtasdgad", b"hahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcaWyTUpHqPAcgWum4mSELpMRmmEYsYvWe2wmdvknDFCk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSETAHA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSETAHA>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSETAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

