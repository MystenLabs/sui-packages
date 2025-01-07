module 0x817c7b704e80d8e7fb31b9b5541601fad8c065186befd7d1a600aadf2a240089::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"BANANA", b"BANANA", b"a simple banana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRB0SR_4P_FR84oRS03xl0TflC8eAMj2woBfg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANANA>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

