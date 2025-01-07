module 0xdb69031a5819d3ee67bbad815872a9268da48a4da1224a769c5d4299bc31c9b7::ac_b_afhafhfsh {
    struct AC_B_AFHAFHFSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_AFHAFHFSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_AFHAFHFSH>(arg0, 6, b"ac_b_afhafhfsh", b"TicketForkedadgi", b"Pre sale ticket of bonding curve pool for the following memecoin: kedadgi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/QmaRqMd3yNnfBvaYUsYD8diDuPab86tpboGf1Td5Na1V7y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_AFHAFHFSH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_AFHAFHFSH>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_AFHAFHFSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

