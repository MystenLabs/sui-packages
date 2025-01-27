module 0x4d64b027137c31dce4dec62dc7b4631299cf17ec7d6d4afcc0994b06c76a8854::suiyarn {
    struct SUIYARN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYARN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYARN>(arg0, 6, b"SUIYARN", b"SuiYarn", x"5468652067726561746e657373206f66205355495941524e20697320636f6d696e6720746f204d4f52452043656e7472616c697a65642045786368616e67657320736f6f6e210a0a5375695961726e206973206e6f74206f6e6c7920612063757465206d656d652c2062757420616c736f2061706f74656e7469616c2063727970746f63757272656e63792070726f6a6563742e200a0a5769746820636f6d6d756e69747920737570706f727420616e6420636f6e74696e756f757320646576656c6f706d656e742c5375695961726e2077696c6c20737572656c7920636f6e74696e756520746f206272696e67206a6f7920616e642062656e656669747320746f2075736572732061726f756e642074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_1_60be6f7760.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYARN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYARN>>(v1);
    }

    // decompiled from Move bytecode v6
}

