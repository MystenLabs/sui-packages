module 0x98a465ac85c758a62c67e89cc198c8e831665e97cffcd61ce8c1b3baedfbce84::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 6, b"MCGA", b"makecrogreatagain", b"make cro great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmbiXjcEw4HFEAdV2AzH47TW4kj2n1gM6SsExPtQYnZq1P?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCGA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v2, @0xd3a665066ee7f19628771af3b4d81a7719a2a1502d20d3ff8cf3b176d20a3fb2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

