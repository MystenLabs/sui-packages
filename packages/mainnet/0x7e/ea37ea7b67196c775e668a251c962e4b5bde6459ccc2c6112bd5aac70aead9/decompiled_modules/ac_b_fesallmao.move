module 0x7eea37ea7b67196c775e668a251c962e4b5bde6459ccc2c6112bd5aac70aead9::ac_b_fesallmao {
    struct AC_B_FESALLMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_FESALLMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_FESALLMAO>(arg0, 6, b"ac_b_fesallmao", b"TicketForfesalcoin", b"Pre sale ticket of bonding curve pool for the following memecoin: fesalcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/QmaRqMd3yNnfBvaYUsYD8diDuPab86tpboGf1Td5Na1V7y?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_FESALLMAO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_FESALLMAO>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_FESALLMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

