module 0x347e097d38b00d7a0401ba9d7fd035e87aa1569b67f22fcb357c7713346519c9::wst {
    struct WST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WST>(arg0, 6, b"WST", b"FWog Sui Token", b"Are you ready for the new generation of wogs?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_S1h_GL_0i_400x400_b679094c53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WST>>(v1);
    }

    // decompiled from Move bytecode v6
}

