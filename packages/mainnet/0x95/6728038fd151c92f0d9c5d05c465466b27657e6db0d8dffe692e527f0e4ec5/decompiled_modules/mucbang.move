module 0x956728038fd151c92f0d9c5d05c465466b27657e6db0d8dffe692e527f0e4ec5::mucbang {
    struct MUCBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUCBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUCBANG>(arg0, 9, b"MUCBANG", b"Muc Bang", b"MUCBANG MUC BANG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35d43b6c-5180-4637-9113-47b072dfc161.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUCBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUCBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

