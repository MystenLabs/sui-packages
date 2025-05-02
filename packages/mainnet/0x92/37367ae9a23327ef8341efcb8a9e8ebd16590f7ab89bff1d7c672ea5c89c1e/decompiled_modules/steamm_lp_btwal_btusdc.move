module 0x9237367ae9a23327ef8341efcb8a9e8ebd16590f7ab89bff1d7c672ea5c89c1e::steamm_lp_btwal_btusdc {
    struct STEAMM_LP_BTWAL_BTUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAMM_LP_BTWAL_BTUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAMM_LP_BTWAL_BTUSDC>(arg0, 9, b"STEAMM LP btWAL-btUSDC", b"STEAMM LP Token btWAL-btUSDC", b"STEAMM LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+LP+Token.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAMM_LP_BTWAL_BTUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAMM_LP_BTWAL_BTUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

