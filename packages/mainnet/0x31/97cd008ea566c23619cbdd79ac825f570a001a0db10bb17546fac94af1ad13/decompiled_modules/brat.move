module 0x3197cd008ea566c23619cbdd79ac825f570a001a0db10bb17546fac94af1ad13::brat {
    struct BRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRAT>(arg0, 9, untag(b"SBRAT"), untag(b"NBRAT"), untag(b"D||{\"twitter\":\"https://x.com/bratonsui\",\"website\":\"https://bratonsui.com/\",\"telegram\":\"https://t.me/bratonsui\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreieqm7r7jmxwh5xwplx6qbha2z3cojtvkfk6dyp4yjc3jzphnd6kea"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BRAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<BRAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BRAT>>(0x2::coin::mint<BRAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

