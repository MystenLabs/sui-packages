module 0xcb44f8720455a1e289bb6567501649714f2f0ad29ed47324916f9f9734bfbe9e::dewy {
    struct DEWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEWY>(arg0, 6, b"DEWY", b"Dewy On Sui ", b"Dewy On Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731225668277.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEWY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEWY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

