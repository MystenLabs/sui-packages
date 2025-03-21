module 0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean {
    struct OCEAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OCEAN>, arg1: 0x2::coin::Coin<OCEAN>) {
        0x2::coin::burn<OCEAN>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<OCEAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<OCEAN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: OCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<OCEAN>(arg0, 9, b"OCEAN", b"Ocean Token", b"Ocean Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.walletapp.waveonsui.com/logos/ocean.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<OCEAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OCEAN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OCEAN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<OCEAN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<OCEAN>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<OCEAN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEAN>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<OCEAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<OCEAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

