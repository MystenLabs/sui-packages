module 0x3ea88d9c3e0379451e5e37cbe89ffb879c665d0be78bc1952b64e963c7d5d1c4::Dumbos {
    struct DUMBOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBOS>(arg0, 9, b"DUMBOS", b"Dumbos", b"tweedle dumb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz985UhXcAA-cLj?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMBOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

