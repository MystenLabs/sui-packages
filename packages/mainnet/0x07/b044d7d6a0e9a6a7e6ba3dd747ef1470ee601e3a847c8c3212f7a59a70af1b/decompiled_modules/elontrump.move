module 0x7b044d7d6a0e9a6a7e6ba3dd747ef1470ee601e3a847c8c3212f7a59a70af1b::elontrump {
    struct ELONTRUMP has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ELONTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ELONTRUMP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ELONTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ELONTRUMP>(arg0, 9, b"ELONTRUMP", b"ELONTRUMP", b"ELONTRUMP MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ELONTRUMP>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONTRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUMP>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ELONTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ELONTRUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ELONTRUMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

