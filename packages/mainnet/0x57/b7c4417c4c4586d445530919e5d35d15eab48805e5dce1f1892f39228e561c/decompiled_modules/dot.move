module 0x57b7c4417c4c4586d445530919e5d35d15eab48805e5dce1f1892f39228e561c::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOT>(arg0, 6, b"DOT", b"DOT Physical AI by SuiAI", b"Everything you need to know about DOT physical exams", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Parked_Trucks_DOT_b2444f22d2.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

