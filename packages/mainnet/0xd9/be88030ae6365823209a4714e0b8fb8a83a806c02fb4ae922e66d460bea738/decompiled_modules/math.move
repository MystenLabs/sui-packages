module 0xd9be88030ae6365823209a4714e0b8fb8a83a806c02fb4ae922e66d460bea738::math {
    struct MATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATH>(arg0, 9, b"MATH", b"Mathlab", b"a meme coin for scientist who love math", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d81e3dd8-a035-4130-a1f7-8f8c3755a4d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

