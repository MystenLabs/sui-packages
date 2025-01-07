module 0x5cc1fc4260763020ec8f479c1c5e7b44004e42ae63577f2c8bbd5bd7441786d7::popmart {
    struct POPMART has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPMART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPMART>(arg0, 9, b"POPMART", b"LaBuBu", x"4c414255425520c3972050524f4e4f554e4345202d2057494e4753204f4620464f5254554e452056696e796c20506c7573682048616e67696e6720436172640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5d9c420-da83-4d89-b2e9-0d5409fad630.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPMART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPMART>>(v1);
    }

    // decompiled from Move bytecode v6
}

