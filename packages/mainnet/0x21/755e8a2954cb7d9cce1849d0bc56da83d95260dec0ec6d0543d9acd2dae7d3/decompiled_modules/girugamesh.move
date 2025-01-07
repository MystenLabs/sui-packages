module 0x21755e8a2954cb7d9cce1849d0bc56da83d95260dec0ec6d0543d9acd2dae7d3::girugamesh {
    struct GIRUGAMESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRUGAMESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRUGAMESH>(arg0, 6, b"GIRUGAMESH", b"GIRUGAMESH", x"4749525547414d455348210a4749525547414d455348210a4749525547414d45534821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmZyUfu2DNVjrzyoYF7evuaBXN4ipNUN9u9NZQxpUgjr7w?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIRUGAMESH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRUGAMESH>>(v2, @0x4410b378438d8a6fd9eacf565b16615d9589b83c62f2d11a16f4e4ed95a0c3ca);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIRUGAMESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

