module 0x69a915f01ea6c348ae31ff9a31d03ef1cc92665da43e572a7ed8bb239755997b::bty {
    struct BTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTY>(arg0, 9, b"BTY", b"Bounty", b"bty is a heavenly delight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce9895c7-ce3c-4676-9980-5db421ccd46d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

