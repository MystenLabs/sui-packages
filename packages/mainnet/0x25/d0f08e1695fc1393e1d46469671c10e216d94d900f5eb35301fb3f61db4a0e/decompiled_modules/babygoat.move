module 0x25d0f08e1695fc1393e1d46469671c10e216d94d900f5eb35301fb3f61db4a0e::babygoat {
    struct BABYGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYGOAT>(arg0, 6, b"BABYGOAT", b"Baby Goatseus Maximus", x"4261627920476f617473657573204d6178696d757320287469636b65723a2042474f4154292046697273742062616279206d656d65206372656174656420627920404b6172656e5f38712e206261627920476f617473657573204d6178696d75732077696c6c2066756c66696c6c207468652070726f70686563696573206f662074686520616e6369656e74206d656d656572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rh2_Zs9_Sk_KRQA_98ea_FTG_5_Jnm_R_Vxg_UX_Sbssu2k_Pn_Ejm_Ymo_2f2f2362e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

