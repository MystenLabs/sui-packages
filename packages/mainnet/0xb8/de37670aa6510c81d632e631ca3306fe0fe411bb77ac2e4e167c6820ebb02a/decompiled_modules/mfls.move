module 0xb8de37670aa6510c81d632e631ca3306fe0fe411bb77ac2e4e167c6820ebb02a::mfls {
    struct MFLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFLS>(arg0, 6, b"MFLS", b"MrFloretSui", b"Are you ready for a new journey with MrFloret?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_c5377ac384.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MFLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

