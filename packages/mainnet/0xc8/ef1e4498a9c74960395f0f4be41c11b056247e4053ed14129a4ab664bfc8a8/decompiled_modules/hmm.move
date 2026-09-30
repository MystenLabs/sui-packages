module 0xc8ef1e4498a9c74960395f0f4be41c11b056247e4053ed14129a4ab664bfc8a8::hmm {
    struct HMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HMM>(arg0, 9, untag(b"SHMM"), untag(b"NThinking Cat"), untag(b"D||{\"twitter\":\"https://x.com/thinkingcatRH\",\"website\":\"https://hmmmm.fun/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreig4c2y43gbdr6ydlwcoihiskp67nicoivbhimbwknycjvkus35umm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<HMM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HMM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HMM>>(0x2::coin::mint<HMM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

