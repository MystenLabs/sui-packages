module 0x24511ecd5a0f47128f16e0a499f38655f29d707540833eccd6ea09cb2b323ad2::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 9, b"Aaa", b"Asuike", b"Ejdjkfkdgsnsssmmdhxdgnwskkjxcjchdkfmcnfnfn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v2, @0x221171c3f7f466c651941b1c51ca1299efe23f61364a49c59c349ffa02a537a9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

