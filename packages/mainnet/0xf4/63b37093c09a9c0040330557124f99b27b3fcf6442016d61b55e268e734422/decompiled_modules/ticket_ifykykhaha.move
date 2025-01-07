module 0xf463b37093c09a9c0040330557124f99b27b3fcf6442016d61b55e268e734422::ticket_ifykykhaha {
    struct TICKET_IFYKYKHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKET_IFYKYKHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKET_IFYKYKHAHA>(arg0, 6, b"ticket_ifykykhaha", b"TicketForifykyk", b"Pre sale ticket of bonding curve pool for the following memecoin: ifykyk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmRcKt4aLmePXVpuhnBMXTtwKZAxFQKEnpWpn9BJkM3g46?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKET_IFYKYKHAHA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKET_IFYKYKHAHA>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKET_IFYKYKHAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

