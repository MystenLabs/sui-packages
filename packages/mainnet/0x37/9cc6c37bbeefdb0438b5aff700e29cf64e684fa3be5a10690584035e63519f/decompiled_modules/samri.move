module 0x379cc6c37bbeefdb0438b5aff700e29cf64e684fa3be5a10690584035e63519f::samri {
    struct SAMRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMRI>(arg0, 6, b"SAMRI", b"SAMURAI", b"the samurai on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmeSoZ8PeXpz2AiraVapYHUUc9FmJvH1EbCptjGLvGAWWh?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAMRI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMRI>>(v2, @0xf0e3df7b49053bc2637aeba875c95b38364aff2a90eaf754b4983ea1b85bbd4c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

