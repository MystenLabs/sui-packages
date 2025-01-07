module 0x11714787d701c3c2a3b6873aa1d0ba31ce26052fedca092ae9279b0a13ffe6f::circle {
    struct CIRCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRCLE>(arg0, 6, b"CIRCLE", b"CIRCLE ON SUI", b"CIRCLE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gambar_Whats_App_2024_10_12_pukul_16_42_31_2b06bc5a_c396977e5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIRCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

