module 0x2af36001d6e1bc99c7950b359fbfb81d27b5539e9bc31088b912a47d42810e75::frozen {
    struct FROZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROZEN>(arg0, 9, b"Frozen", x"f09fa5b646524f5a454e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROZEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROZEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

