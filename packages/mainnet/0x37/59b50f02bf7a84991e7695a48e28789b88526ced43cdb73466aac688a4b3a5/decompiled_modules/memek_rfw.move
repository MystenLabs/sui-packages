module 0x3759b50f02bf7a84991e7695a48e28789b88526ced43cdb73466aac688a4b3a5::memek_rfw {
    struct MEMEK_RFW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFW>(arg0, 6, b"MEMEKRFw", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFW>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFW>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

