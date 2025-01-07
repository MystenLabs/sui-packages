module 0x70bc5e2d892d25f67bb60f5492287fac8103e122910bd0a6d3f52e469d9320c3::hellomfcke {
    struct HELLOMFCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOMFCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOMFCKE>(arg0, 9, b"HELLOMFCKE", b"HelloMFCk", b"Hellooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a636b92-4f14-490d-b56a-38f85a3fa409.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOMFCKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLOMFCKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

