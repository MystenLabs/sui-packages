module 0xf47f0a4debb2d386cf0c28b95351f351fff015ebcdf4c4aa3407b16cd55b1f38::sdo {
    struct SDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SDO>(arg0, 2, b"SDO", b"SDO Token", b"SDO SDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiepkmnmiwdxsvsldfefghfwkr2fzyrtaybfdx5nbmsynbdmppqd6q.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SDO>>(v1, @0x4e18d4e91071236c9d7eb4757311edfbbe2d92953a473792f374a46b6d48c467);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SDO>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDO>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun sga(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SDO>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<SDO>(arg0, v1)) {
                0x2::coin::deny_list_add<SDO>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

