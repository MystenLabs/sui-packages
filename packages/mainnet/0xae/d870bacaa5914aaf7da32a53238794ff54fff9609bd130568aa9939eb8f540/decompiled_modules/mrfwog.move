module 0xaed870bacaa5914aaf7da32a53238794ff54fff9609bd130568aa9939eb8f540::mrfwog {
    struct MRFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRFWOG>(arg0, 6, b"MRFWOG", b"Mr Fwog", b"$MRFWOG Lets flip 1 sui to 1 mullion ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Sahs_Ya_Fm_Jqgq_HR_Kj_Jss_Jnft_L6_Dm_KJ_4_AW_Yo2tpkf_VF_4p_66caee42c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

