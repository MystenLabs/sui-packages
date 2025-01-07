module 0x4b10e544a45f31f78ce62fcf236a78cd6e6b112b693f7c4f1e31de1d2859b40f::anm {
    struct ANM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANM>(arg0, 9, b"ANM", b"Anime", b"Anime for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb929277-7298-4c10-b59e-c4f5d301a40b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANM>>(v1);
    }

    // decompiled from Move bytecode v6
}

