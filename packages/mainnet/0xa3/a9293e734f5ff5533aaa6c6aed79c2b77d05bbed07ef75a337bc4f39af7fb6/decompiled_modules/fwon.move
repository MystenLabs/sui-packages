module 0xa3a9293e734f5ff5533aaa6c6aed79c2b77d05bbed07ef75a337bc4f39af7fb6::fwon {
    struct FWON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWON>(arg0, 6, b"FWON", b"FWON from the Earth", b"Frog from the deepest place of the hell is here with us. Join for the hell yeahhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_KV_1_C_Jzx5t_XHV_7u2_Jp2z_Nn7vw5f3_Neux_Ax_Ce_Lexkpump_7dbc33832f_3e8616b170.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWON>>(v1);
    }

    // decompiled from Move bytecode v6
}

