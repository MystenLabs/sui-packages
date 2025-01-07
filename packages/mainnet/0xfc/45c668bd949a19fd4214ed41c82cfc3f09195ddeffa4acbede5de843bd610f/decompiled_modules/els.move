module 0xfc45c668bd949a19fd4214ed41c82cfc3f09195ddeffa4acbede5de843bd610f::els {
    struct ELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELS>(arg0, 9, b"ELS", b"Elon_Sui", b"Meme breakthrough on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32d5448e-6fcb-4e73-b457-a90c8bdee7ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

