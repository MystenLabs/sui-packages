module 0x64d05883b180287c40296de8e5cfcf490e652aa2405994f6b49c6adeadde8c3c::hund {
    struct HUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUND>(arg0, 6, b"HUND", b"HUND Official", b"The one and only German Shepherd memecoin that integrates AI solutions, a decentralized exchange (DEX), various tools, a launchpad, NFTs, game, and memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_TD_8_Kql_400x400_a863464545.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUND>>(v1);
    }

    // decompiled from Move bytecode v6
}

