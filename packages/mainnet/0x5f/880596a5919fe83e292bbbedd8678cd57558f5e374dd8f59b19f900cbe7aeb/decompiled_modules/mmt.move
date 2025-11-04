module 0x5f880596a5919fe83e292bbbedd8678cd57558f5e374dd8f59b19f900cbe7aeb::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMT>(arg0, 9, b"MMT", b"0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT", b"Building a global financial OS for the tokenized future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1976883709367533568/6oqQH_QQ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MMT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

