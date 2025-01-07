module 0x15044a6efe88223669952ae1dfd9bfa1d46267ec68403eb34f18830eb23267a2::ducx {
    struct DUCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCX>(arg0, 6, b"DUCX", b"Ducx", x"24445543582069732061206d656d6520636f696e206372656174656420746f20637265617465206368616e676520696e20746865206d656d65636f696e20776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qdx_V2_MM_9u_NTGJDXYU_Xdp_Rfg_T_Ceh_S9_UW_2og7n_Gm4_Mprvg_d9b73d4e9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

