module 0xeb59ebc3ba5c11ad6d19ad350b43e37361416e2f46a3feeaafc04fdd83a73bc2::fafu {
    struct FAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFU>(arg0, 9, b"FAFU", b"Fafafufu", b"www.fafafufu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97f49df1-088e-4551-9842-0c76dc8fe0ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

