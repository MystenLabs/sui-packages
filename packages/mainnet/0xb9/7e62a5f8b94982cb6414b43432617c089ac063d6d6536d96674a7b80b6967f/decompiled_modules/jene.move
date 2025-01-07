module 0xb97e62a5f8b94982cb6414b43432617c089ac063d6d6536d96674a7b80b6967f::jene {
    struct JENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENE>(arg0, 9, b"JENE", b"bdbd", b"jener", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6666d5ac-eac5-4e57-ba8e-48490af611fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

