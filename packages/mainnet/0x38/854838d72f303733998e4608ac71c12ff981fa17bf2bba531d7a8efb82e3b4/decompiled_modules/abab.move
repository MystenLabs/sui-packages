module 0x38854838d72f303733998e4608ac71c12ff981fa17bf2bba531d7a8efb82e3b4::abab {
    struct ABAB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ABAB>, arg1: 0x2::coin::Coin<ABAB>) {
        0x2::coin::burn<ABAB>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ABAB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ABAB>>(0x2::coin::mint<ABAB>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ABAB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<ABAB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ABAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ABAB>(arg0, 6, b"ABAB", b"ABABABAB", b"ADASDASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aaa"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABAB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ABAB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ABAB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<ABAB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

