module 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::protocol_fee {
    struct ChangeFeeCap has store, key {
        id: 0x2::object::UID,
        last_used_epoch: u64,
    }

    struct ProtocolFeeConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        dev_wallet: address,
        total_protocol_fee_percent_base_18: u64,
        treasury_fee_percent_base_18: u64,
        dev_wallet_fee_percent_base_18: u64,
        referee_discount: u64,
    }

    fun assert_interacting_with_most_up_to_date_package(arg0: &ProtocolFeeConfig) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::version::assert_interacting_with_most_up_to_date_package(arg0.version);
    }

    public fun change_fee_percentages(arg0: &mut ChangeFeeCap, arg1: &mut ProtocolFeeConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>, arg5: &mut 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg1);
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(arg0.last_used_epoch < v0, 2);
        arg0.last_used_epoch = v0;
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.total_protocol_fee_percent_base_18 = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.treasury_fee_percent_base_18 = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.dev_wallet_fee_percent_base_18 = 0x1::option::extract<u64>(arg4);
        };
        assert!(arg1.treasury_fee_percent_base_18 + arg1.dev_wallet_fee_percent_base_18 == 1000000000000000000, 3);
        if (0x1::option::is_some<u64>(arg5)) {
            arg1.referee_discount = 0x1::option::extract<u64>(arg5);
        };
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : (ProtocolFeeConfig, ChangeFeeCap) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        let v0 = ProtocolFeeConfig{
            id                                 : 0x2::object::new(arg1),
            version                            : 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::version::current_version(),
            dev_wallet                         : @0x834824362bf9abb713743ca460c5ebde62c823abe725c71728a268af068,
            total_protocol_fee_percent_base_18 : 500000000000000000,
            treasury_fee_percent_base_18       : 500000000000000000,
            dev_wallet_fee_percent_base_18     : 0,
            referee_discount                   : 0,
        };
        let v1 = ChangeFeeCap{
            id              : 0x2::object::new(arg1),
            last_used_epoch : 0x2::tx_context::epoch(arg1),
        };
        (v0, v1)
    }

    public fun dev_wallet_fee(arg0: &ProtocolFeeConfig) : u64 {
        arg0.dev_wallet_fee_percent_base_18
    }

    public fun distribute_protocol_fees<T0>(arg0: &ProtocolFeeConfig, arg1: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::treasury::Treasury, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg0);
        if (arg0.total_protocol_fee_percent_base_18 == 0) {
            return
        };
        let v0 = take_percent_base_18(0x2::coin::value<T0>(arg2), arg0.total_protocol_fee_percent_base_18);
        if (v0 > 0) {
            0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::treasury::deposit<T0>(arg1, 0x2::coin::split<T0>(arg2, v0, arg3));
        };
        let v1 = take_percent_base_18(0x2::coin::value<T0>(arg2), arg0.dev_wallet_fee_percent_base_18);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v1, arg3), arg0.dev_wallet);
        };
    }

    public fun referee_discount(arg0: &ProtocolFeeConfig) : u64 {
        arg0.referee_discount
    }

    public(friend) fun take_percent_base_18(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun total_protocol_fee(arg0: &ProtocolFeeConfig) : u64 {
        arg0.total_protocol_fee_percent_base_18
    }

    public fun treasury_fee(arg0: &ProtocolFeeConfig) : u64 {
        arg0.treasury_fee_percent_base_18
    }

    public fun update_dev_wallet_address(arg0: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::AdminCap, arg1: &mut ProtocolFeeConfig, arg2: address) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.dev_wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

