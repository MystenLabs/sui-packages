module 0xfab124894678eb6c851e5259d187706cdfbe2a57330317a159b965169461824::scheek {
    struct SCHEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHEEK>(arg0, 6, b"SCHEEK", b"CHEEKS SUI", x"546865206c6561646572206f6620616c6c204d656d65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_23_f6c8390bb4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

