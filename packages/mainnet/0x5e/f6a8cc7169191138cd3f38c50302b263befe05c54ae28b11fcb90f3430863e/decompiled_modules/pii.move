module 0x5ef6a8cc7169191138cd3f38c50302b263befe05c54ae28b11fcb90f3430863e::pii {
    struct PII has drop {
        dummy_field: bool,
    }

    fun init(arg0: PII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PII>(arg0, 9, b"PII", b"PI", b"For the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a95ce1f-2b06-43f8-9395-286bc74193f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PII>>(v1);
    }

    // decompiled from Move bytecode v6
}

