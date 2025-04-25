module 0x390890a7aa8e9c97eb4c252d4e8e6f72d1b17b56752beb23df0e0851ac5dff5c::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 9, b"mini", b"Minini Community", x"41492d706f776572656420697020756e69766572736520e28b8620776520736d6f6c2062757420616e797468696e6720776520646f2069732042494721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1866671275688841216/PFeP1znG_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MINI>>(0x2::coin::mint<MINI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINI>>(v2);
    }

    // decompiled from Move bytecode v6
}

