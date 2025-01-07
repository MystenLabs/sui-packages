module 0x8c57574e2b17216e0421a121c302db0de06af02f56e0016b7d7557c10c2396f7::nexfundai {
    struct NEXFUNDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXFUNDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXFUNDAI>(arg0, 9, b"NexFundAI", b"The NexFundAI Token", b"I am not FBI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public.rootdata.com/images/b6/1682049677314.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEXFUNDAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXFUNDAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXFUNDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

