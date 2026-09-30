module 0x4c35371280f34a268f905507bd88de93d87e265d12f04de08a926e459dec5507::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HIPPO>(arg0, 9, untag(b"SHIPPO"), untag(b"Nsudeng"), untag(b"D||{\"twitter\":\"https://x.com/hippo_cto\",\"website\":\"https://www.hippocto.meme/\",\"telegram\":\"https://t.me/HIPPO_SUI\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiehjl4qvlha46trzkwyznabkbugtptxiedmmnclfd4vcdqvgbvb6y"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<HIPPO>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<HIPPO>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPPO>>(0x2::coin::mint<HIPPO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

