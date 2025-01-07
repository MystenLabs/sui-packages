module 0xca6526ff3163f581dee8a08f6ddbf5bf9a9594de7f93514852d94abfe15fef92::nosebud {
    struct NOSEBUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSEBUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSEBUD>(arg0, 6, b"NOSEBUD", b"Nose Bud", b"Imagine the smell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D8w_Ls_Sr9x_Fa8v_S96t_MK_1rvck_Q_Ro_Eb_H5_XL_Rhq_M_Ro_X_Tb_Ur_ff5f8b81d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSEBUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOSEBUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

