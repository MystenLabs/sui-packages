module 0x7681060c6d6248bde3548a03dae284b2338c4967c775ea9b18e661da4323bae7::No {
    struct NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO>(arg0, 9, b"JUMP", b"No", b"jumping ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1389092073643515905/ROo_PqDh_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

