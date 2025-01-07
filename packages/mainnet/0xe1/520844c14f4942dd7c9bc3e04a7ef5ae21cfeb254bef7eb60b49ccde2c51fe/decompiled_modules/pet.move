module 0xe1520844c14f4942dd7c9bc3e04a7ef5ae21cfeb254bef7eb60b49ccde2c51fe::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 6, b"PET", b"moonpet", b"Its my vision to distribute my creations in a way that overcomes payment barriers worldwide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DAWU_39gaqec_Sm5_Nkc_Agi_K_Copn_QD_Xegf4_Yb9g7_J_Papump_3b809bcd3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PET>>(v1);
    }

    // decompiled from Move bytecode v6
}

