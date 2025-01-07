module 0x1d20990f50675f62e4363bc1c9b8470d816daac96862ddd786475300bdb2eb12::alaska {
    struct ALASKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALASKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALASKA>(arg0, 6, b"ALASKA", b"Alaska on Sui", b"Woof! It's me, Alaska! Hop on the Meme Supercycle and let's chase those sui bags together!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s3ghbb_WB_Tt_Miz_NJK_Gme_M_Bd1_U_Rpiso_Q_Jxu_D_Lrhe_EX_61g_9aafe0c85d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALASKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALASKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

