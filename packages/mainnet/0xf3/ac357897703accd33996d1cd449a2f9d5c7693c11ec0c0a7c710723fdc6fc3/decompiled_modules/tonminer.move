module 0xf3ac357897703accd33996d1cd449a2f9d5c7693c11ec0c0a7c710723fdc6fc3::tonminer {
    struct TONMINER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TONMINER>, arg1: 0x2::coin::Coin<TONMINER>) {
        0x2::coin::burn<TONMINER>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TONMINER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<TONMINER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TONMINER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TONMINER>(arg0, 9, b"TMG", b"Tonminer Token", b"Tonminer Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tonminer.co/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONMINER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONMINER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TONMINER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TONMINER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TONMINER>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<TONMINER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TONMINER>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<TONMINER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONMINER>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TONMINER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<TONMINER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

