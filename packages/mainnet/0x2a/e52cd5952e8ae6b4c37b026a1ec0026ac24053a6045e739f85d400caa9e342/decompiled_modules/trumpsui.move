module 0x2ae52cd5952e8ae6b4c37b026a1ec0026ac24053a6045e739f85d400caa9e342::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"Trump Sui", b"Trump Sui is making Sui great again, one meme at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dj_Gf6_EKY_Tb_S_Lq_W8_Hf5x_Ttw_3d48977cf3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

