module 0xf1f1d1c3196662bf64229319c0f3d1e9ad851321f95789d1aa17123006aef528::b_steamm_lp_ble_bsui {
    struct B_STEAMM_LP_BLE_BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BLE_BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BLE_BSUI>(arg0, 9, b"bSTEAMM LP bLE-bSUI", b"bToken STEAMM LP bLE-bSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BLE_BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BLE_BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

