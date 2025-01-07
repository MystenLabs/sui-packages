module 0xe715b95c0ae5f07809f65bd606be49955485cbcf92e3d8d4a1faab9f1a9c80ba::suimdog {
    struct SUIMDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMDOG>(arg0, 6, b"SUIMDOG", b"Suimin Dog", b"The now trending suiming dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimin_Dog_72d9b649f5.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

