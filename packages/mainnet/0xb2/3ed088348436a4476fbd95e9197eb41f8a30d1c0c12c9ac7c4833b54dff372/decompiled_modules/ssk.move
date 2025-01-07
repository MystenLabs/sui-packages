module 0xb23ed088348436a4476fbd95e9197eb41f8a30d1c0c12c9ac7c4833b54dff372::ssk {
    struct SSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSK>(arg0, 9, b"SSK", b"Sisika", b"1M CAP SOON", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSK>(&mut v2, 7676767000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

