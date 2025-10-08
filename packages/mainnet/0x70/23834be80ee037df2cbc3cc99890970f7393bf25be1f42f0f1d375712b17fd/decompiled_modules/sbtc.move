module 0x7023834be80ee037df2cbc3cc99890970f7393bf25be1f42f0f1d375712b17fd::sbtc {
    struct SBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTC>(arg0, 6, b"SBTC", b"SUI BTC", b"Bitcoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie7ycxecupgfajf2zbzhjupdwkf55xih3d3ik32yegbw6fh6fe2t4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

