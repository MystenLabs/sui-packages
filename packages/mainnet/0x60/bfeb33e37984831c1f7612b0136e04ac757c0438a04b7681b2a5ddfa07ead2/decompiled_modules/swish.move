module 0x60bfeb33e37984831c1f7612b0136e04ac757c0438a04b7681b2a5ddfa07ead2::swish {
    struct SWISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWISH>(arg0, 6, b"SWISH", b"swish", x"496620796f752067657420696e2074686520776174657220492077696c6c2065617420796f752e205377697368207377697368204920616d206e6175676874792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_We_Q8rt6ph_Ep89_D9m_C9gj_Y97pxydz8_Dfbv43_Dnkp_Fcy_SR_82130b6ed3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

