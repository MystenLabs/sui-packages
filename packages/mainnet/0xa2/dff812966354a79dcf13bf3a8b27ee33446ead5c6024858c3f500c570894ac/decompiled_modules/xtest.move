module 0xa2dff812966354a79dcf13bf3a8b27ee33446ead5c6024858c3f500c570894ac::xtest {
    struct XTEST has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: XTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XTEST>(arg0, 9, b"XTEST", b"Test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/a.png")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XTEST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTEST>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<XTEST>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<XTEST>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

