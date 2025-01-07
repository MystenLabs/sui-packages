module 0x1a735d6dcd32476d13015fdaa65a57dcc7319b50b7eb1537dde90d5abee089cf::pokecat {
    struct POKECAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POKECAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<POKECAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: POKECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POKECAT>(arg0, 9, b"POKE", b"SUI POKE CAT", b"SUI POKE CAT MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<POKECAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKECAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKECAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POKECAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POKECAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<POKECAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

