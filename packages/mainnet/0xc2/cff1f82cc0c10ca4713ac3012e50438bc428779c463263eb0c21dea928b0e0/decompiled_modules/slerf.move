module 0xc2cff1f82cc0c10ca4713ac3012e50438bc428779c463263eb0c21dea928b0e0::slerf {
    struct SLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERF>(arg0, 6, b"Slerf", b"Slerfsui", b"Slerf on sui 2025 meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5516_2cb0c79002.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

