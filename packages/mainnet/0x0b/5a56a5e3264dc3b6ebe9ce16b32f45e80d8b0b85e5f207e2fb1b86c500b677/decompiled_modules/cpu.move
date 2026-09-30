module 0xb5a56a5e3264dc3b6ebe9ce16b32f45e80d8b0b85e5f207e2fb1b86c500b677::cpu {
    struct CPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CPU>(arg0, 9, untag(b"SCPU"), untag(b"NCat Processing Unit"), untag(b"D||{\"twitter\":\"https://x.com/CPUonHOOD\",\"website\":\"https://bankr.bot/terminal/trade?out=0x8eaa17be69ae9616cede4671e6d837bb89491e18&chain=robinhood\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreibdjxgnznm452hjlfuqxuhw6st6f4xmrhe7zfubat6fpahkxpjqfq"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CPU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<CPU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CPU>>(0x2::coin::mint<CPU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

