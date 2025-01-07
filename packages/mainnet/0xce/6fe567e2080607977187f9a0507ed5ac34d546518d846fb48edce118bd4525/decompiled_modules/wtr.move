module 0xce6fe567e2080607977187f9a0507ed5ac34d546518d846fb48edce118bd4525::wtr {
    struct WTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTR>(arg0, 9, b"WTR", b"Water", b"The next 1000x meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76212b81-1505-44c0-ab5d-db3e121c94a6-1000362514.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

