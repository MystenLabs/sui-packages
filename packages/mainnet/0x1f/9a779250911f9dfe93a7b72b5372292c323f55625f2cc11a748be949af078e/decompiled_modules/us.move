module 0x1f9a779250911f9dfe93a7b72b5372292c323f55625f2cc11a748be949af078e::us {
    struct US has drop {
        dummy_field: bool,
    }

    fun init(arg0: US, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<US>(arg0, 9, untag(b"SUS"), untag(b"NTalus Token"), untag(b"D||{\"twitter\":\"https://x.com/talus_labs\",\"website\":\"https://talus.network\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiga3qptkvod7onpeouclukjkyvtvfjtm4jkkdjz6k5onmiwycgv54"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<US>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<US>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<US>>(0x2::coin::mint<US>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

