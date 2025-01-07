module 0x53c37afd9ce343fa4e7a00e670d96d8237d3a09084fea67ba6d086888df5cd28::sheepy {
    struct SHEEPY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SHEEPY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SHEEPY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SHEEPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SHEEPY>(arg0, 9, b"SHEEPY", b"SHEEPY", b"SHEEPY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SHEEPY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEEPY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEPY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SHEEPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SHEEPY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SHEEPY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

