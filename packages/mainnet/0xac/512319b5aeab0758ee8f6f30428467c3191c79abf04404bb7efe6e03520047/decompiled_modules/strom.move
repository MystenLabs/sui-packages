module 0xac512319b5aeab0758ee8f6f30428467c3191c79abf04404bb7efe6e03520047::strom {
    struct STROM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STROM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STROM>(arg0, 9, untag(b"SSTROM"), untag(b"NMaelstrom"), untag(x"444c61756e6368206120636f696e20616761696e737420616e7920636f696e206f6e205375692e200a0a4e6f20626f6e64696e672063757276652e204e6f206d6967726174696f6e2e204c6971756964697479206c6f636b656420666f72657665722e0a0a5069636b2074686520706169722e20456e74657220746865204d61656c7374726f6d2e"), untag(b"Ihttps://gateway.pinata.cloud/ipfs/QmRtyV7m8HzSuSBMePVJ6Tupyi9JnASd7s29yBjYi8ETuj"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<STROM>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<STROM>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STROM>>(0x2::coin::mint<STROM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

