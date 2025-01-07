module 0x1bb0dd5f928e8c7448ed29f0d32fb1e378e1d8dbafb1e4b9324bf387a2b76b0c::wooff {
    struct WOOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFF>(arg0, 9, b"WOOFF", b"woof", b"Woof woof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c17fdbf-de00-4531-8fad-bbc637af0797.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

