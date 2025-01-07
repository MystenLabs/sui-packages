module 0x9b877b577c11c60e52629a75b43baa9034ff49e0050ea394e31a9e40c07276d0::qie11111 {
    struct QIE11111 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<QIE11111>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<QIE11111>>(0x2::coin::mint<QIE11111>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<QIE11111>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<QIE11111>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: QIE11111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<QIE11111>(arg0, 6, b"qie11111", b"qie11111", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"2"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QIE11111>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<QIE11111>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<QIE11111>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QIE11111>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<QIE11111>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<QIE11111>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

