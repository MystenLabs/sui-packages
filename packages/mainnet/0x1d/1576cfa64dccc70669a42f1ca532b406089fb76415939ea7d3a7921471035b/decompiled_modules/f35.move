module 0x1d1576cfa64dccc70669a42f1ca532b406089fb76415939ea7d3a7921471035b::f35 {
    struct F35 has drop {
        dummy_field: bool,
    }

    fun init(arg0: F35, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F35>(arg0, 6, b"F35", b"F35 Fighter Jet", b"This is the top gun of shitcoins,If youre not flying with $F35, youre just a target.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f35_89d08256dc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F35>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F35>>(v1);
    }

    // decompiled from Move bytecode v6
}

