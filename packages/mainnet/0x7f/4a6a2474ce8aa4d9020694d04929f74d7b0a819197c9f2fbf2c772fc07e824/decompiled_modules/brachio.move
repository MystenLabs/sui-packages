module 0x7f4a6a2474ce8aa4d9020694d04929f74d7b0a819197c9f2fbf2c772fc07e824::brachio {
    struct BRACHIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRACHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRACHIO>(arg0, 6, b"BRACHIO", b"Brachio Sui", x"4920616d2061206865726269766f72652e20427574207468617420646f65736e2774206d65616e20692063616e2774206b696c6c20796f752e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Jgbd_Us3d_K_Fn5i_Qtpve8vi_F_Dt6wtru7_R4rqm_S4_N_Gk_STZ_b4f24581a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRACHIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRACHIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

