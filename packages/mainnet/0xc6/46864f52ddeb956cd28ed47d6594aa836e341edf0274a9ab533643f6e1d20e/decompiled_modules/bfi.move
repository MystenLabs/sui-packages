module 0xc646864f52ddeb956cd28ed47d6594aa836e341edf0274a9ab533643f6e1d20e::bfi {
    struct BFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFI>(arg0, 9, b"BFI", b"BlockFi-Ai", b"Empowering both beginners and experts with AI-driven analytics, real-time data, and seamless trading tools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.mexc.com/api/file/download/F20251011233026100C3PITQrirnMOov")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BFI>>(0x2::coin::mint<BFI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BFI>>(v2);
    }

    // decompiled from Move bytecode v6
}

