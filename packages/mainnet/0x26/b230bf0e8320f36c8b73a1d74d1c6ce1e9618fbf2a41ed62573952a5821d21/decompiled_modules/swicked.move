module 0x26b230bf0e8320f36c8b73a1d74d1c6ce1e9618fbf2a41ed62573952a5821d21::swicked {
    struct SWICKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWICKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWICKED>(arg0, 6, b"SWICKED", b"WICKED SUI", x"546865206d6f73742066616d6f757320656d6f6a69206f6e20547769636820616e6420446973636f72642e205768656e20506570652068617665206d6f672c207468656e20686520626563616d652024535749434b4544206f6e205375692e0a0a4d6f766570756d700a0a40535749434b4544535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3838_3626fcdd1f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWICKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWICKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

