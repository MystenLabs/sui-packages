module 0x1e244ea6370e05954d8e77256452fe942c9e94619a943ef3724d7e93676c6b7e::eub {
    struct EUB has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<EUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<EUB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: EUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<EUB>(arg0, 6, b"EUB", b"EUB", b"The EUB token is a stablecoin produced by BISON Company.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafybeig672qv4vjrjlajtqba625q7dujboaauakkfnalwniapjb7s7fjiy"))), false, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<EUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<EUB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

