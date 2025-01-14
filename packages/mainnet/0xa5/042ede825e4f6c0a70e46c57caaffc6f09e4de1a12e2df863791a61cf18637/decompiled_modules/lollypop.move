module 0xa5042ede825e4f6c0a70e46c57caaffc6f09e4de1a12e2df863791a61cf18637::lollypop {
    struct LOLLYPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLYPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLYPOP>(arg0, 6, b"LOLLYPOP", b"LOLLYPOP TOKEN", b"Lollypop Is Community Based Memecoin Coin Project, Which Is Driven By Community. The Coin Will Be Used For Games, Staking, Liquidity Pools, Dao Voting, & Governance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736873192903.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLYPOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLYPOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

