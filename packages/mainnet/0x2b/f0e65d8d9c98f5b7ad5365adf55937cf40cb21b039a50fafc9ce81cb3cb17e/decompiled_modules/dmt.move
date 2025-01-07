module 0x2bf0e65d8d9c98f5b7ad5365adf55937cf40cb21b039a50fafc9ce81cb3cb17e::dmt {
    struct DMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMT>(arg0, 6, b"DMT", b"dmt", x"444d5420546f6b656e2020746865206d6f73742070737963686564656c696320746f6b656e20696e207468652077686f6c652063727970746f20636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DMT_TLZA_7d_vnz_O7_Ev_Lh_JGW_a778c9260c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

