module 0xbb8e411cfc2fef8de31a9dd77f0ddd23f2283a595ebb5c53441e26b682ba9b3b::mar {
    struct MAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<MAR>(arg0, 2, b"MAR", b"MAR Token", b"MAR MAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifqbvbdj6h6wa2xpazr256h5zftsrypcrxmqd2sfuyjpfpyuvn3sm.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<MAR>>(v1, @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MAR>(&mut v3, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAR>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<MAR>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<MAR>(arg0, v1)) {
                0x2::coin::deny_list_add<MAR>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

