module 0x8010c6ae42a5009b3e5c43098b2affeec00e7766c5778f69ab5e172aeb92ccaf::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"deptofgovtefficiency", b"The Department of Government Efficiency, proposed by Donald Trump, would be led by Elon Musk to audit federal spending, reduce waste, and propose reforms to enhance government performance, reflecting their recent political alliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731494449633.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

