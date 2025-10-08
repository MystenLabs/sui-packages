module 0x8c2fb9973cf0e14ef2f70b29aaaf7d2986e3928b1391be4eac457f0d26375ff2::qtiger3479 {
    struct QTIGER3479 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QTIGER3479, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QTIGER3479>(arg0, 6, b"QTIGER3479", b"Quantum Tiger #3479", b"Superposition of wealth and prosperity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/quantum-tiger.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QTIGER3479>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QTIGER3479>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

