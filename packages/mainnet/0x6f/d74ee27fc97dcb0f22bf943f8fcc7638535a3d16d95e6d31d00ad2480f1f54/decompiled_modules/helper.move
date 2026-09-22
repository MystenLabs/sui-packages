module 0x6fd74ee27fc97dcb0f22bf943f8fcc7638535a3d16d95e6d31d00ad2480f1f54::helper {
    public fun create_pair_key(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        assert!(0x1::ascii::length(&arg0) > 0, 5000);
        assert!(0x1::ascii::length(&arg1) > 0, 5000);
        assert!(arg0 != arg1, 5001);
        0x1::ascii::append(&mut arg0, 0x1::ascii::string(b"-"));
        0x1::ascii::append(&mut arg0, arg1);
        arg0
    }

    public(friend) fun transfer_balance_or_destroy_zero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            false
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
            true
        }
    }

    public(friend) fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) : bool {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            false
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
            true
        }
    }

    // decompiled from Move bytecode v7
}

