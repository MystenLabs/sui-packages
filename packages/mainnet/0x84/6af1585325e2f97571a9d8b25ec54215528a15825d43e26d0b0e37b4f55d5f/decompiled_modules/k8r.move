module 0x846af1585325e2f97571a9d8b25ec54215528a15825d43e26d0b0e37b4f55d5f::k8r {
    struct K8R has drop {
        dummy_field: bool,
    }

    fun init(arg0: K8R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K8R>(arg0, 6, b"K8R", b"Alex K8R", x"416c6578204b385220284b385229204c65742773206368617420746f67657468657220616e642063656c656272617465206f7572206c61756e63687061642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SPD_6y_Ev36s_C7_Xz1_X_Juts_Qsa_Dgq_A6_T_Wx_K6_Qzdfs_Mr1o_BH_8be33bd182.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K8R>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<K8R>>(v1);
    }

    // decompiled from Move bytecode v6
}

