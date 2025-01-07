module 0x4d34ea245d17287f4f6c78627d84c0a4c1c8e6dc91c8f6434e2ea175717ebdf8::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"CHILL", b"CHILL BILL", b"Chill Bill: A cool meme token on the SUI blockchain, inspired by \"Kill Bill.\" Join the Chill Bill community for a unique blend of relaxation and excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qdxk4y514_Adqo_XLM_2pq_Jdc_W3_JNZW_3bymya_HB_Nt_Q_Esx3j_e9e0a88155.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

