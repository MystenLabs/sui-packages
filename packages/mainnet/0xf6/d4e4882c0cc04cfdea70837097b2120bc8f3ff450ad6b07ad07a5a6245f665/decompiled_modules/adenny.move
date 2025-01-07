module 0xf6d4e4882c0cc04cfdea70837097b2120bc8f3ff450ad6b07ad07a5a6245f665::adenny {
    struct ADENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENNY>(arg0, 6, b"ADENNY", b"adenny", b"i found sooey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmSc92DHxM84UyCfZTYiLMjRV9pcGMitLkPLhPKq3V9oan?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADENNY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENNY>>(v2, @0xd0ec85e05c47f5314189734907fa69f24e78df8427ebc18ee10603f440c53f28);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

