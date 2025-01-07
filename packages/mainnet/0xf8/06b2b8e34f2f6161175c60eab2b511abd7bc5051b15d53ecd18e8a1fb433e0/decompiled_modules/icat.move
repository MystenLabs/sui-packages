module 0xf806b2b8e34f2f6161175c60eab2b511abd7bc5051b15d53ecd18e8a1fb433e0::icat {
    struct ICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICAT>(arg0, 6, b"ICAT", b"IRLCAT", b"My name is Sisy i love crypto :p", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732284392226.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

