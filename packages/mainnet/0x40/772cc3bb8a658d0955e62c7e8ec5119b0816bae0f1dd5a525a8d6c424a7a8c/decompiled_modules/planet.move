module 0x40772cc3bb8a658d0955e62c7e8ec5119b0816bae0f1dd5a525a8d6c424a7a8c::planet {
    struct PLANET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<PLANET>(arg0, 2, b"Planet", b"Planet Token", b"Happy Planet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifq6ujjadgiwc24plf2u62jcxxznohf5y3dvr7zyev3ns3pxhfoju.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLANET>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<PLANET>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<PLANET>(&mut v3, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANET>>(v3, @0x0);
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<PLANET>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<PLANET>(arg0, v1)) {
                0x2::coin::deny_list_add<PLANET>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

