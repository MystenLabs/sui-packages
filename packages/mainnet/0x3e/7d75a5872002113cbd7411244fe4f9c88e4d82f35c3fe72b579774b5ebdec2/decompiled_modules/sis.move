module 0x3e7d75a5872002113cbd7411244fe4f9c88e4d82f35c3fe72b579774b5ebdec2::sis {
    struct SIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIS>(arg0, 9, b"SIS", b"Sistem", b"Best token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0d242bf-d542-4d91-a113-d5da855f116f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

