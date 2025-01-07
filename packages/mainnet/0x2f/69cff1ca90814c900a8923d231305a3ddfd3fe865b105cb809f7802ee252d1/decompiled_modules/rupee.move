module 0x2f69cff1ca90814c900a8923d231305a3ddfd3fe865b105cb809f7802ee252d1::rupee {
    struct RUPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUPEE>(arg0, 6, b"RUPEE", b"Sui Rupee", x"546865206e6f7374616c6769632052555045452066726f6d204c6567656e64206f66205a656c64612c206e6f77206f6e20737569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X67v_Hw_YM_Tg2_Q_Sfjq_LRF_Bw_ZS_1ca4_Y9v_A_Dd7_P_Qt_FJG_Aq8_Q_0f543219f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUPEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUPEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

