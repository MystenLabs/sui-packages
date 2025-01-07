module 0x8e20626c47c8bfeb7704eea9931f4843cf898b15054c402c9c5075e480f15ddf::sundog {
    struct SUNDOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUNDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUNDOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUNDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUNDOG>(arg0, 9, b"SUNDOG", b"SUI SUNDOG", b"SUI SUNDOG MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUNDOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNDOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUNDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUNDOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUNDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

