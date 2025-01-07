module 0x6951dda460eccfd9e6431d631f2964c63fd3347c049c0a66fdee3bb037504d5f::blake {
    struct BLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAKE>(arg0, 6, b"BLAKE", b"SUIBLAKE", b"Welcome to Blake on SUI, a memecoin inspired by Matt Furie. BLAKE is set to become an icon on the SUI Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_41_5d6cd658d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

