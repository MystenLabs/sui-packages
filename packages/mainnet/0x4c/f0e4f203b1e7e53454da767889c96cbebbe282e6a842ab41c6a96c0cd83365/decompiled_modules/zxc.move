module 0x4cf0e4f203b1e7e53454da767889c96cbebbe282e6a842ab41c6a96c0cd83365::zxc {
    struct ZXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ZXC>(arg0, 6, b"ZXC", b"ZXC Token", b"ZXC ZXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXC>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ZXC>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<ZXC>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXC>>(v3, @0x0);
    }

    entry fun meda(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<ZXC>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&mut arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            v0 = v0 + 1;
            if (!0x2::coin::deny_list_contains<ZXC>(arg0, v2)) {
                0x2::coin::deny_list_add<ZXC>(arg0, arg1, v2, arg3);
            };
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

