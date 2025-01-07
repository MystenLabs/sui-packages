module 0x92e19a0c510937f41c0a3bd618ae38b5e5ce5f0173bea382f930d08a5c563be7::dengonsui {
    struct DENGONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENGONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENGONSUI>(arg0, 6, b"DengOnSui", b"Deng", b"Just a little hippo fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2e7e610715.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENGONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENGONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

