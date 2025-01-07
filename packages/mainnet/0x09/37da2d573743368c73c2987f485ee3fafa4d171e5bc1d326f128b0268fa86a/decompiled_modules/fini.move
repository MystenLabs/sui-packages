module 0x937da2d573743368c73c2987f485ee3fafa4d171e5bc1d326f128b0268fa86a::fini {
    struct FINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINI>(arg0, 6, b"FINI", b"Fini", b"Game is live  Ready to playover 500 players lonline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fini_T_Euu_R9_Jg_R_Sfnx5k_U_To_4a98d6a497.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

