module 0xf4a6b01b57be84c6378f1c09c2ce38ec5a83a10338204fc9a3421278fb88a8e3::katz {
    struct KATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATZ>(arg0, 9, b"KATZ", b"CAT", b"THIS A CATZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34016f06-7d69-4361-997f-7356eb618390.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

