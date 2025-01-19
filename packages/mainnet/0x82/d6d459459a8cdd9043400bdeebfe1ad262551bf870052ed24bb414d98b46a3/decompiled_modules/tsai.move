module 0x82d6d459459a8cdd9043400bdeebfe1ad262551bf870052ed24bb414d98b46a3::tsai {
    struct TSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSAI>(arg0, 6, b"TSAI", b"TRUMP SUI AI", b"Agent Trump on SUI | $TSAI | Making AI & Blockchain Great Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumpsuiailogo_33e1d3c6d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

