module 0xa82d051014dda7cb2a8475e469ffa9d3bc8606888398121e64581d42029bee69::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"Penguin", x"4a7573742061206375746520616e6420636c756d737920697474792062697474792070656e6775696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q87jh_WDB_6_QLJ_6_AA_Hf6_K6e_R56fh82u_F_Rxi_Lh3_LW_Tc_Yw64_1de10b55e5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

