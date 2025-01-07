module 0x1d8d63a3ee1a67bbb1578d7ca2050120bf035f95874664345d89ba1d3b6e712d::hoa {
    struct HOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOA>(arg0, 9, b"HOA", b"thai", b"vhn ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd2e62f6-5970-4520-ba20-9e6c875982f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

