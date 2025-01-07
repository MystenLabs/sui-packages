module 0x8e0c86a620306d8d991c929a10fa6197b0d2870fca7080bea0fb1be2f0a2aa29::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    public entry fun add_addresses_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MANAGED>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<MANAGED>(arg0, arg1, arg2);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MANAGED>(arg0, 2, b"MANAGED", b"", b"", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MANAGED>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

