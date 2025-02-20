module 0x48d9a1b432f25dd6e4f271252d259d491d723b5675a98ab3c4b990526ec14b0c::st_sbuck {
    struct ST_SBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_SBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_SBUCK>(arg0, 9, b"syST_SBUCK", b"SY ST_SBUCK", b"SY Staked SBUCK", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST_SBUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_SBUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

