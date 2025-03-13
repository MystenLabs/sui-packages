module 0x96330809a5574a019cc20a444414657cf3b237bc05bc2785c7f98df4d2f7d90d::hao1 {
    struct HAO1 has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAO1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HAO1>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HAO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAO1>(arg0, 9, b"HAO1", b"HAO001", b"001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZPRo5ILl4Tew10m2HkWjfk8vgdhNwdxzvbw&s"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HAO1>(&mut v3, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAO1>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAO1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAO1>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAO1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HAO1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

