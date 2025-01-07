module 0xa233e8dd527b3b5147063159855e0acc5241f83ad8c14ecfa74ed8486a436b1d::umr {
    struct UMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMR>(arg0, 9, b"UMR", b"UMARU", b"OTAKU SAVE THE WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/151092b2-fe5b-4f91-9fc1-f619c6645caf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

