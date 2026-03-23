module 0xf9cbe3e541a6422bd9a2f3f3db4b8a3cfc8559532fb5d6bf0892dfabace2a11c::siren {
    struct SIREN has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: SIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIREN>(arg0, 9, b"SIREN", b"Test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/a.png")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIREN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIREN>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<SIREN>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<SIREN>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

