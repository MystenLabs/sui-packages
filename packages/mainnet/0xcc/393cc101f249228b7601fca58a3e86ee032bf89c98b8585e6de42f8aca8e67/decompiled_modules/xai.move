module 0xcc393cc101f249228b7601fca58a3e86ee032bf89c98b8585e6de42f8aca8e67::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 6, b"xAI", b"xAI", b"FHFGHFGHFDGHFDGHFGDH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmdtiTWQxESbuc8MRk43DsUUGW6ftMzV49nT1UYZzeQL2v?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v2, @0x5dae7959080b2e8777fd34e0bfe286fffa1e571834f06e9a08bab9bd2430f772);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

