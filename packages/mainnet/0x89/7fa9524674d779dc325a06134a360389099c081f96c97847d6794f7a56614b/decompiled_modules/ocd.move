module 0x897fa9524674d779dc325a06134a360389099c081f96c97847d6794f7a56614b::ocd {
    struct OCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCD>(arg0, 9, b"OCD", b"Ocsen", b"Ocd by paper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17c8c898-0b28-4150-b58b-096ff7320b2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

