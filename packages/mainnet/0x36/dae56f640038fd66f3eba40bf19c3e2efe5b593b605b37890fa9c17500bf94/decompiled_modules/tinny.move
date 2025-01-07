module 0x36dae56f640038fd66f3eba40bf19c3e2efe5b593b605b37890fa9c17500bf94::tinny {
    struct TINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINNY>(arg0, 6, b"Tinny", b"Tinny the Rhino", x"4d6565742054696e6e792120546865206e65776573742042616279205268696e6f20696e20746f776e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tinny_776a8a0d7a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

