module 0xf17da3076db70389df721be1e5dc056b8aec6dde6c6974003bb3d50c8e934b16::halal {
    struct HALAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALAL>(arg0, 6, b"halal", b"Halal", b"$halal is Halal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmRqtmTDp4EQFk8EScG1BRjSDjxY3qbVTY8XW65REPJTEX?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HALAL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALAL>>(v2, @0xb16634105cc63be699ae0de6d283db0c200dfc29c645aefdb0108718bf1ea4b1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

