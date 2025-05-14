module 0x3d04e2c6e2e22855ee8f4fe6fa6f01e13a5d1f161bc553298cc1c5cac0c5c9bb::sHAEDAL {
    struct SHAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAEDAL>(arg0, 6, b"sysHAEDAL", b"SY sHAEDAL", b"SY scallop sHAEDAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

