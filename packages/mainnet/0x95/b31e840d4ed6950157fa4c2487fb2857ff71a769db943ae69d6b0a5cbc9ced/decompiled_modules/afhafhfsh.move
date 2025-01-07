module 0x95b31e840d4ed6950157fa4c2487fb2857ff71a769db943ae69d6b0a5cbc9ced::afhafhfsh {
    struct AFHAFHFSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFHAFHFSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFHAFHFSH>(arg0, 6, b"afhafhfsh", b"kedadgi", b"sfhsfgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/QmaRqMd3yNnfBvaYUsYD8diDuPab86tpboGf1Td5Na1V7y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AFHAFHFSH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFHAFHFSH>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFHAFHFSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

