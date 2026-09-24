module 0x2fdab17619c336202600fb9a510d68e1f11fd3bf0c32a504811584482722b793::robocat {
    struct ROBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ROBOCAT>(arg0, 9, untag(b"SROBOCAT"), untag(b"NROBOCAT"), untag(x"4441207363726170706564204149206361742066726f6d20612062696c6c696f6e61697265e280997320736563726574206c61622c207265626f726e206f6e205355492e205061697265642077697468202454534c412e20312e323825206f6620657665727920747261646520676f657320737472616967687420746f20686f6c646572732e200a0a54686520466972737420535549204d656d65636f696e20506169726564205257412e2057656c636f6d6520746f20746865205265766f6c7574696f6e206f6620537569204d656d65636f696e732e20524f424f434154206973204275696c7420666f72205468652054616b656f7665722e0a0a24524f424f4341542078202454534c41"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeifqwhrtnxxhb4xl7rez7f5gmyhovca5tydmqemz4encifpltog7py"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ROBOCAT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ROBOCAT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROBOCAT>>(0x2::coin::mint<ROBOCAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

