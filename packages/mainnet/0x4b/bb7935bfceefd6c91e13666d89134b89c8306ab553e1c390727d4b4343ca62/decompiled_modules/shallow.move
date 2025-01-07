module 0x4bbb7935bfceefd6c91e13666d89134b89c8306ab553e1c390727d4b4343ca62::shallow {
    struct SHALLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHALLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHALLOW>(arg0, 6, b"Shallow", b"Shallow the opposite of Deep", b"In the sha-ha, sha-ha-llow - we are the opposite of DEEP. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000_F_274901808_VOO_Gwl_Rx_Og_XKMQU_7d_S_Bo_JW_Ck_Pa_VQ_99q_V_dc5cda08e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHALLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHALLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

