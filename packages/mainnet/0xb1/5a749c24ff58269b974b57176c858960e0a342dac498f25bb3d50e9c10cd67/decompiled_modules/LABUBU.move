module 0xb15a749c24ff58269b974b57176c858960e0a342dac498f25bb3d50e9c10cd67::LABUBU {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<LABUBU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LABUBU>>(0x2::coin::split<LABUBU>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<LABUBU>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LABUBU>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<LABUBU>(arg0);
        };
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LABUBU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LABUBU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LABUBU>(arg0, 9, b"Labubu", b"Labubu", b"Labubu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bizweb.dktcdn.net/thumb/1024x1024/100/427/145/products/labubu-time-to-chill-38cm-popmart-3.jpg?v=1723167327887")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LABUBU>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LABUBU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LABUBU>>(0x2::coin::mint<LABUBU>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LABUBU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LABUBU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

