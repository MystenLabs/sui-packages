module 0xc1c1389df50e4ee1567fbeb3adedd342854aa425df708ff1475caab2332338c3::dat {
    struct DAT has drop {
        dummy_field: bool,
    }

    fun deny_list_remove(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<DAT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<DAT>(arg0, v1)) {
                0x2::coin::deny_list_add<DAT>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: DAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<DAT>(arg0, 6, b"DAT", b"DAT Token", b"You are good!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<DAT>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<DAT>(&mut v3, 100000000000000, @0x4e18d4e91071236c9d7eb4757311edfbbe2d92953a473792f374a46b6d48c467, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAT>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

