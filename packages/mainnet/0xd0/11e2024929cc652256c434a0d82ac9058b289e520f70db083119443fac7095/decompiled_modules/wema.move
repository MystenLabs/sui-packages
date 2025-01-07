module 0xd011e2024929cc652256c434a0d82ac9058b289e520f70db083119443fac7095::wema {
    struct WEMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEMA>(arg0, 9, b"WEMA", b"WECAT", b"Wecat is meme that is community DERIVEN and we will go to the moon together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/736d1782-fdb7-41e9-8b63-16beac3bc3b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

