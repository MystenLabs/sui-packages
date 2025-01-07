module 0x356008b4c20b28f3d5e5b56baf5799766c7f9677efd8b3606732d3a38acdd0f2::muj {
    struct MUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUJ>(arg0, 9, b"MUJ", b"Mujitapha ", b"Mujtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f0253b9-3d6b-4ada-8b2c-ca8fb6660cab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

