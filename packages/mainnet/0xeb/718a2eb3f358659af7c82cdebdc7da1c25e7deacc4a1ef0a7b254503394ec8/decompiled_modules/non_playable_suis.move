module 0xeb718a2eb3f358659af7c82cdebdc7da1c25e7deacc4a1ef0a7b254503394ec8::non_playable_suis {
    struct NON_PLAYABLE_SUIS has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NON_PLAYABLE_SUIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<NON_PLAYABLE_SUIS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<NON_PLAYABLE_SUIS>(arg0, arg1)
    }

    fun init(arg0: NON_PLAYABLE_SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NON_PLAYABLE_SUIS>(arg0, 9, b"NPSUI", b"Non Playable Sui's", b"NPCs have bridged and become NPSUIs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/D2ojTo5SsWptEq2G4igHyUpEMmUXhAAPVAk61eEZbgxn.png?size=xl&key=d920e8"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NON_PLAYABLE_SUIS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NON_PLAYABLE_SUIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<NON_PLAYABLE_SUIS>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NON_PLAYABLE_SUIS>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NON_PLAYABLE_SUIS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<NON_PLAYABLE_SUIS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

