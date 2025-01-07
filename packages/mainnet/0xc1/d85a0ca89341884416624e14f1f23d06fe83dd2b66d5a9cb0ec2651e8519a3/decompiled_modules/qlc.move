module 0xc1d85a0ca89341884416624e14f1f23d06fe83dd2b66d5a9cb0ec2651e8519a3::qlc {
    struct QLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QLC>(arg0, 6, b"QLC", b"Quantum Leap Cat", x"4a7573742061204361742074616b696e6720746865205175616e74756d204c656170207468726f756768204172746966696369616c20496e74656c6c6967656e63652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbm_DD_2d_GM_Kd8n_A8s_Y9o3k5_Nf_PHR_5_VZ_Kgh_WV_2_B_Zh_Xg_Gsm_K_0c8ac1b391.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

