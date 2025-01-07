module 0xde9c55d9fd6f992f469684390384d46796e3e8f2e93055790417c76716f34dea::pdiddy {
    struct PDIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDIDDY>(arg0, 9, b"PDIDDY", b"Pdiddy", b"Token meme pdiddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eacbaafb-d034-4d2b-a0ca-24f837d81912-IMG_1130.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

