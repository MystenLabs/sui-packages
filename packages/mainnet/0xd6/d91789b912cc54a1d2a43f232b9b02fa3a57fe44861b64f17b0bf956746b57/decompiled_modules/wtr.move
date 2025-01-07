module 0xd6d91789b912cc54a1d2a43f232b9b02fa3a57fe44861b64f17b0bf956746b57::wtr {
    struct WTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTR>(arg0, 9, b"WTR", b"Water", b"the next 100x meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/250a7889-0947-47d6-907c-e6524530156b-1000362515.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

