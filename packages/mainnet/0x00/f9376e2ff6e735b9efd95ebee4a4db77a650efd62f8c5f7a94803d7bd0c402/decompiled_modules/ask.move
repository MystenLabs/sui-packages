module 0xf9376e2ff6e735b9efd95ebee4a4db77a650efd62f8c5f7a94803d7bd0c402::ask {
    struct ASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASK>(arg0, 6, b"Ask", b"Asksui Bor", x"41736b53756920424f542c207769746820697473207375706572696f720a6172746966696369616c20627261696e2c20686173206372656174656420610a666576657220696e20746865204e4654206d61726b65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ch_AE_a_c_A_t_A_n_500_x_500_px_5_bc1bcd8ca1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

