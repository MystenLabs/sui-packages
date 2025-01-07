module 0x128a80b2f9e0746b2d7bbc12582b5b4bd47b20605486033a4c6f52e7111b29a4::kap {
    struct KAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAP>(arg0, 6, b"KAP", b"Kappa", b"Kappa, Native to the water of $sui basically the sui blockchains pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmV3TnKhpX9fV6thtHsgXL1dcQcXkiLv3ES82hRGT6w25A?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAP>>(v2, @0xe0ecedac609015a8143863f5da51296f46585e0fa857d9c3119e1e0eec8697ce);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

