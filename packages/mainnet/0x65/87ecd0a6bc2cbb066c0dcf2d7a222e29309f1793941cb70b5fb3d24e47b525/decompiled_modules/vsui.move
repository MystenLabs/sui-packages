module 0x6587ecd0a6bc2cbb066c0dcf2d7a222e29309f1793941cb70b5fb3d24e47b525::vsui {
    struct VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSUI>(arg0, 6, b"vSUI", b"vSUI", b"Volo's SUI staking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/sui-vsui-0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT.png/type=png_350_0?x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSUI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VSUI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

