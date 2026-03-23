module 0x6e092a4d27cbdb73482f20b347e166e1f7e59763aa36b7f0811284ed90494aa2::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 9, b"AAAA", b"SIREN", b"ffff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreifsa2tdeqpv74pe2wvqrzexb2ihku5h3tv5q76k44rmlkrjhxe36a")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<AAAA>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<AAAA>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

