module 0xe9eada2a1b3efd32328d25400299a76ab6f923740adc71f6c5610e49ab412738::sola {
    struct SOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLA>(arg0, 6, b"SOLA", b"SUIOLA", b"Hi, Im $SOLA! People tell me I look like PEPE. I tell them, I'm a KOALA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fs_A54y_L49_W_Ks7r_Wo_Gv9s_Ucb_SGWCWV_756j_TD_349e6_H2y_W_7b55c6bbde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

