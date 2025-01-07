module 0x379feedc1a2449516201fe0f3b96bd97e06e5b42b6ae40cc416962d14bd8ea86::shr {
    struct SHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHR>(arg0, 9, b"SHR", b"Shrimp", b"toi co mot con tom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b3b745f-6964-49fd-bcfa-d58bf088fb02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

