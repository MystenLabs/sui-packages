module 0x41fa8bcf2b6b2b31f4ff50db61caeef163fba96a7da5e5626a4aa40514e9bebe::skydog {
    struct SKYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYDOG>(arg0, 9, b"SKYDOG", b"sky coin", b"sky is name for my dog, she's cute fr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f19c0297-53d9-4201-9bb8-af41f32a0b32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

