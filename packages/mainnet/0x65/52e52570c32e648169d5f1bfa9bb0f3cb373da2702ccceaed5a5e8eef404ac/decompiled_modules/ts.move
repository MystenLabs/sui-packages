module 0x6552e52570c32e648169d5f1bfa9bb0f3cb373da2702ccceaed5a5e8eef404ac::ts {
    struct TS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TS>(arg0, 9, b"TS", b"Taylor", b"Taylor Switch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da4fa102-306d-4c3c-a3b7-def2ccc88a85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TS>>(v1);
    }

    // decompiled from Move bytecode v6
}

