module 0x5dbec4a652d96c471439b0832021e988abc8b4d269ad3d62c2bfd52525b9ea0::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TEST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<TEST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TEST>(arg0, 6, b"TD", b"TESTD", b"Do good, and you're good", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST>(arg0, arg1, arg2, arg3);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TEST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

