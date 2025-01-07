module 0x46fc5a0fa406ca8deaa53eb25f44ed0c62c14c6598b30bf5925c8777d9ac8e6e::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"bread", b"bread", x"627265616420f09f918d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVRGgyoRiMBTcforXxqC9aF9Rq1rLtFs7FPTJSw97SwuV?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BREAD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v2, @0x1b0192cf7e1eadff280a3a40806e3220d6da883390e34d9b2dad908f81e7d121);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

