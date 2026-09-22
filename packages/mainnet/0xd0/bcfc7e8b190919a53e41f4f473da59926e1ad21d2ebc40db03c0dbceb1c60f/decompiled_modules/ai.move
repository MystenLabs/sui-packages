module 0xd0bcfc7e8b190919a53e41f4f473da59926e1ad21d2ebc40db03c0dbceb1c60f::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AI>(arg0, 9, untag(b"SAI"), untag(b"NArtificial Inu"), untag(b"D"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafybeiaoza73i6rvvqwavtb5h64p3msp2srnhm2flnahefyxuqicyxr3su"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AI>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AI>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AI>>(0x2::coin::mint<AI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

