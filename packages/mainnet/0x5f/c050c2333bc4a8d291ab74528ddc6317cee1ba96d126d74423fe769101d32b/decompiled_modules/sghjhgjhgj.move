module 0x5fc050c2333bc4a8d291ab74528ddc6317cee1ba96d126d74423fe769101d32b::sghjhgjhgj {
    struct SGHJHGJHGJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGHJHGJHGJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGHJHGJHGJ>(arg0, 9, b"SGHJHGJHGJ", b"gfjhfjhfjf", b"mjhfmhjyfkyf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ba8f9b2-ff41-43c7-97b3-a40149517c43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGHJHGJHGJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGHJHGJHGJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

