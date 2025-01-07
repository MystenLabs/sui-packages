module 0x9b7dcec48b07af9e9ff0817c573991a9dd5089559f01bd9f3797ee3343723397::klf {
    struct KLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLF>(arg0, 9, b"KLF", b"KHALIFA", b"KHALIFA MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52c375a4-d855-43e2-b537-80bc69e6b582.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

