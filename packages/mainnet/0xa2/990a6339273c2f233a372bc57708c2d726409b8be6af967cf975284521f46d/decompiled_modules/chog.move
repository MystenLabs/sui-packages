module 0xa2990a6339273c2f233a372bc57708c2d726409b8be6af967cf975284521f46d::chog {
    struct CHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHOG>(arg0, 9, untag(b"SCHOG"), untag(b"NChog"), untag(b"D||{\"twitter\":\"https://x.com/ChogNFT\",\"website\":\"https://www.chog.xyz/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihmj2t3vi3tosxpnjbxhsf7kiiwqaeijbekj7dq6lxbqrmqefdhge"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CHOG>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CHOG>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHOG>>(0x2::coin::mint<CHOG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

