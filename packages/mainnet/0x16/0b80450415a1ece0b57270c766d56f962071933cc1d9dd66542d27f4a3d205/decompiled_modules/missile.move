module 0x160b80450415a1ece0b57270c766d56f962071933cc1d9dd66542d27f4a3d205::missile {
    struct MISSILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISSILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISSILE>(arg0, 6, b"missile", b"SendNuke", b"for our supreme leader, imma send nuke to $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmZaTfnire8bAiobg4tLmJN4LHsBUqEiDsxNs5451QkTDy?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MISSILE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISSILE>>(v2, @0x2d46457047c785f15763402c663badcf60afc840c5afd132f9745580a7f9dee9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISSILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

