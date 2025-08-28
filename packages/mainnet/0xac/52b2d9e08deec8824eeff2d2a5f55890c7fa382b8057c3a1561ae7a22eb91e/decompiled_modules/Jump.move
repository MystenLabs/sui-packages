module 0xac52b2d9e08deec8824eeff2d2a5f55890c7fa382b8057c3a1561ae7a22eb91e::Jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 9, b"NO", b"Jump", b"no jumping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1389092073643515905/ROo_PqDh_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

