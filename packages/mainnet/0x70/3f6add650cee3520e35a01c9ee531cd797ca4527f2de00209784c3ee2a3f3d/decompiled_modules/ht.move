module 0x703f6add650cee3520e35a01c9ee531cd797ca4527f2de00209784c3ee2a3f3d::ht {
    struct HT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HT>(arg0, 2, b"HT", b"HT Token", b"HT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifq6ujjadgiwc24plf2u62jcxxznohf5y3dvr7zyev3ns3pxhfoju.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HT>>(v1, @0x212dd93cfbbcc7cd4cb274e95268db5fb7115bb62b1453b6ab40676b5ae9abf3);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HT>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HT>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<HT>(arg0, v1)) {
                0x2::coin::deny_list_add<HT>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

