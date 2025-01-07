module 0x93bbac84f2045eebc2403d59d3bdccfaee00b5f317c41fa1187d8285102c7619::nubcat {
    struct NUBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBCAT>(arg0, 6, b"NUBCAT", b"NubCat", b"nub is a silly cat for the silliest of goobers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_890e5a324e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

