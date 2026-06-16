module 0xf46db6423a63236ec515d2d06a0c929a419be0af1e30b8066e3d291302cabd3a::hXBTC {
    struct HXBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HXBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HXBTC>(arg0, 8, b"hXBTC", b"hXBTC Coin", b"hXBTC Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hxbtc_c956b372c6_93788.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HXBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HXBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

