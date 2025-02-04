module 0xa444816186d39f143f87266f9e4cce23da16cd1a92236917dfbc8f037b5d80d2::flycat {
    struct FLYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYCAT>(arg0, 6, b"FLYCAT", b"Fly Cat", b"Cat is fly! High to the sky!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_13_01_00_35_c58b7056a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

