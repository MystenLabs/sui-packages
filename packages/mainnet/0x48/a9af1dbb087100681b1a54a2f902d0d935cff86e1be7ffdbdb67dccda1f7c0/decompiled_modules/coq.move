module 0x48a9af1dbb087100681b1a54a2f902d0d935cff86e1be7ffdbdb67dccda1f7c0::coq {
    struct COQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: COQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COQ>(arg0, 9, untag(b"SCOQ"), untag(b"NCoq Inu"), untag(b"D||{\"twitter\":\"https://x.com/coqinuavax\",\"website\":\"https://www.coqinu.com/\"}"), untag(b"Ihttps://imortal.buzz/i/bafkreihsmgiogyn2bp2kb7rty7drkkuonwwrlbddn5bcrr6jonlxmx3ese"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<COQ>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<COQ>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<COQ>>(0x2::coin::mint<COQ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

