module 0xbbeb07e46983d2358e9872443e9f10c8f2f669a7a3377b9527aa23f3856eb7b7::lucat {
    struct LUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCAT>(arg0, 6, b"LUCAT", b"Lucky Cat", b"Infinite Luck, Infinite Wealth, Infinite Eight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031921_a32f842205.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

