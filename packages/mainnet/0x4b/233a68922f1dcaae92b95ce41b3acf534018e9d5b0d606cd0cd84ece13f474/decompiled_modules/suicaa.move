module 0x4b233a68922f1dcaae92b95ce41b3acf534018e9d5b0d606cd0cd84ece13f474::suicaa {
    struct SUICAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUICAA>(arg0, 9, untag(b"SSUICAA"), untag(b"NSUICAA"), untag(b"DSUICAA on Sui"), untag(b"Ihttps://gateway.pinata.cloud/ipfs/QmepVAVxZusWaKA7Ppc2KkCwyxDKmhcKt2iVJG3LCgfGvd"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<SUICAA>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUICAA>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICAA>>(0x2::coin::mint<SUICAA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

