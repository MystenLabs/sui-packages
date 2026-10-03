module 0x81f0c34c40086cb1043cd26a2b63773294809f5094db336c5d2993e92619c403::wth {
    struct WTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<WTH>(arg0, 9, untag(b"SWTH"), untag(b"Nwhat the hook?"), untag(b"D||{\"twitter\":\"https://x.com/whatthehookv4\",\"website\":\"https://www.whatthehook.io/\",\"telegram\":\"https://t.me/+o9WcbT5JyIFkZTM0\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreiew336aldc45nh44wz4rscb73yoozt3g6sfvi4y3htfcdhgxh3xrm"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<WTH>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<WTH>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WTH>>(0x2::coin::mint<WTH>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

