module 0x32b757c87a503fb963d195a4ac4cf6b06e01c087c1c3d9a2859ba3b3f97f6aa5::amba {
    struct AMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBA>(arg0, 9, b"AMBA", b"Ambatukam", b"Ambatukam guy who is very famous in the internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa8215a1-9a71-4c71-b6ec-6e30f5ad5cf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

