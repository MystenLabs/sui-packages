module 0x2bf648a5442dd79b6daaef4f44b0d1534c79547ad8caa5bd1ab28867c0dd4c40::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 9, b"DOGES", b"Doge", b"Dogesasf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcf8dc3e-6ba8-479e-8ea7-1cd9208a9554.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
    }

    // decompiled from Move bytecode v6
}

