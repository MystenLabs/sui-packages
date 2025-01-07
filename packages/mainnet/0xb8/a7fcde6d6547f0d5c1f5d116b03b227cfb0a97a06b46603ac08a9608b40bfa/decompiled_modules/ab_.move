module 0xb8a7fcde6d6547f0d5c1f5d116b03b227cfb0a97a06b46603ac08a9608b40bfa::ab_ {
    struct AB_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AB_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AB_>(arg0, 9, b"AB_", b"AB_DOLLAT", b"#CERTIFIEDLONER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e40c1f5-f884-47a7-bbe7-058ffffd7286.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AB_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AB_>>(v1);
    }

    // decompiled from Move bytecode v6
}

