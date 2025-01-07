module 0xe4af3c73055487fb786a25c01a9ecc3d5eab9f4dc09ec9ef2d7b2a3e815247b7::tuce {
    struct TUCE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUCE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TUCE>>(0x2::coin::mint<TUCE>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TUCE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TUCE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TUCE>(arg0, 6, b"tuce", b"tuce", b"3333", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x28561b8a2360f463011c16b6cc0b0cbef8dbbcad.png?claimId=I499q1kcqiGjuADM"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUCE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TUCE>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<TUCE>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUCE>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TUCE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TUCE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

