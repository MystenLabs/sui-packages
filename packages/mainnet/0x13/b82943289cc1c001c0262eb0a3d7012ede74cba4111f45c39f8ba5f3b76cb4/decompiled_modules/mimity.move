module 0x13b82943289cc1c001c0262eb0a3d7012ede74cba4111f45c39f8ba5f3b76cb4::mimity {
    struct MIMITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMITY>(arg0, 9, b"MIMITY", b"MIMIOE", b"THAT WHAT GIRL TO DAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81e65967-8dc1-4781-a66d-34b69b2ca8a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIMITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

