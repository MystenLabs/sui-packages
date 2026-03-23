module 0xf6cd0f802073ab454f4ea46bf4ec81a2656d9f74af314dcf027881e48370fdad::gamma {
    struct GAMMA has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: GAMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMMA>(arg0, 9, b"GAMMA", b"Test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/a.png")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMMA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMMA>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<GAMMA>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<GAMMA>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

