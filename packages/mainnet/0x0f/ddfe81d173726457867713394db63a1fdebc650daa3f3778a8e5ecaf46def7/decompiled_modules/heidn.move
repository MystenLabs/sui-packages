module 0xfddfe81d173726457867713394db63a1fdebc650daa3f3778a8e5ecaf46def7::heidn {
    struct HEIDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIDN>(arg0, 9, b"HEIDN", b"jejdn", b"sheikd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b5ce08d8-8b37-4797-9114-874b85ae9791.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEIDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

