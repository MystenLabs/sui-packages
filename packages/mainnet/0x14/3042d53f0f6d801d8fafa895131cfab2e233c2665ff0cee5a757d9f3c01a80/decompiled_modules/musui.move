module 0x143042d53f0f6d801d8fafa895131cfab2e233c2665ff0cee5a757d9f3c01a80::musui {
    struct MUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSUI>(arg0, 6, b"MUSUI", b"Mudskipper Sui", b"Join the kingdom and reach new heights together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_27_6577c43d03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

