module 0x5b9cea4065674dd61c8a9f9e576d360950f20f8912f05428a4c56be224df9669::tongold {
    struct TONGOLD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TONGOLD>, arg1: 0x2::coin::Coin<TONGOLD>) {
        0x2::coin::burn<TONGOLD>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TONGOLD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<TONGOLD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TONGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TONGOLD>(arg0, 9, b"TONGOLD", b"TONGOLD Token", b"TONGOLD Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.walletapp.waveonsui.com/logos/ocean.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONGOLD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TONGOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TONGOLD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TONGOLD>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<TONGOLD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TONGOLD>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<TONGOLD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONGOLD>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TONGOLD>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<TONGOLD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

