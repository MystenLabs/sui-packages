module 0x154a3b1b19b2d913a408c3043bb8ac97604ddb6da7662e8dc88a6d040180817b::bbj {
    struct BBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBJ>(arg0, 6, b"BBJ", b"BeetlejuiceJNR", b"Welcome to Beetlejuice JNR ($BJJ), the mischievous and long-forgotten son of the original Beetlejuice, rising from the underworld to make his mark on the crypto universe. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yg_X8_XE_Ghebix_BRL_Kw5xt6w2jyjis_Vphfg_B9_H7_Ww_C1_D2_H_7b528f618d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

