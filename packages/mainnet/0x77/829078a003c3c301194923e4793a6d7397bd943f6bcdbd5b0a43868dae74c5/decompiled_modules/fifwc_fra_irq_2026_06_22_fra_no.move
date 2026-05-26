module 0x77829078a003c3c301194923e4793a6d7397bd943f6bcdbd5b0a43868dae74c5::fifwc_fra_irq_2026_06_22_fra_no {
    struct FIFWC_FRA_IRQ_2026_06_22_FRA_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFWC_FRA_IRQ_2026_06_22_FRA_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFWC_FRA_IRQ_2026_06_22_FRA_NO>(arg0, 0, b"FIFWC_FRA_IRQ_2026_06_22_FRA_NO", b"FIFWC_FRA_IRQ_2026_06_22_FRA NO", b"FIFWC_FRA_IRQ_2026_06_22_FRA NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIFWC_FRA_IRQ_2026_06_22_FRA_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFWC_FRA_IRQ_2026_06_22_FRA_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

