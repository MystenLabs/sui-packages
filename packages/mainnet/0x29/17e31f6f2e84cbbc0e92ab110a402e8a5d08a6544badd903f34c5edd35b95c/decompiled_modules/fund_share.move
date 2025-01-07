module 0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::fund_share {
    struct FundShare has store, key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
        trader: 0x2::object::ID,
        fund_type: 0x1::string::String,
        invest_amount: u64,
        end_time: u64,
    }

    struct MintRequest<phantom T0> {
        fund_id: 0x2::object::ID,
        trader: 0x2::object::ID,
        fund_type: 0x1::string::String,
        invest_amount: u64,
        end_time: u64,
    }

    struct BurnRequest<phantom T0> {
        fund_id: 0x2::object::ID,
        end_time: u64,
    }

    struct FUND_SHARE has drop {
        dummy_field: bool,
    }

    fun assert_if_amount_not_enough(arg0: &FundShare, arg1: u64) {
        assert!(arg0.invest_amount >= arg1, 2);
    }

    fun assert_if_fund_end_time_not_matched(arg0: &FundShare, arg1: u64) {
        assert!(arg0.end_time == arg1, 1);
    }

    fun assert_if_fund_id_not_matched(arg0: &FundShare, arg1: 0x2::object::ID) {
        assert!(arg0.fund_id == arg1, 0);
    }

    fun assert_if_share_not_same_category(arg0: &FundShare, arg1: &FundShare) {
        assert!(arg0.fund_id == arg1.fund_id, 3);
        assert!(arg0.trader == arg1.trader, 4);
        assert!(arg0.fund_type == arg1.fund_type, 5);
        assert!(arg0.end_time == arg1.end_time, 6);
    }

    public fun burn<T0>(arg0: &0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::GlobalConfig, arg1: BurnRequest<T0>, arg2: FundShare) {
        0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::assert_if_version_not_matched(arg0, 1);
        let BurnRequest {
            fund_id  : v0,
            end_time : v1,
        } = arg1;
        assert_if_fund_id_not_matched(&arg2, v0);
        assert_if_fund_end_time_not_matched(&arg2, v1);
        let FundShare {
            id            : v2,
            fund_id       : _,
            trader        : _,
            fund_type     : _,
            invest_amount : _,
            end_time      : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    public(friend) fun create_burn_request<T0>(arg0: &0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::GlobalConfig, arg1: 0x2::object::ID, arg2: u64) : BurnRequest<T0> {
        0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::assert_if_version_not_matched(arg0, 1);
        BurnRequest<T0>{
            fund_id  : arg1,
            end_time : arg2,
        }
    }

    public(friend) fun create_mint_request<T0>(arg0: &0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::GlobalConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u64) : MintRequest<T0> {
        0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::assert_if_version_not_matched(arg0, 1);
        MintRequest<T0>{
            fund_id       : arg1,
            trader        : arg2,
            fund_type     : arg3,
            invest_amount : arg4,
            end_time      : arg5,
        }
    }

    public fun invest_amount(arg0: &FundShare) : u64 {
        arg0.invest_amount
    }

    public fun join(arg0: &mut FundShare, arg1: FundShare) {
        assert_if_share_not_same_category(arg0, &arg1);
        let FundShare {
            id            : v0,
            fund_id       : _,
            trader        : _,
            fund_type     : _,
            invest_amount : v4,
            end_time      : _,
        } = arg1;
        arg0.invest_amount = arg0.invest_amount + v4;
        0x2::object::delete(v0);
    }

    public fun mint<T0>(arg0: &mut 0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::GlobalConfig, arg1: MintRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : FundShare {
        0x2917e31f6f2e84cbbc0e92ab110a402e8a5d08a6544badd903f34c5edd35b95c::config::assert_if_version_not_matched(arg0, 1);
        let MintRequest {
            fund_id       : v0,
            trader        : v1,
            fund_type     : v2,
            invest_amount : v3,
            end_time      : v4,
        } = arg1;
        FundShare{
            id            : 0x2::object::new(arg2),
            fund_id       : v0,
            trader        : v1,
            fund_type     : v2,
            invest_amount : v3,
            end_time      : v4,
        }
    }

    public fun split(arg0: &mut FundShare, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FundShare {
        assert_if_amount_not_enough(arg0, arg1);
        arg0.invest_amount = arg0.invest_amount - arg1;
        FundShare{
            id            : 0x2::object::new(arg2),
            fund_id       : arg0.fund_id,
            trader        : arg0.trader,
            fund_type     : arg0.fund_type,
            invest_amount : arg0.invest_amount,
            end_time      : arg0.end_time,
        }
    }

    // decompiled from Move bytecode v6
}

