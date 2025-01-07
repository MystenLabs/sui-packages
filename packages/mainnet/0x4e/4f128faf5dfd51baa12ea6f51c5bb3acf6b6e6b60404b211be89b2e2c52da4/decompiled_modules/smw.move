module 0x4e4f128faf5dfd51baa12ea6f51c5bb3acf6b6e6b60404b211be89b2e2c52da4::smw {
    struct SMW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SMW>, arg1: 0x2::coin::Coin<SMW>) {
        0x2::coin::burn<SMW>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SMW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<SMW>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SMW>(arg0, 9, b"SMW", b"SMW Token", b"SMW Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://walletsmart.co/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMW>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SMW>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SMW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SMW>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<SMW>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SMW>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<SMW>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMW>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SMW>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<SMW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

