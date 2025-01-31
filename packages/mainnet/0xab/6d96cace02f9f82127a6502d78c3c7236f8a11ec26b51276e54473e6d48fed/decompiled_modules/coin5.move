module 0xab6d96cace02f9f82127a6502d78c3c7236f8a11ec26b51276e54473e6d48fed::coin5 {
    struct Holder has store, key {
        id: 0x2::object::UID,
    }

    struct COIN5 has drop {
        dummy_field: bool,
    }

    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    fun init(arg0: COIN5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN5>(arg0, 9, b"A", b"a", b"A", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Holder{id: 0x2::object::new(arg1)};
        let v3 = Key{dummy_field: false};
        0x2::dynamic_object_field::add<Key, 0x2::coin::TreasuryCap<COIN5>>(&mut v2.id, v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN5>>(v1);
        0x2::transfer::public_share_object<Holder>(v2);
    }

    // decompiled from Move bytecode v6
}

