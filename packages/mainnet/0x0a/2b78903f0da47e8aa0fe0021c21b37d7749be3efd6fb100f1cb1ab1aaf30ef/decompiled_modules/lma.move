module 0xa2b78903f0da47e8aa0fe0021c21b37d7749be3efd6fb100f1cb1ab1aaf30ef::lma {
    struct LMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMA>(arg0, 6, b"LMA", b"MessiGoat", b"Messi is the Goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWB9PUcUTz8uZTZ8LxSD3BXSSErLoHxpjNUMQ6VQBJJFV?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LMA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMA>>(v2, @0x9b8c355fcabf85b85921e0069aa66b2f71e669ae4e7214519c43009f1240e88d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

