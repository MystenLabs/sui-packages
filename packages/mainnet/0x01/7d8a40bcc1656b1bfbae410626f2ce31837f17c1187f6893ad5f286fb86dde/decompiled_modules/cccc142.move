module 0x17d8a40bcc1656b1bfbae410626f2ce31837f17c1187f6893ad5f286fb86dde::cccc142 {
    struct CCCC142 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CCCC142>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CCCC142>>(0x2::coin::mint<CCCC142>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CCCC142>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CCCC142>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CCCC142, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CCCC142>(arg0, 6, b"cccc142", b"cccc142", b"22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x28561b8a2360f463011c16b6cc0b0cbef8dbbcad.png?claimId=I499q1kcqiGjuADM"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCCC142>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CCCC142>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<CCCC142>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCCC142>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CCCC142>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CCCC142>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

