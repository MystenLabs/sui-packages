module 0xb6cec4cee2d18934254adeb720e81913d5069ca4954aa8384c5db1e5678d0e18::oricat {
    struct ORICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORICAT>(arg0, 6, b"ORICAT", b"ORICAT SUI ", b"SUI ORICAT is the notorious local drug dealer in Matt Furie Boy's Club universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731045693256.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

