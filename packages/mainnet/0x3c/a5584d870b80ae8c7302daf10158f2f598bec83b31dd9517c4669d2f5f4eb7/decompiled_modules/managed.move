module 0x3ca5584d870b80ae8c7302daf10158f2f598bec83b31dd9517c4669d2f5f4eb7::managed {
    struct MANAGED has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: 0x2::coin::Coin<MANAGED>) {
        0x2::coin::burn<MANAGED>(arg0, arg1);
    }

    fun init(arg0: MANAGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MANAGED>(arg0, 2, b"OJOJ", b"ojoj", b"Opis tokena", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/2bJNwVp.jpg")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MANAGED>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGED>(arg0, arg1, arg2, arg3);
    }

    public fun odmrazanie(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MANAGED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MANAGED>(arg0, arg1, arg2, arg3);
    }

    public fun zamrazanie(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MANAGED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MANAGED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

