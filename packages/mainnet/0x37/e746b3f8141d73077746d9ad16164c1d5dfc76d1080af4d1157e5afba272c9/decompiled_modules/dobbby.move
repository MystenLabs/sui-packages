module 0x37e746b3f8141d73077746d9ad16164c1d5dfc76d1080af4d1157e5afba272c9::dobbby {
    struct DOBBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBBBY>(arg0, 6, b"DOBBBY", b"Dobby", x"5468697320697320446f6262792c20696620796f7520646f6e2774206b6e6f772068696d2e2e2e2077656c6c207768657265206861766520796f75206265656e3f0a496620796f752061726520612048502066616e207468656e20796f752061726520696e2074686520726967687420706c616365210a436f6d6520616e64204a6f696e206f757220636f6d6d756e69747920616e64206d617962652e2e2e6769626520446f62626279206120736f636b3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_287263cda9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

