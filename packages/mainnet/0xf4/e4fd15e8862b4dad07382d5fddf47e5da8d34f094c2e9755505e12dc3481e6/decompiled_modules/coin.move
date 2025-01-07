module 0xf4e4fd15e8862b4dad07382d5fddf47e5da8d34f094c2e9755505e12dc3481e6::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop {
        cap_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 0, b"fu01", b"Test fu01 Coin", b"Coin is the test token of Bridge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/uolc139PaGQLg6U4Oes19x3mv0by5geOjW2CSi3mMKc")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = InitEvent{
            cap_id      : 0x2::object::id<0x2::coin::TreasuryCap<COIN>>(&v3),
            metadata_id : 0x2::object::id<0x2::coin::CoinMetadata<COIN>>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

