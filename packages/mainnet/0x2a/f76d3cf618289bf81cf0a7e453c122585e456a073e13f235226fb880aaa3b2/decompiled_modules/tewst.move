module 0x2af76d3cf618289bf81cf0a7e453c122585e456a073e13f235226fb880aaa3b2::tewst {
    struct TEWST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEWST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEWST>(arg0, 6, 0x1::string::utf8(untag(b"STEWST")), 0x1::string::utf8(untag(b"Ntesttt")), 0x1::string::utf8(untag(b"Dtest")), 0x1::string::utf8(untag(b"Ihttps://aggregator.walrus-mainnet.walrus.space/v1/blobs/3OVyU0VLbsD6_obs0b-pnBtVjclBP0VTDR0jiOtjBBA")), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TEWST>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEWST>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

