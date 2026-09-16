module 0xafe84f0fc45cb78e650d5022888235aae32c0215081ebcb0e1703e228e1ec14e::aiturtle {
    struct AITURTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITURTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AITURTLE>(arg0, 9, untag(b"SAITURTLE"), untag(b"NARTIFICIAL TURTLE"), untag(x"44f09f90a220244149545552544c45202d204152544946494349414c20545552544c45202d20697320206275696c742077697468206f6e65206d697373696f6e3a207265776172642074686520636f6d6d756e6974792074686174206b65657073206974206d6f76696e672e205768696c6520747261646974696f6e616c206d656d65636f696e732074616b652066726f6d20746865697220686f6c646572732c204149545552544c452069732064657369676e656420746f2067697665206261636b2e20f09f92b0203225206f662074726164696e67206665657320676f6573206469726563746c7920746f20244149545552544c4520686f6c646572730ae282bf2052657761726473207061696420696e207265616c204254432e"), untag(b"Ihttps://silver-perfect-wren-754.mypinata.cloud/ipfs/bafkreia376udinuu2jb7wdpuqav27sa7jzoywfudikp62fswvzd53bw2pa"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<AITURTLE>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<AITURTLE>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AITURTLE>>(0x2::coin::mint<AITURTLE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : 0x1::string::String {
        0x1::vector::remove<u8>(&mut arg0, 0);
        0x1::string::utf8(arg0)
    }

    // decompiled from Move bytecode v7
}

