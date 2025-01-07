module 0xab26499520c6920bc280d9a8831fcaf83f17a6effa6fa25c3d1a7ada7eb28433::shallow {
    struct SHALLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHALLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHALLOW>(arg0, 6, b"Shallow", b"Shallow opposite of Deep", b"I like beeing shallow, shalla lala shallow. We the opoosite of $Deep. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000_F_274901808_VOO_Gwl_Rx_Og_XKMQU_7d_S_Bo_JW_Ck_Pa_VQ_99q_V_d4292a803c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHALLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHALLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

