module 0xdd8c33c901b871f3d2ed4c5181b292753d97b82a148b197797162b83f44ea8a4::ola {
    struct OLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA>(arg0, 9, b"OLA", b"Mim", b"Great token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2524c9e1-5fff-48f6-814e-c5ed82fb1780.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

