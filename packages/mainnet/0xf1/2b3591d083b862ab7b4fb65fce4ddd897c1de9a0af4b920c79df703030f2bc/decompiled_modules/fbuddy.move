module 0xf12b3591d083b862ab7b4fb65fce4ddd897c1de9a0af4b920c79df703030f2bc::fbuddy {
    struct FBUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBUDDY>(arg0, 6, b"FBUDDY", b"Fun Buddy Sui", b"Dexscreener paid.Check here: https://www.buddyonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X_Fo_HO_Zx_A_Ov_Ijpd1_F_Gjtw5_H9_Luw_2_cc3bf8dba0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FBUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

