module 0x2a482ca42567c7db8b35470108e39244bc9c3b3275ba4df71e9322f60a1bc3a::mubarak {
    struct MUBARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUBARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MUBARAK>(arg0, 9, untag(b"SMUBARAK"), untag(b"NMubarak"), untag(b"D||{\"twitter\":\"https://x.com/mubarak_cto\",\"website\":\"https://www.mubarak-cto.com/\",\"telegram\":\"https://t.me/mubarak_cto\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiekd2bc3wkhcub3aawab4wo6abh7rxwb75r3g32jpdn2atez5rwjq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MUBARAK>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MUBARAK>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MUBARAK>>(0x2::coin::mint<MUBARAK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

