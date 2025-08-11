module 0xf3d3350dc9b8a42cdfd62984fc191b79f30854443cdd5bb18f4c0c5c19a89173::treasure {
    struct TREASURE has drop {
        dummy_field: bool,
    }

    public entry fun add_to_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TREASURE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TREASURE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TREASURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TREASURE>(arg0, 2, b"TREASURE", b"TREASURE", x"556e6c656173682074686520706f776572206f6620626c6f636b636861696ee2809466617374207472616e73616374696f6e732c206c6f7720666565732c20616e6420696e66696e69746520706f73736962696c69746965732e202d2068747470733a2f2f73756974726561737572652e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suitreasure.fun")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TREASURE>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASURE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TREASURE>>(v1, v4);
    }

    public entry fun remove_from_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TREASURE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TREASURE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

