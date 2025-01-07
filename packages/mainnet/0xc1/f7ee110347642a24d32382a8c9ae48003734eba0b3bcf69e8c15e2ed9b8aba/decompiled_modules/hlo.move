module 0xc1f7ee110347642a24d32382a8c9ae48003734eba0b3bcf69e8c15e2ed9b8aba::hlo {
    struct HLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLO>(arg0, 9, b"HLO", b"HELLO", b"Hello (HLO) Trade Now In Future I'll Create Biggest Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/124ab613-cd9a-4a52-bfef-3a067b159d9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

