module 0x63460a629b777add23d96479c4ead75e0cae4e32d5ccea236a8dbcdc5a9d5c4::mo_b {
    struct MO_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: MO_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MO_B>(arg0, 9, b"MO_B", b"Mo", b"Waveees", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19fe911f-36a4-4823-864e-a70f6d1bfc00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MO_B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MO_B>>(v1);
    }

    // decompiled from Move bytecode v6
}

