module 0xd63cb552526e3beafc7f340839f7c1715f86aa03fcc4419a32d990f69e2f5609::pepa {
    struct PEPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPA>(arg0, 2, b"Pepa", b"Pepe Wife", b"Pepa ia a wife of King PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAnhF8fGMoiIAibLe8tkdeJEBQWE3PKP3c5w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPA>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

