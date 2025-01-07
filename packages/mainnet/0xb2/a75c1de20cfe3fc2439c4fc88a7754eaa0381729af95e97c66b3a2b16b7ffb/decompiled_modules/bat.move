module 0xb2a75c1de20cfe3fc2439c4fc88a7754eaa0381729af95e97c66b3a2b16b7ffb::bat {
    struct BAT has drop {
        dummy_field: bool,
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<BAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<BAT>(arg0, arg1, arg2, arg3);
    }

    entry fun block_accounts(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<BAT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!is_available(arg0, v1)) {
                0x2::coin::deny_list_add<BAT>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: BAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<BAT>(arg0, 6, b"BAT", b"BAT Token", b"You are good!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<BAT>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<BAT>(&mut v3, 100000000000000, @0x4e18d4e91071236c9d7eb4757311edfbbe2d92953a473792f374a46b6d48c467, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAT>>(v3, @0x0);
    }

    entry fun is_available(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_contains<BAT>(arg0, arg1)
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<BAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<BAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

