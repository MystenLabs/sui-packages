module 0x27dea9600055c965cb4c54e878cbd4aa988bce407ecfbc723712821850d3710::kmai {
    struct KMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KMAI>(arg0, 6, b"KMAi", b"Kekius Maximus Ai", b"Kekius Maximus Ai is a meme inspired by elon musk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_R_Zc3_N_3_400x400_1fa2a78afb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KMAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KMAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

