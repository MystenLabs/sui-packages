module 0xcbef955a2aa5dc4074c8cbe3d3dfd41f5aa5044bc5d0fd3239d7ad7f7b2333f5::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 9, b"SUITE", b"Sui Sniper Bot", b"Fastest sniper/trading bot on SUI by $SUITE  Earn 35% of your friends' trading fees  Announcements - https://t.me/SuiteAnnouncements", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838373197781352448/ffd4oiy-.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITE>(&mut v2, 344000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

