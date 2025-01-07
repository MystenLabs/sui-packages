module 0xd03787d2fa4f4a8dcec7a76d3217818a4a8cb33d1f28516c1a8ef36df8592c61::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOK>(arg0, 9, b"TOK", b"T o k e n ", b"Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da8cb771-2756-4039-a0fa-60b4a242623f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

