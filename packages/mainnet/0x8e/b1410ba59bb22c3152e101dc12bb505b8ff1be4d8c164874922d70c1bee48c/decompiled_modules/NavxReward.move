module 0x8eb1410ba59bb22c3152e101dc12bb505b8ff1be4d8c164874922d70c1bee48c::NavxReward {
    struct NAVXREWARD has drop {
        dummy_field: bool,
    }

    public entry fun DistributeReward(arg0: &mut 0x2::coin::TreasuryCap<NAVXREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<NAVXREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: NAVXREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVXREWARD>(arg0, 9, b"$ navxfi.cc - NAVI Reward", b"navxfi.cc", b"You're rewarded $10,000 for empowering the NAVI Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/navxfi/navxficc_icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVXREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVXREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

