module 0xf2061c3f1184ab2d1caf78ca7d8c43bd43441b39ae633bec63d605bf2425c9b2::No_Jumper {
    struct NO_JUMPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_JUMPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_JUMPER>(arg0, 9, b"JUMPER", b"No Jumper", b"just jump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1389092073643515905/ROo_PqDh_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO_JUMPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_JUMPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

