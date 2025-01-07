module 0x4d04a58b96305faf3e1a825ecbf90686bdc2d36917b42788efde32324244799e::pil {
    struct PIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIL>(arg0, 9, b"PIL", b"PILL", b"PILL IS A BULLRUN MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4763f33-4b37-41bd-95ad-4edc74a0b30d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

