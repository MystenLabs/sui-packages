module 0x9ce33cb0b16e9c63fa39ba72d75458fbd965c1a96a3fced7bca436252c9bb921::glr {
    struct GLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GLR>(arg0, 6, b"GLR", b"Glora by SuiAI", b"My what token ai gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Snimok_ekrana_2025_01_09_v_21_31_42_df47acae12.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

