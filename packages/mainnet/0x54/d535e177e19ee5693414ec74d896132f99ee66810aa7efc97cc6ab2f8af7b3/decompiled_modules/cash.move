module 0x54d535e177e19ee5693414ec74d896132f99ee66810aa7efc97cc6ab2f8af7b3::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 1, b"CASH", b"CASH", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CASH>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

