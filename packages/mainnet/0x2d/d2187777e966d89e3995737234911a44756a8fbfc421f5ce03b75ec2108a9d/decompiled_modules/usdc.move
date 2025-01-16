module 0x2dd2187777e966d89e3995737234911a44756a8fbfc421f5ce03b75ec2108a9d::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"upside down cat", x"4a757374206120636174207468617427732075707369646520646f776e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma4_RG_2_N3_Tzc_Tx_J3_Jb_G9_ZT_Zsctd9b5qoy_Dq4_YHAW_Xf1_Rup_444f385d6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

