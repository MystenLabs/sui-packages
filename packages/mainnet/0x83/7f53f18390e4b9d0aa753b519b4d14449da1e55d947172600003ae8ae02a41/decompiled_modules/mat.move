module 0x837f53f18390e4b9d0aa753b519b4d14449da1e55d947172600003ae8ae02a41::mat {
    struct MAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAT>(arg0, 9, b"MAT", b"Matrix", b"MAT TEST", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAT>(&mut v2, 69420000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

