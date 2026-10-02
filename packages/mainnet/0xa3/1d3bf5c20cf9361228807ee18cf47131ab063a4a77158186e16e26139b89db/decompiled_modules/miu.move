module 0xa31d3bf5c20cf9361228807ee18cf47131ab063a4a77158186e16e26139b89db::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MIU>(arg0, 9, untag(b"SMIU"), untag(b"NMIU"), untag(b"D||{\"twitter\":\"https://x.com/miucoin_sui\",\"website\":\"https://miucoin.org\",\"telegram\":\"https://t.me/miucoin_sui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreicixsvs6rkg6nvz66tearxgeyij7qq4jzzw7icpoj75zgsukbcj4q"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<MIU>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<MIU>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MIU>>(0x2::coin::mint<MIU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

