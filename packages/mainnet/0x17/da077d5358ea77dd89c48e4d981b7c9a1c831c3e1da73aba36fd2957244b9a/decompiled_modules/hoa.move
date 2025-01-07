module 0x17da077d5358ea77dd89c48e4d981b7c9a1c831c3e1da73aba36fd2957244b9a::hoa {
    struct HOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOA>(arg0, 9, b"HOA", b"thai", b"vhn ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8d17171-b2f1-422c-9bf6-882ce177ee2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

