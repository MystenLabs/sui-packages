module 0x4378682be095ef924796e5149aadd67171fc19e387b35fe53cd2f9c48b1b7d85::suimaxi {
    struct SUIMAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAXI>(arg0, 9, b"SUIMAXI", b"hello world", x"1112131112131112131112", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/7QP2s1ruSLH4Fdze4w60OyscH_hBobyQv_KOHnWe9vk")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUIMAXI>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

