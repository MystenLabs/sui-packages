module 0x48d6bfc15c36ecd8123028520b09c6f55c775cdb8871cce6182ba16a54d0dc5a::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"aaa cat v2 (complete bridge: aaav2.com)", b"complete bridge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.cryptorank.io/coins/aaa_cat1727162326710.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAA>(&mut v2, 10000000000000 * 0x1::u64::pow(10, 6), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

