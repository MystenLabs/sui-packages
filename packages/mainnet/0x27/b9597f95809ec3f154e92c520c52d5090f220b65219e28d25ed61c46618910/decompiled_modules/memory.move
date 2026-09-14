module 0x27b9597f95809ec3f154e92c520c52d5090f220b65219e28d25ed61c46618910::memory {
    struct MEMORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MEMORY>(arg0, 9, untag(b"SMEMORY"), untag(b"NMEMORY"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreiatzfc5jr4z3zzkfyiatixbzdgzdt6prfugyl6saslb3sjfsfxzwm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MEMORY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MEMORY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEMORY>>(0x2::coin::mint<MEMORY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

