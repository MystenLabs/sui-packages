module 0x835212a2a5b978edf5df8ab74fc30e0c42a6f351098db56025753beb1569c183::testolino {
    struct TESTOLINO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTOLINO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTOLINO>>(0x2::coin::mint<TESTOLINO>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TESTOLINO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TESTOLINO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TESTOLINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TESTOLINO>(arg0, 9, b"symbol", b"token name", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TESTOLINO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTOLINO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTOLINO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TESTOLINO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TESTOLINO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TESTOLINO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

