module 0x29b72bef7f9f6cfe87f65204bc22de315ae6ed5191f72aab88ea5e0eb3084015::wewepumpit {
    struct WEWEPUMPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEPUMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEPUMPIT>(arg0, 9, b"WEWEPUMPIT", b"Wpump", b"Am bullish on WEWE token about to be launched on Sui Blockchain,am so exicted,it is going to be massive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/315599ec-ada8-441d-a67e-32007a18cef1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEPUMPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEPUMPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

