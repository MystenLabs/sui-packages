module 0xc743e827fee8720713f31a15a168ea331b1650bb3214e30987624e9ea9fee4e2::logoc {
    struct LOGOC has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: LOGOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOGOC>(arg0, 9, b"LOGOC", b"Logo Test", b"OKX logo display test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifsa2tdeqpv74pe2wvqrzexb2ihku5h3tv5q76k44rmlkrjhxe36a")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOGOC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOGOC>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<LOGOC>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<LOGOC>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

