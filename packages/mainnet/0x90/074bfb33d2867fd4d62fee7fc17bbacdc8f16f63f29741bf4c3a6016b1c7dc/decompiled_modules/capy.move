module 0x90074bfb33d2867fd4d62fee7fc17bbacdc8f16f63f29741bf4c3a6016b1c7dc::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"Capy", b"Capys", x"436170796261726173202843617079290a4c6f76656420666f7220746865697220696e76656e746976652c20696d6167696e617469766520617070726f61636820746f2070726f626c656d2d736f6c76696e672c20436170796261726173206172652072656c656e746c6573732074696e6b65726572732e0a0a546865697220646973636f76657279206f6620537569204d6f76652068617320656d706f7765726564207468656d20746f2074616b6520746865697220696e76656e74696f6e7320746f206e657720686569676874732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capy_175ad90fa0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

