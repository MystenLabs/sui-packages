module 0x595f29ace70536590e324b7aa3ec67b793aaa5b8906169031287d4766e4e2934::allinu {
    struct ALLINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ALLINU>(arg0, 9, untag(b"SALLINU"), untag(b"NALLINU"), untag(b"D||{\"website\":\"https://www.stonkfun.xyz/token/4MMQY9bwkxxTtsK3W227Q5ABT6yFY8Pmn9Ze7wmAXKY8\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiboa7ynmcswhyfd7d74pkemku5ceu3ixqksmnjhrx5637z2uyx4dm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ALLINU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ALLINU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALLINU>>(0x2::coin::mint<ALLINU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

