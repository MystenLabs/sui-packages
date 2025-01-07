module 0xe9e46b827bfaee7cc40f9afa6253d0fdd5ebdeaf0e24ec32f300ae0969abd262::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ABC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ABC>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ABC>(arg0, 9, b"ABC", b"ABC", b"ABC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ABC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<ABC>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ABC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ABC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

