module 0x77594719bd022c0e07593d8a40c20149490f8ea19e875f338bda2f8e4175af9b::orbit {
    struct ORBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ORBIT>(arg0, 9, untag(b"SORBIT"), untag(b"NORBITLINK"), untag(x"444f524249544c494e4b20e2809420436f6e6e656374696e672074686520776f726c64206265796f6e6420626f72646572732e204120636f6d6d756e6974792d64726976656e206d656d6520636f696e20696e73706972656420627920736174656c6c697465732c2073706163652c20616e6420746865206c696d69746c657373206675747572652e20f09f9a80f09f9bb0efb88f"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreieimloz4zcapqwaom2ppwlv4jwkizr5pmibmsoqkzw4hhztqsmwja"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ORBIT>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ORBIT>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ORBIT>>(0x2::coin::mint<ORBIT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

