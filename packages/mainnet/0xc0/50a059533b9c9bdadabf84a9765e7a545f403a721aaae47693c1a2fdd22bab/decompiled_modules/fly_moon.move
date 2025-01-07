module 0xc050a059533b9c9bdadabf84a9765e7a545f403a721aaae47693c1a2fdd22bab::fly_moon {
    struct FLY_MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY_MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY_MOON>(arg0, 9, b"FLY_MOON", b"MOON", b"Fly to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fe19fbf-98e1-47d6-888d-3d174100824f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY_MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLY_MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

