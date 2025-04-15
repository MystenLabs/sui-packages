module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::protocol_fee {
    struct ProtocolFeeConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        dev_wallet: address,
        total_protocol_fee_percent_base_18: u64,
        treasury_fee_percent_base_18: u64,
        dev_wallet_fee_percent_base_18: u64,
        referee_discount: u64,
    }

    public fun change_fee_percentages(arg0: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::admin::AdminCap, arg1: &mut ProtocolFeeConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>, arg5: &mut 0x1::option::Option<u64>, arg6: &mut 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.total_protocol_fee_percent_base_18 = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.treasury_fee_percent_base_18 = 0x1::option::extract<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(arg5)) {
            arg1.dev_wallet_fee_percent_base_18 = 0x1::option::extract<u64>(arg5);
        };
        assert!(arg1.treasury_fee_percent_base_18 + arg1.dev_wallet_fee_percent_base_18 == 1000000000000000000, 3);
        if (0x1::option::is_some<u64>(arg6)) {
            arg1.referee_discount = 0x1::option::extract<u64>(arg6);
        };
    }

    fun check_version(arg0: &ProtocolFeeConfig) {
        0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version::check_version(arg0.version);
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : ProtocolFeeConfig {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        ProtocolFeeConfig{
            id                                 : 0x2::object::new(arg1),
            version                            : 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version::current_version(),
            dev_wallet                         : @0x60c049b5aea93660573019b2ed5d657245212a998e030981589726d11fe,
            total_protocol_fee_percent_base_18 : 500000000000000,
            treasury_fee_percent_base_18       : 1000000000000000000,
            dev_wallet_fee_percent_base_18     : 0,
            referee_discount                   : 0,
        }
    }

    public fun dev_wallet_fee(arg0: &ProtocolFeeConfig) : u64 {
        arg0.dev_wallet_fee_percent_base_18
    }

    public fun distribute_protocol_fees<T0>(arg0: &ProtocolFeeConfig, arg1: &mut 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::Treasury, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        if (arg0.total_protocol_fee_percent_base_18 == 0) {
            return
        };
        let v0 = take_percent_base_18(0x2::coin::value<T0>(arg2), arg0.total_protocol_fee_percent_base_18);
        let v1 = take_percent_base_18(v0, arg0.treasury_fee_percent_base_18);
        if (v1 > 0) {
            0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::treasury::deposit<T0>(arg1, 0x2::coin::split<T0>(arg2, v1, arg3));
        };
        let v2 = take_percent_base_18(v0, arg0.dev_wallet_fee_percent_base_18);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v2, arg3), arg0.dev_wallet);
        };
    }

    public fun referee_discount(arg0: &ProtocolFeeConfig) : u64 {
        arg0.referee_discount
    }

    public fun take_percent_base_18(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun total_protocol_fee(arg0: &ProtocolFeeConfig) : u64 {
        arg0.total_protocol_fee_percent_base_18
    }

    public fun treasury_fee(arg0: &ProtocolFeeConfig) : u64 {
        arg0.treasury_fee_percent_base_18
    }

    public fun update_dev_wallet_address(arg0: &0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::admin::AdminCap, arg1: &mut ProtocolFeeConfig, arg2: address) {
        check_version(arg1);
        arg1.dev_wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

