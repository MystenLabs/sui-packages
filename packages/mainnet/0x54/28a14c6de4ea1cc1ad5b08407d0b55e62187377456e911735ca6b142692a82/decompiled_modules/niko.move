module 0x5428a14c6de4ea1cc1ad5b08407d0b55e62187377456e911735ca6b142692a82::niko {
    struct NIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKO>(arg0, 6, b"NIKO", b"NikolAI", b"The Meme, The Myth, The AI Machina", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NU_Gm_Ro_CM_400x400_5ce0e54ff4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

