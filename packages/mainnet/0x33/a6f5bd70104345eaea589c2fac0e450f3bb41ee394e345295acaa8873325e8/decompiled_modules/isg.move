module 0x33a6f5bd70104345eaea589c2fac0e450f3bb41ee394e345295acaa8873325e8::isg {
    struct ISG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISG>(arg0, 6, b"ISG", b"Isagi", b"U20 World Cup MVP in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmchs2H5fhUfz7TUCFuiGwdWdcp2MT3H5YFKdas5eQPmyn?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ISG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISG>>(v2, @0x34f2bfa5185751daccab28dc0a74e46ca69b2907add825e8fe300047fac4246f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISG>>(v1);
    }

    // decompiled from Move bytecode v6
}

