module 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::is_emergency(arg0), 302);
        assert!(0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::get_mut_pool<T0, T1>(arg0, 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::event::withdrew_event(0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::global_id<T0, T1>(v0), 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::generate_lp_name<T0, T1>(), v3, v4);
    }

    // decompiled from Move bytecode v6
}

