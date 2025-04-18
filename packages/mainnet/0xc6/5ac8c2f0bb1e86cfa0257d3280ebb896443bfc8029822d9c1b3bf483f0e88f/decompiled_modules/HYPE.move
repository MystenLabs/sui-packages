module 0xc65ac8c2f0bb1e86cfa0257d3280ebb896443bfc8029822d9c1b3bf483f0e88f::HYPE {
    struct HYPE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HYPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HYPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HYPE>(arg0, 9, b"TRUMP", b"Trump with Musk president", b"Trump win election powered by Musk", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HYPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HYPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HYPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

