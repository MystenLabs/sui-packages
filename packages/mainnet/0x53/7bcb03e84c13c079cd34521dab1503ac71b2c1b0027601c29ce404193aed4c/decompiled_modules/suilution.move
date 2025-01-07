module 0x537bcb03e84c13c079cd34521dab1503ac71b2c1b0027601c29ce404193aed4c::suilution {
    struct SUILUTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILUTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILUTION>(arg0, 6, b"SUILUTION", b"Suilution", b"Your suilution to finally make it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUILUTION_1_d842dcc09f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILUTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILUTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

