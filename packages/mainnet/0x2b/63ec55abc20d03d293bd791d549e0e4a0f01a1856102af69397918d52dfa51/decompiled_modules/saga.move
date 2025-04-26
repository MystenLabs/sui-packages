module 0x2b63ec55abc20d03d293bd791d549e0e4a0f01a1856102af69397918d52dfa51::saga {
    struct SAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGA>(arg0, 6, b"SAGA", b"MARBLES UNIVERSE", x"4120576562332047616d6520506f7765726564206279205355492e20506c617920596f7572204d6172626c657320616e64204561726e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_25_13_50_55_cb9bbe0897.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

