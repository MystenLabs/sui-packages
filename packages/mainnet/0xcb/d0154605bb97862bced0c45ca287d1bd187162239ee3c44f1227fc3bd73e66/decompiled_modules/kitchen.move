module 0xcbd0154605bb97862bced0c45ca287d1bd187162239ee3c44f1227fc3bd73e66::kitchen {
    struct KITCHEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITCHEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITCHEN>(arg0, 6, b"KITCHEN", b"kitchen", b"literraly a kitchen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmd2h8UCEgomzGTeBW76eUam33Lei5mhJZdiyuKRUuDFf1?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KITCHEN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITCHEN>>(v2, @0x2b87d1fdcb3b25676cc276c49ad0ebb4adffab623313ba2fbbd0225c28a944d8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITCHEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

