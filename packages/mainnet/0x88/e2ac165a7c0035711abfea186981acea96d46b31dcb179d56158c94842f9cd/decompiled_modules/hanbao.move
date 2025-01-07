module 0x88e2ac165a7c0035711abfea186981acea96d46b31dcb179d56158c94842f9cd::hanbao {
    struct HANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAO>(arg0, 6, b"HANBAO", b"HANBAO THE FINLESS POROOISE", b"Former Olympian  Purveyor of Fine Crustaceans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GTFWEV_Qy5_Bw_Qs_ZJWS_4_Y6_Ka_Z3or6_Yhysh2_EE_Up8bgpump_df8a28af96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

