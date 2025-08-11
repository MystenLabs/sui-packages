module 0xc50565ff0bad759069880157dbe8bf9230da0c19919b60ae74d7f0bcaf9c2c8::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGER>(arg0, 9, b"SSS", b"homie", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MANAGER>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANAGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

