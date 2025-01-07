module 0x7031341a77184de29e19ca1c7d04e848bef9616e9f0e4b185c340a16511d5732::hkitty {
    struct HKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKITTY>(arg0, 6, b"Hkitty", b"Hello Kitty on sui", b"the cutest cat in the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_48_c0f24d8061.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

