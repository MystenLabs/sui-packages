module 0x13753ead9e4a8c07efc8bf4637ee03a7171578fd4be7c3614f7f23aa493f7555::orcy {
    struct ORCY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCY>(arg0, 6, b"ORCY", b"Orcy CTO", b"Hey there, I'm $ORCY! Your ultimate meme token, making waves in the SUI ecosystem. Lets dive in and conquer the ocean together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_10_15_200903_3b82227fbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCY>>(v1);
    }

    // decompiled from Move bytecode v6
}

