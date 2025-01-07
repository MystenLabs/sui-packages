module 0xa22dbc9d60f4626025ba65c7656bf7c4b6eedb37782908e7a6ba8c349a8da0f4::mn {
    struct MN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN>(arg0, 9, b"MN", b"MOON", b"This meme was inspired by the creator's love for moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e173e63e-f4ea-4f3b-9a17-7ee5bf624f03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN>>(v1);
    }

    // decompiled from Move bytecode v6
}

