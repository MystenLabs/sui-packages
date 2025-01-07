module 0x5d0178666d38b3aae8f135dbfd7491848b984d98f2e411bd90b6e8435b5d6762::BITCOINCHAIN {
    struct BITCOINCHAIN has drop {
        dummy_field: bool,
    }

    public entry fun add_addresses_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BITCOINCHAIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<BITCOINCHAIN>(arg0, arg1, arg2);
    }

    fun init(arg0: BITCOINCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BITCOINCHAIN>(arg0, 2, b"BITCOINCHAIN", b"", b"", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOINCHAIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOINCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BITCOINCHAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITCOINCHAIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BITCOINCHAIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

