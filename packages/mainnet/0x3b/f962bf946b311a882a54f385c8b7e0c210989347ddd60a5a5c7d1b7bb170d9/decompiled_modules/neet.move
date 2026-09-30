module 0x3bf962bf946b311a882a54f385c8b7e0c210989347ddd60a5a5c7d1b7bb170d9::neet {
    struct NEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<NEET>(arg0, 9, untag(b"SNEET"), untag(b"NNot in Employment, Education, or Training"), untag(b"D||{\"twitter\":\"https://x.com/neet_sol\",\"website\":\"https://neetcoin.xyz/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicgc6jv7gkbqpf6cygaio3p4jytj7afotnzqapwmesifthoa3gkfq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<NEET>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<NEET>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEET>>(0x2::coin::mint<NEET>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

