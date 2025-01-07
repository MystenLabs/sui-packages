module 0x7cb8801a0eebdd6f42ac57d265964ac3b21f087813442f78ad47d09e075e6465::babygrok {
    struct BABYGROK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYGROK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYGROK>>(0x2::coin::mint<BABYGROK>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYGROK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BABYGROK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BABYGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYGROK>(arg0, 9, b"Baby Grok", b"BabyGrok", b"One Of the best memes on BSC, Strong team behind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYGROK>(&mut v3, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYGROK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYGROK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYGROK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYGROK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BABYGROK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

