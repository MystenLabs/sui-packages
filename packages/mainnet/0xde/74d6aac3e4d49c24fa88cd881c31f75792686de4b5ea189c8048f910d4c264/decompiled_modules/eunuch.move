module 0xde74d6aac3e4d49c24fa88cd881c31f75792686de4b5ea189c8048f910d4c264::eunuch {
    struct EUNUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUNUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUNUCH>(arg0, 6, b"EUNUCH", b"Eunuch the Guardians of Women", x"68747470733a2f2f656e2e77696b6970656469612e6f72672f77696b692f45756e7563680a0a68747470733a2f2f70756d702e66756e2f416a59356f446462474d4271587062715a584174456f436448524263784d675a3364644c53684d525133744d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmdXFtZvvpAVH7bayYfnjCdfYRMgCBhEdw9YN6jSRUS3ZK?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EUNUCH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUNUCH>>(v2, @0x7f305ab7b9550df32ad90e5fe1951a405e4a5114e4f943c9c5803e53b81d9a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUNUCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

