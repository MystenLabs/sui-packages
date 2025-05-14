module 0x67e7c7daeddc7cb9f5e5d2bb83112cf3944bfc9a24ebb6d608280515a010cc2::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"Test", b"Do not buy this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidy63fcwsnz5l274ywt34ed3b33jlxuvvcrbkzioxzydbguwolno4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

