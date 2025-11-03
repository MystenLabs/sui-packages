module 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::seal {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config::Config, arg2: &0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::Studio, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::studio::check_policy(arg0, arg2, arg1, 0x2::tx_context::sender(arg4), arg3), 2);
    }

    // decompiled from Move bytecode v6
}

