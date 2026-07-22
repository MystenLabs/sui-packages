module 0xb4be6363c77cae1a515c0e6feaca0d5b6536aae15d5dbec8844bf3edb8a60c85::remi {
    struct REMI has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REMI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REMI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: REMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REMI>(arg0, 6, b"REMI", b"REMI", b"This is the test REMI TOKEN on sui testnet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafkreicypswphw27q3tbh23cdngfh4znwzwzjkn6wqm4vacnhovxivhhrm?pinataGatewayToken=pzZ8z2waS2BwZfELKiw7R9UgTQTEjULXQGj12UeIvZY4rwIto_M9k3MCrvv3cb1J"))), false, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REMI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REMI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

