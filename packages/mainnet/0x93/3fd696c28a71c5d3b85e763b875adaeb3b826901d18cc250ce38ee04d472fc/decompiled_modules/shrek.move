module 0x933fd696c28a71c5d3b85e763b875adaeb3b826901d18cc250ce38ee04d472fc::shrek {
    struct SHREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREK>(arg0, 9, b"SHREK", b"SHREK", b"SHREK 555", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/S/pv-target-images/dbf6812f59e5080cf420f1056bfceb66f7d6a43a8df19ace503ea70596afc0ff._SX1080_FMjpg_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHREK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

