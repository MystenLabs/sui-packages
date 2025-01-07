module 0xa7d60f9e89f9efae7c1e8fbcebd83e329e5b2e795efbdb113ccc16a7a4507b94::scubadog {
    struct SCUBADOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SCUBADOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SCUBADOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SCUBADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SCUBADOG>(arg0, 9, b"ScubaDog", b"Scuba Dog", b"Scuba Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SCUBADOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCUBADOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBADOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SCUBADOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SCUBADOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SCUBADOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

