module 0x887039f670629aa72061e8250f64829c31b487258df39775c4baec4418e464a::dogt {
    struct DOGT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGT>, arg1: 0x2::coin::Coin<DOGT>) {
        0x2::coin::burn<DOGT>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<DOGT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<DOGT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<DOGT>(arg0, 9, b"DOGT", b"Dog's Token", b"Dog's Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogminer.co/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DOGT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGT>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<DOGT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DOGT>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<DOGT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGT>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<DOGT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<DOGT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

