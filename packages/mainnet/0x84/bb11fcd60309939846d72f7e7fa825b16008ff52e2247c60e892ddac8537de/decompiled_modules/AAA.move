module 0x84bb11fcd60309939846d72f7e7fa825b16008ff52e2247c60e892ddac8537de::AAA {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 9, b"AAA141", b"aaa cat 141", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4995_cfd6177d03.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AAA>>(0x2::coin::mint<AAA>(&mut v2, 16000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAA>>(v2);
    }

    // decompiled from Move bytecode v6
}

