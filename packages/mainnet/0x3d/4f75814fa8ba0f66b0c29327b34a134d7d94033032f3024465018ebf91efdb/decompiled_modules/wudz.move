module 0x3d4f75814fa8ba0f66b0c29327b34a134d7d94033032f3024465018ebf91efdb::wudz {
    struct WUDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUDZ>(arg0, 6, b"WUDZ", b"Wudz on SUI", x"4c65747320676574207468697320706172747920737461727465642121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F0_N_Xw9_CC_400x400_aa39905506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUDZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUDZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

