module 0xbeb13e100f7d87641274d9382f8bd6925f120e329bbedad6374a170ff02c4c32::zqr {
    struct ZQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZQR>(arg0, 9, b"ZQR", b"Zhaqor", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f1d51fc-8145-4294-bce9-ebe87fca1519.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

