module 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::flash_loan {
    struct FlashLoanGlobalConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        protocol_fee_percent_base_18: u64,
        staker_interest_percent_base_18: u64,
        total_staked: u64,
    }

    struct Receipt<phantom T0> {
        user: address,
        amount: u64,
        typeName: vector<u8>,
        protocol_fee_percent_base_18: u64,
        staker_interest_percent_base_18: u64,
    }

    public fun change_fee_percentages(arg0: &0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::admin::AdminCap, arg1: &mut FlashLoanGlobalConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.protocol_fee_percent_base_18 = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.staker_interest_percent_base_18 = 0x1::option::extract<u64>(arg4);
        };
    }

    fun check_version(arg0: &FlashLoanGlobalConfig) {
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::version::check_version(arg0.version);
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : FlashLoanGlobalConfig {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        FlashLoanGlobalConfig{
            id                              : 0x2::object::new(arg1),
            version                         : 0,
            protocol_fee_percent_base_18    : 500000000000000,
            staker_interest_percent_base_18 : 0,
            total_staked                    : 0,
        }
    }

    public fun loan<T0>(arg0: &FlashLoanGlobalConfig, arg1: &mut 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Receipt<T0>, 0x2::coin::Coin<T0>) {
        check_version(arg0);
        let v0 = Receipt<T0>{
            user                            : 0x2::tx_context::sender(arg3),
            amount                          : arg2,
            typeName                        : 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::utils::type_to_bytes<T0>(),
            protocol_fee_percent_base_18    : arg0.protocol_fee_percent_base_18,
            staker_interest_percent_base_18 : arg0.staker_interest_percent_base_18,
        };
        (v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::borrow_from_treasury<T0>(arg1), arg2), arg3))
    }

    public fun repay<T0>(arg0: &mut 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::Treasury, arg1: Receipt<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg1.amount + 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::protocol_fee::take_percent_base_18(arg1.amount, arg1.protocol_fee_percent_base_18);
        assert!(0x2::coin::value<T0>(&arg2) >= v0, 0);
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::deposit<T0>(arg0, 0x2::coin::split<T0>(&mut arg2, v0, arg3));
        let Receipt {
            user                            : _,
            amount                          : v2,
            typeName                        : _,
            protocol_fee_percent_base_18    : _,
            staker_interest_percent_base_18 : _,
        } = arg1;
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::events::emit_flashloan_event(0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::utils::type_to_bytes<T0>(), v2, arg3);
        arg2
    }

    // decompiled from Move bytecode v6
}

