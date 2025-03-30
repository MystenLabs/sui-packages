module 0x20c6370ff100f8cc43d4a331b2e9bb29bd27ca39662bf9cb85b8bad8147cacb3::seed {
    struct SEED has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEED>>(0x2::coin::mint<SEED>(arg0, arg1, arg3), arg2);
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SEED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SEED>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SEED>(arg0, 5, b"SEED", b"SEED", b"SEED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/33468.png")), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEED>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SEED>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEED>>(v2, v3);
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SEED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SEED>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<SEED>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEED>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

