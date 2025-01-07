module 0x962fee34e9c7095bc98fdd5b05005994572e89d3db641aed0301a04657b5215::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"Dept Govt Efficiency", b"The Department Of Government Efficiency i(D.O.G.E) is the brainchild of Elon Musk and Donald Trump. Trump has appointed Musk to head the Department and reign in US Government spending and waste. We support this initiative and plan to bring awareness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731213406544.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

