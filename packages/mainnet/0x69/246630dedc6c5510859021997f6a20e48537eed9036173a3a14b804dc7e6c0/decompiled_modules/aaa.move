module 0x69246630dedc6c5510859021997f6a20e48537eed9036173a3a14b804dc7e6c0::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"AAA", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0dog3_c277020773.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

