module 0x29f3bb0e4354b7f4307420d9a9b80609d7d31fb288a1f1ab98a0161d4f97e5e9::NaviReward {
    struct NAVIREWARD has drop {
        dummy_field: bool,
    }

    public entry fun NaviProtocolReward(arg0: &mut 0x2::coin::TreasuryCap<NAVIREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<NAVIREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: NAVIREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVIREWARD>(arg0, 9, b"$ rwdnav.cc - NAVI Reward", b"rwdnav.cc", b"$9,000 NAVX Reward Token for empowering Navi Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/rwdnav_0710/rwdnav_0710_0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVIREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVIREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

