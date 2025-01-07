module 0x303267710e15987a3692362abb1acef5023aa514d4e78c6cd0604fba5b776537::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 6, b"XMAS", b"100xmas", x"4d657272792024313030786d61732c2074686520233120687970657220686f6c6964617920636f696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc3_Crihvuwnnefjnkharbhq_GD_6b_B_Sb_G26_Bf3rsitn_A_Ax_X_845ec02638.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

