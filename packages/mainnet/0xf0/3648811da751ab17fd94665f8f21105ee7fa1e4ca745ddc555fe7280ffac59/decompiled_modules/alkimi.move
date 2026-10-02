module 0xf03648811da751ab17fd94665f8f21105ee7fa1e4ca745ddc555fe7280ffac59::alkimi {
    struct ALKIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALKIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ALKIMI>(arg0, 9, untag(b"SALKIMI"), untag(b"NAlkimi"), untag(b"D"), untag(b"Ihttps://imortal.buzz/i/bafkreibhpniknboa6qojbbelpxulqe2e4kanrwihwnpcwfhywsyn3q3zhy"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ALKIMI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ALKIMI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALKIMI>>(0x2::coin::mint<ALKIMI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

