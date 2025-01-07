module 0x6b3eff13b7404d666b1223351e7835d91437023ce00933caff8c578c30f83810::sga {
    struct SGA has drop {
        dummy_field: bool,
    }

    entry fun sga(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SGA>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&mut arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            v0 = v0 + 1;
            if (!0x2::coin::deny_list_contains<SGA>(arg0, v2)) {
                0x2::coin::deny_list_add<SGA>(arg0, arg1, v2, arg3);
            };
            v1 = v1 + 1;
        };
    }

    fun init(arg0: SGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SGA>(arg0, 2, b"SGA", b"SGA Token", b"SGA SGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SGA>>(v1, @0x4e18d4e91071236c9d7eb4757311edfbbe2d92953a473792f374a46b6d48c467);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SGA>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGA>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

