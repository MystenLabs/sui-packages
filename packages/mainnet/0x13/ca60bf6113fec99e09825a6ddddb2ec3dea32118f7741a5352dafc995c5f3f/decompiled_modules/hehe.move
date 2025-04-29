module 0x13ca60bf6113fec99e09825a6ddddb2ec3dea32118f7741a5352dafc995c5f3f::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HEHE>, arg1: 0x2::coin::Coin<HEHE>) {
        0x2::coin::burn<HEHE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HEHE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HEHE>>(0x2::coin::mint<HEHE>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HEHE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<HEHE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HEHE>(arg0, 6, b"HEHE", b"HEHEHE", b"HEHEHEHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aaa"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HEHE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HEHE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<HEHE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

