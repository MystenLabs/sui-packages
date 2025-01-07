module 0x4ffbbf826741426394dd67918388e68aa3e7c5a2cd55380835432dfe48596dd5::ac_b_testsdgadgdafhsh {
    struct AC_B_TESTSDGADGDAFHSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_TESTSDGADGDAFHSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_TESTSDGADGDAFHSH>(arg0, 6, b"ac_b_testsdgadgdafhsh", b"TicketFortestfhf", b"Pre sale ticket of bonding curve pool for the following memecoin: testfhf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/undefined?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_TESTSDGADGDAFHSH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_TESTSDGADGDAFHSH>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_TESTSDGADGDAFHSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

