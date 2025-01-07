module 0xa46e8dd75ed10b8fd847a7029ba5d1241038bf5ddc08064404a86108877fdd1::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ABC>, arg1: 0x2::coin::Coin<ABC>) {
        0x2::coin::burn<ABC>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ABC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ABC>>(0x2::coin::mint<ABC>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ABC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<ABC>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ABC>(arg0, 6, b"ABC", b"TESTABC", b"BABABAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aaa"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ABC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ABC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<ABC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

