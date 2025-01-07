module 0x1920f5017b5df82163fcfc8d1b4d77e6e824748e29bd2a9ab25eb69cae447c07::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY>(arg0, 6, b"HOLY", b"Holy Cat", x"24484f4c594341542069732061207768696d736963616c20766172696174696f6e206f662074686520696e7465726e65742d66616d6f7573204e79616e204361742c2064657369676e6564207769746820616e20656e6368616e74696e672074776973742e20546869732063656c65737469616c2076657273696f6e206f662074686520706978656c6174656420706f702d7461727420626f64790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmat_Rs_Y_Vh_Ba7q_B_Ju_Rm_Boeqio_H1ys5_H6r_A_Eq_W_Ek_Wk_A8vv_FN_1cd4f29d9f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

