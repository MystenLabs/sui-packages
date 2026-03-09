module 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::update {
    public fun update_coin<T0>(arg0: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg1: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::curve::BondingCurve<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_update_enabled(arg0);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_version(arg0);
        assert!(0x2::tx_context::sender(arg5) == 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::curve::creator<T0>(arg1), 0);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_coin_update(0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::curve::get_id<T0>(arg1), 0x2::tx_context::sender(arg5), arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

