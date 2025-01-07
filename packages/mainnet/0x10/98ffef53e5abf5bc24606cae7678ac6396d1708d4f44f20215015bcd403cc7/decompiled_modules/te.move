module 0x1098ffef53e5abf5bc24606cae7678ac6396d1708d4f44f20215015bcd403cc7::te {
    struct TE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TE>, arg1: 0x2::coin::Coin<TE>) {
        0x2::coin::burn<TE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TE>>(0x2::coin::mint<TE>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<TE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TE>(arg0, 6, b"TE", b"TEST", b"test test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aaa"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<TE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

