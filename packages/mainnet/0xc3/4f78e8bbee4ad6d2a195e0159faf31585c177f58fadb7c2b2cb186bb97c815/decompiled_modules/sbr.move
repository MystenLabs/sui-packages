module 0xc34f78e8bbee4ad6d2a195e0159faf31585c177f58fadb7c2b2cb186bb97c815::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBR>(arg0, 6, b"SBR", b"SUI BLUE REX", b"RAWWRRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_BLUE_6e68883c76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

