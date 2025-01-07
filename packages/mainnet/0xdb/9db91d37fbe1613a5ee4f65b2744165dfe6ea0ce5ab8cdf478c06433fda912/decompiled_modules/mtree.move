module 0xdb9db91d37fbe1613a5ee4f65b2744165dfe6ea0ce5ab8cdf478c06433fda912::mtree {
    struct MTREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTREE>(arg0, 6, b"MTREE", b"MONEY TREE ON SUI", b"GROW YOUR ASSETS EFFORTLESSLY WITH THE $TREE  BY MATT FURIE FRM THE BOOK MINDVISCOSITY & HEDZ COLLECTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Cvg_Axhm_400x400_99761499b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

