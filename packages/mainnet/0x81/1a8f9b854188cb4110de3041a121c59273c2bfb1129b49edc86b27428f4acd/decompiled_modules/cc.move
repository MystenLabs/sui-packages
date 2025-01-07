module 0x811a8f9b854188cb4110de3041a121c59273c2bfb1129b49edc86b27428f4acd::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 6, b"CC", b"cat cream", x"52656d656d62657220746f20627275736820796f757220746565746820776974682063617420637265616d206576657279206d6f726e696e670a45766572796f6e65277320686162697473206c65616420746f207472756520646563656e7472616c697a6174696f6e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Taqe_Gv3rhxp7qw6k_Cgkyx5_Gwo_RU_7_M_Lxg_Q2_MY_Tdko2_B_Jb_4793ed002f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    // decompiled from Move bytecode v6
}

