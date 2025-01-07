module 0xc8685a9ed360ac7fe7c2938ea9dad2d3f4181f55c711b1425e43bec4481d9555::av {
    struct AV has drop {
        dummy_field: bool,
    }

    fun init(arg0: AV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AV>(arg0, 9, b"AV", b"Avira", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a708d94-3a0c-42cc-af2f-dca53456d9dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AV>>(v1);
    }

    // decompiled from Move bytecode v6
}

