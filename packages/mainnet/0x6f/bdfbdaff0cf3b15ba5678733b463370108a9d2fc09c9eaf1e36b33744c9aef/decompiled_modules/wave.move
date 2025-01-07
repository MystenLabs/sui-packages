module 0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAVE>, arg1: 0x2::coin::Coin<WAVE>) {
        0x2::coin::burn<WAVE>(arg0, arg1);
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<WAVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<WAVE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<WAVE>(arg0, 9, b"WAVE", b"Wave Token", b"Wave Token is a digital asset built on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.walletapp.waveonsui.com/logos/wave.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WAVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAVE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WAVE>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun transfer_deny_cap(arg0: 0x2::coin::DenyCap<WAVE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WAVE>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<WAVE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(arg0, arg1);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<WAVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<WAVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

