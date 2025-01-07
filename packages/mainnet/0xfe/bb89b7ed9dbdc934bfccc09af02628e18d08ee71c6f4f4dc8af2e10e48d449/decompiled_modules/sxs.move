module 0xfebb89b7ed9dbdc934bfccc09af02628e18d08ee71c6f4f4dc8af2e10e48d449::sxs {
    struct SXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXS>(arg0, 9, b"SXS", b"SEXYS6", b"SEXYS6", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SXS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SXS>>(v1);
    }

    // decompiled from Move bytecode v6
}

