module 0xac857aa0a952856ca2cf1b9dc0cca0848109d62387161a4ed6617ada6ffdef2f::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"Ban", b"Comedian", x"546865206d6f7374207369676e69666963616e74206d656d65206f66207468652061727420686973746f7279206279204d6175726963696f2043617474656c616e2e204265696e672061756374696f6e20617420536f746865627973204e6f76656d6265722032307468200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_KEGF_Pj_Mht_Mdc6_Nud7yvb_PS_8ti_Xfb_Fu2j_G_Mv_SU_Tej_F9_V_b3ae381dff.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

