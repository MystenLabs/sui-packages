module 0x3440fc7ca067f776c98d2a39677df8acd09baac3424d35dd9d103c5c1c8ec5c::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"Test by SuiAI", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/my_name_is_jeff_jump_street_d8241c9e35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

