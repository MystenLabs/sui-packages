module 0x587efc359a7675fbc33601416994e4cfbc126eeb7a3ec3b1c4e6aee4fc1d4f29::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"CAMP", b"BaseCamp", b"Welcome to the $CAMP | Sui Basecamp 2026 | Build. Connect. Grow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.suipump.org/icons/c9f8e531b4a5a9a81b061750735c493f.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPUMP>>(0x2::coin::mint<SUIPUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

