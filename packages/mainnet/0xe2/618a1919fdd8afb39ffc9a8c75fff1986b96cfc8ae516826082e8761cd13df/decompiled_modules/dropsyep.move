module 0xe2618a1919fdd8afb39ffc9a8c75fff1986b96cfc8ae516826082e8761cd13df::dropsyep {
    struct DROPSYEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPSYEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPSYEP>(arg0, 9, b"DROPSYEP", b"Dropes", b"Capture memes world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30aaee0a-943e-446d-9f9a-2046f6875ac9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPSYEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPSYEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

