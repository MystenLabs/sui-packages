module 0x4c61fea04e4e29e6d643b293310657bc16ad5c90304d019079a2bb1a9dff035b::gegg {
    struct GEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEGG>(arg0, 6, b"GEGG", b"Gold Egg", b"YOUR AF EGG IS GOLD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_tsunami_with_eggs_81c8d85256.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

