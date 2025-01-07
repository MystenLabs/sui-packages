module 0xda5535584ba91433e2496e6826212f72c651cc40edd6136a391bfb1be08e4095::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"SUIMOONCAT", b"All $SUI holders need CAT to go to the mooooooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmd3bdjKw5rUij9mA9XqP4sSuausivufciyyAbHmCyxdLo?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v2, @0xec436637384f19597052c1bb830ec4d665c4c57adfb3b9cb91e164cfac2432ec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

