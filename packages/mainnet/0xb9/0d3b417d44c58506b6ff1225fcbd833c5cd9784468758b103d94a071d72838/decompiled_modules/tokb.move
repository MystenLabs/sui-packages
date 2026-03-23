module 0xb90d3b417d44c58506b6ff1225fcbd833c5cd9784468758b103d94a071d72838::tokb {
    struct TOKB has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: TOKB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKB>(arg0, 9, b"TOKB", b"Token B", b"Second test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/pcQyFduOqEY5yBz0pWpTwoCq2HpnmgkbqzhKC5GM4jY")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKB>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<TOKB>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<TOKB>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

