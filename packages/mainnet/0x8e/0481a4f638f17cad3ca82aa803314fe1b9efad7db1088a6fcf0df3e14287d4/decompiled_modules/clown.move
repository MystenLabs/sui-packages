module 0x8e0481a4f638f17cad3ca82aa803314fe1b9efad7db1088a6fcf0df3e14287d4::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWN>(arg0, 9, b"CLOWN", b"ClownFi", b"Step right up to the funniest coin in town! With ClownFi, the circus is always in session, and the laughs keep coming. A perfect pick for those who want to clown around in the market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb5907cc-95a6-492f-aac0-4815005aa718.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

