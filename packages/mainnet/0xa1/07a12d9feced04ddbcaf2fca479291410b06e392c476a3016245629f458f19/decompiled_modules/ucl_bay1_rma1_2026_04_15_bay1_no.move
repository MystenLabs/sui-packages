module 0xa107a12d9feced04ddbcaf2fca479291410b06e392c476a3016245629f458f19::ucl_bay1_rma1_2026_04_15_bay1_no {
    struct UCL_BAY1_RMA1_2026_04_15_BAY1_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCL_BAY1_RMA1_2026_04_15_BAY1_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCL_BAY1_RMA1_2026_04_15_BAY1_NO>(arg0, 0, b"UCL_BAY1_RMA1_2026_04_15_BAY1_NO", b"UCL_BAY1_RMA1_2026_04_15_BAY1 NO", b"UCL_BAY1_RMA1_2026_04_15_BAY1 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCL_BAY1_RMA1_2026_04_15_BAY1_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCL_BAY1_RMA1_2026_04_15_BAY1_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

