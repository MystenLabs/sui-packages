module 0x2631b80fe76d45187924decda6007ba22ca51a0ef5800a65619805223e012163::sfighters {
    struct SFIGHTERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFIGHTERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFIGHTERS>(arg0, 6, b"Sfighters", b"Suidum Fighters", x"47726f6b206372656174656420746869732e2e2e0a0a4e6f7420717569746520746865204672656544756d2046696768746572732077652077657265207468696e6b696e67206f6620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Zy_Rv5_W4_AA_Am_ZD_436bc337bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFIGHTERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFIGHTERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

