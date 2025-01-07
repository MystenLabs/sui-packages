module 0xfe48e6b9980a637784cfdfb3c8e7411b0d81eb2f6ca60f86e982f6b3bf521661::kkgnx {
    struct KKGNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKGNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKGNX>(arg0, 6, b"KKGNX", b"KING KENDRICK", b"First MUSICOIN EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_Ab9fga8_AA_0_Q_Gr_9cddbd6ec3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKGNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKGNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

