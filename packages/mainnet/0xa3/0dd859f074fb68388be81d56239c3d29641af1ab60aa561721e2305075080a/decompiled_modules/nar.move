module 0xa30dd859f074fb68388be81d56239c3d29641af1ab60aa561721e2305075080a::nar {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<NAR>(arg0, 2, b"NAR", b"NAR Token", b"NAR NAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifqbvbdj6h6wa2xpazr256h5zftsrypcrxmqd2sfuyjpfpyuvn3sm.ipfs.w3s.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAR>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<NAR>>(v1, @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NAR>(&mut v3, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate_regulated_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<NAR>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&mut arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<NAR>(arg0, v1)) {
                0x2::coin::deny_list_add<NAR>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

