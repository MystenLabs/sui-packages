module 0x10e3e43bc5a2efaddecd12f32032dda38da32da220d183dfa943c617f0cad51a::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"Suip", b"Sui pikachu", b"lovely pikachu like sui friends , they will grow together everyday.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pikachu_56857e4c02.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

