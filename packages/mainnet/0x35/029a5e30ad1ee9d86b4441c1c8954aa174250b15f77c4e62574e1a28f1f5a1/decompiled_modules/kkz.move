module 0x35029a5e30ad1ee9d86b4441c1c8954aa174250b15f77c4e62574e1a28f1f5a1::kkz {
    struct KKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKZ>(arg0, 9, b"KKZ", b"Kzoe", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3ec3465-2391-40cb-89c3-a5538f392ced.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

