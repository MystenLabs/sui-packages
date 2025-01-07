module 0xd48ae422d3bd341a64cc86c359ded01286656bdc8ca8d981556ffff2a3206441::ticket_ifykyk {
    struct TICKET_IFYKYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKET_IFYKYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKET_IFYKYK>(arg0, 6, b"ticket_ifykyk", b"TicketFortestcoin", b"Pre sale ticket of bonding curve pool for the following memecoin: testcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmSWsdgiBtTdi5ZHoW4dMhmYyPt7v86BT1rzpVeqDXpPdd?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKET_IFYKYK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKET_IFYKYK>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKET_IFYKYK>>(v1);
    }

    // decompiled from Move bytecode v6
}

