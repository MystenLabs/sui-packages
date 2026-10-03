module 0xfa40c0552c4aafa4978699aa7dfd8774645542473f701afb7198772d5f39159c::truth {
    struct TRUTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TRUTH>(arg0, 9, untag(b"STRUTH"), untag(b"NSwarm Network"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreifwmd67juukiivodfjyge5gihrnmvobuyacxdhwauikii3alsxsfe"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<TRUTH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TRUTH>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUTH>>(0x2::coin::mint<TRUTH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

