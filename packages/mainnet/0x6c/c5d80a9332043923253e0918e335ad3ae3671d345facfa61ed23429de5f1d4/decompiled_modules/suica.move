module 0x6cc5d80a9332043923253e0918e335ad3ae3671d345facfa61ed23429de5f1d4::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUICA>(arg0, 9, untag(b"SSUICA"), untag(b"NSUICA"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreidjf6zlvzdhahzc5aim4q5u7y64ytpdnhp3fs7op3mroeaxzwszie"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUICA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUICA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICA>>(0x2::coin::mint<SUICA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

