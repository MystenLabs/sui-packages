module 0x2803137ba5899e43f05ba2969ce5410d3c602fc0044abcbb160c9291a720f170::nob {
    struct NOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOB>(arg0, 9, b"NOB", b"NOBLE", b"In honour of Noble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4304fcc5-658e-43f5-b79d-c81126459673.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

