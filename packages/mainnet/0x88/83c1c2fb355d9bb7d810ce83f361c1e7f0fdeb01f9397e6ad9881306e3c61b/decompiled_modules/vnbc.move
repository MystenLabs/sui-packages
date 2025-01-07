module 0x8883c1c2fb355d9bb7d810ce83f361c1e7f0fdeb01f9397e6ad9881306e3c61b::vnbc {
    struct VNBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNBC>(arg0, 9, b"VNBC", b"VNBnode coin", b"VNBC is coin of VNBnode, a group of professional validators", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VNBC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VNBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

