module 0x9e754c864c17627a81045e874675e5bf4a3366e840509a2dd770a433ab385d73::team {
    struct TEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEAM>(arg0, 6, b"TEAM", b"TEAMCOIN", b"We are TeamCoin, building a community of Hispanic INVESTORS in the blockchain never seen before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TEAM_72a8b61384.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

