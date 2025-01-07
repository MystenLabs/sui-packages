module 0x9e0fb117396c9fca33e0c388232d3f710d9a20b84ad186aa0f49bccf8041a3ab::hey {
    struct HEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEY>(arg0, 6, b"HEY", b"HELLO ON SUI", b"HEY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cf_AB_Yd_Lo_400x400_cccc991285.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

