module 0xaa95fb3d036a8d8d6b8992b5b4c8707c4a03e3cbd41f57f01e68d98e9be59f30::snowy {
    struct SNOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWY>(arg0, 6, b"Snowy", b"Snowden the Polar Bear", b"Snowden the Polar Bear is the most chill meme in the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aasdasdwq3e123_a82323e732.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

