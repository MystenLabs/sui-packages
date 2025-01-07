module 0xd130396b0ce5d0bf7498fdabd95122b37cc6140723a968a9e30becfc6322475d::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 9, b"KAS", b"Kasper", b"1000000", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

