module 0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin {
    struct LIHUAZHANG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIHUAZHANG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIHUAZHANG_FAUCET_COIN>>(0x2::coin::mint<LIHUAZHANG_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LIHUAZHANG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIHUAZHANG_FAUCET_COIN>(arg0, 9, b"LC FAUCET", b"Lihuazhang Faucet Coin", b"Lihuazhang Faucet Coin Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://testerhome.com/photo/2015/f4a07b35098dc28fa3e4269c8af2fc7b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIHUAZHANG_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LIHUAZHANG_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

