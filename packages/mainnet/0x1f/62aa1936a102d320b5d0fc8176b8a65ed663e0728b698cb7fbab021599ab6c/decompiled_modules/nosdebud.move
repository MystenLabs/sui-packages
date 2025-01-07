module 0x1f62aa1936a102d320b5d0fc8176b8a65ed663e0728b698cb7fbab021599ab6c::nosdebud {
    struct NOSDEBUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSDEBUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSDEBUD>(arg0, 6, b"NOSDEBUD", b"NOSEBUD's", b"BIG NOSE DOG on Sui. wait did he say nose?| $NOSEBUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D8w_Ls_Sr9x_Fa8v_S96t_MK_1rvck_Q_Ro_Eb_H5_XL_Rhq_M_Ro_X_Tb_Ur_2351c935ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSDEBUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOSDEBUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

