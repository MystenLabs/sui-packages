module 0xd540e39edf7d2708fc829ea7575f3fd21d2ba71d734b06cb621d67a2dd52c692::frenswifout {
    struct FRENSWIFOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENSWIFOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENSWIFOUT>(arg0, 6, b"FRENSWIFOUT", b"FRENSWIFOUTHAT", b"FRENSWIFOUTHAT ARE GOING TO RULE SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmTebCrNCuzgKqZDk5UesNxyrGCz2MqkdjriHc9rqaG5uk?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRENSWIFOUT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENSWIFOUT>>(v2, @0x1adc69ead330768c1ef66b8e710b15b2c04526f72c94ca05bd1be9feff0a9e50);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENSWIFOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

