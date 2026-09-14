module 0x69ffd9c65fc5814d30d93e24d0706bb124c1840516a6bf3e59cdbff06ece65bd::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ZEUS>(arg0, 9, untag(b"SZEUS"), untag(b"NZEUS"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeihea6jfwjnciq2xtsmjwzcgmx7zynrupbvntny2kfegtplihd2pfq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ZEUS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ZEUS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZEUS>>(0x2::coin::mint<ZEUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

