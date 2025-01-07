module 0x41f3037a3bd2f988795ad61adfae08d14c227c2868028ffa72a417442334e5c9::tya {
    struct TYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYA>(arg0, 9, b"TYA", b"404", b"Over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3ce16c9-f9ee-45f3-b0e8-e8ca2e2f5ad4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

