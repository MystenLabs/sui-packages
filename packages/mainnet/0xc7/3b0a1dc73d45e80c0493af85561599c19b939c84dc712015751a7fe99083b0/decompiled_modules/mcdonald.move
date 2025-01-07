module 0xc73b0a1dc73d45e80c0493af85561599c19b939c84dc712015751a7fe99083b0::mcdonald {
    struct MCDONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCDONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCDONALD>(arg0, 9, b"MCDONALD", b"McDonald's", b"grimace is a close personal friend of mine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/632ce536-4aba-4cc5-9f32-2a930603a719.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCDONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCDONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

