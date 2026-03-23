module 0x7903af3ec89bd184539cec2ebbffbb00dea5eababd1b8366d6c40d21fd919f1b::toka {
    struct TOKA has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: TOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKA>(arg0, 9, b"TOKA", b"Token A", b"A test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/pcQyFduOqEY5yBz0pWpTwoCq2HpnmgkbqzhKC5GM4jY")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKA>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<TOKA>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TOKA>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

