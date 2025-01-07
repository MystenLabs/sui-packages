module 0x16e0677d08fdccaba6b3de7ab0ce4bd48deaa7847139d2cc18e8ba676b1a1e51::s7_ {
    struct S7_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: S7_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S7_>(arg0, 9, b"S7_", b"mosi", b"help to earn money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/578a6e0c-df50-4c64-8a67-229b901729ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S7_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S7_>>(v1);
    }

    // decompiled from Move bytecode v6
}

