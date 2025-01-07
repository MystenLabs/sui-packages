module 0xbc3b3b15873a52524a746f87d4d526d4b2201226e1978a1184234d7daf376007::fesallmao {
    struct FESALLMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FESALLMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FESALLMAO>(arg0, 6, b"fesallmao", b"fesalcoin", b"fesallmaocoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/QmaRqMd3yNnfBvaYUsYD8diDuPab86tpboGf1Td5Na1V7y?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FESALLMAO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FESALLMAO>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FESALLMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

