module 0x2de0cd042074394f118333137706b4c37fe02b039f281a5e2702186f726a558e::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 9, b"HOPCAT", b"Hop Hop Cat", b"Sui First Hop Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1837947853060096000/rt5E9V_p_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

