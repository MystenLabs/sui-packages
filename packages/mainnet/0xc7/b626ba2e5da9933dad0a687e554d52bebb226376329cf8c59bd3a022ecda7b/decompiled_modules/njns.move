module 0xc7b626ba2e5da9933dad0a687e554d52bebb226376329cf8c59bd3a022ecda7b::njns {
    struct NJNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJNS>(arg0, 6, b"NJNS", b"NEW JEANS", b" NewJeans X Powerpuff Girls: Charm Across Generations! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_e_i_i_1080_x_540_px_512_x_512_px_19_8b64e6bd91.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NJNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

