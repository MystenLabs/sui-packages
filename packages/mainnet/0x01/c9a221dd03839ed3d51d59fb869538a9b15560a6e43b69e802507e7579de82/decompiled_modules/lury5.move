module 0x1c9a221dd03839ed3d51d59fb869538a9b15560a6e43b69e802507e7579de82::lury5 {
    struct LURY5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LURY5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LURY5>(arg0, 9, b"LURY5", b"LURCHY", b"fine loving happy playful meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f05d284-14ae-4dec-bfb4-047097934061.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LURY5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LURY5>>(v1);
    }

    // decompiled from Move bytecode v6
}

