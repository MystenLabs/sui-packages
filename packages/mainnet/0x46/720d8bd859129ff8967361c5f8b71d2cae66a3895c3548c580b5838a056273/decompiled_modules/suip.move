module 0x46720d8bd859129ff8967361c5f8b71d2cae66a3895c3548c580b5838a056273::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"SUIphoria", b"SUIphoria is a playful meme coin on the Sui blockchain, celebrating community and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/SU_Iphoria_518764794e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

