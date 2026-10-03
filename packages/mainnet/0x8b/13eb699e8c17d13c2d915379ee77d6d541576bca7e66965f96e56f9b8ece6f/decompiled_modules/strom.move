module 0x8b13eb699e8c17d13c2d915379ee77d6d541576bca7e66965f96e56f9b8ece6f::strom {
    struct STROM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROM>(arg0, 9, untag(b"SSTROM"), untag(b"NMaelstrom"), untag(b"D||{\"twitter\":\"https://x.com/maelstromdotxyz\",\"website\":\"https://maelstromfun.xyz/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreigmhrtowhh6ikl65rtrgozlfcn7yr4pw43eh524qk2nuqfn3smfbq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STROM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STROM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STROM>>(0x2::coin::mint<STROM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

