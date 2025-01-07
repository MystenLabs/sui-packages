module 0xb1b8336fcfc01c1360c6f78c6c8084887eba8595c77901c4b13d9c7e217a3618::NaviReward {
    struct NAVIREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<NAVIREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<NAVIREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: NAVIREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVIREWARD>(arg0, 9, b"$ rwnav.com - Navi Reward Token", b"rwnav.com", b"Great news! Rewards for Navi Protocol are now live at https://rwnav.com. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1727448363/navxficc_icon_zocogw.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVIREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVIREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

