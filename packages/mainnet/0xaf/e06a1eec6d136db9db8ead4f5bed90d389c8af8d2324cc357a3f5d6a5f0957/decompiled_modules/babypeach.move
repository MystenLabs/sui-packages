module 0xafe06a1eec6d136db9db8ead4f5bed90d389c8af8d2324cc357a3f5d6a5f0957::babypeach {
    struct BABYPEACH has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYPEACH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BABYPEACH>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BABYPEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYPEACH>(arg0, 9, b"Babypeach", b"Sui Baby Peach", b"Sui Baby Peach", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYPEACH>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPEACH>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEACH>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYPEACH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYPEACH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BABYPEACH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

