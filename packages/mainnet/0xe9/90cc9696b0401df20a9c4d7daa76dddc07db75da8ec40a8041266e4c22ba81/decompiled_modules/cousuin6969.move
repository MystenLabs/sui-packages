module 0xe990cc9696b0401df20a9c4d7daa76dddc07db75da8ec40a8041266e4c22ba81::cousuin6969 {
    struct COUSUIN6969 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUSUIN6969, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUSUIN6969>(arg0, 6, b"COUSUIN6969", b"RETARDIO COUSUIN 69", x"48494748455220434f555355494e20616b612055502e4f4e4c5920434f5553494e204f4e4c590a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0966_1e5d0c2b1e_c326f2ae11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUSUIN6969>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUSUIN6969>>(v1);
    }

    // decompiled from Move bytecode v6
}

