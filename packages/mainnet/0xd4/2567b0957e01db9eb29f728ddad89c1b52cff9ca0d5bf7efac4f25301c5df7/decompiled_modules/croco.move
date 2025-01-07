module 0xd42567b0957e01db9eb29f728ddad89c1b52cff9ca0d5bf7efac4f25301c5df7::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"croco", b"Hello I am croco!! nice to meet you $croco.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmai_Qcywpwnwq_Q_Wfrddi_CMM_Tx_Ui_Krvod8_Bvv_UZ_Pq_XX_Np_Jj_3db45facf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

