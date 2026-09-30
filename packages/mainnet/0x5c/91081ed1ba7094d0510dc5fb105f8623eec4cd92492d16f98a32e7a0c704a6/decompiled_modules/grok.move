module 0x5c91081ed1ba7094d0510dc5fb105f8623eec4cd92492d16f98a32e7a0c704a6::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GROK>(arg0, 9, untag(b"SGROK"), untag(b"NGrokification"), untag(b"D||{\"website\":\"https://grokification.com/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreifmtt3fcvfetpbuq3td4vyomk6gbeushl73ntmr5lzomyphil6b4m"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<GROK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GROK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GROK>>(0x2::coin::mint<GROK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

