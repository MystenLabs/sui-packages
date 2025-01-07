module 0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::fund_share {
    struct FundShare has store, key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
        trader: 0x2::object::ID,
        fund_type: 0x1::string::String,
        invest_amount: u64,
        end_time: u64,
    }

    struct Invested has copy, drop {
        share_id: 0x2::object::ID,
        fund_id: 0x2::object::ID,
        invest_amount: u64,
        investor: address,
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
        assert!(arg0.invest_amount >= arg1, 1);
    }

    fun assert_if_fund_id_not_matched(arg0: &FundShare, arg1: 0x2::object::ID) {
        assert!(arg0.fund_id == arg1, 0);
    }

    fun assert_if_share_not_same_category(arg0: &FundShare, arg1: &FundShare) {
        assert!(arg0.fund_id == arg1.fund_id, 2);
        assert!(arg0.trader == arg1.trader, 3);
        assert!(arg0.fund_type == arg1.fund_type, 4);
        assert!(arg0.end_time == arg1.end_time, 5);
    }

    public(friend) fun burn<T0>(arg0: &0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::GlobalConfig, arg1: BurnRequest<T0>, arg2: FundShare) {
        0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::assert_if_version_not_matched(arg0, 1);
        let BurnRequest {
            fund_id  : v0,
            end_time : _,
        } = arg1;
        assert_if_fund_id_not_matched(&arg2, v0);
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

    public(friend) fun create_burn_request<T0>(arg0: &0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::GlobalConfig, arg1: 0x2::object::ID, arg2: u64) : BurnRequest<T0> {
        0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::assert_if_version_not_matched(arg0, 1);
        BurnRequest<T0>{
            fund_id  : arg1,
            end_time : arg2,
        }
    }

    public(friend) fun create_mint_request<T0>(arg0: &0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::GlobalConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: u64) : MintRequest<T0> {
        0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::assert_if_version_not_matched(arg0, 1);
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

    public fun mint<T0>(arg0: &mut 0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::GlobalConfig, arg1: MintRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : FundShare {
        0x518ec4136121ba76594c39896ee91eaf8123949f2529fd6d6d63f9017dd20257::config::assert_if_version_not_matched(arg0, 1);
        let MintRequest {
            fund_id       : v0,
            trader        : v1,
            fund_type     : v2,
            invest_amount : v3,
            end_time      : v4,
        } = arg1;
        let v5 = FundShare{
            id            : 0x2::object::new(arg2),
            fund_id       : v0,
            trader        : v1,
            fund_type     : v2,
            invest_amount : v3,
            end_time      : v4,
        };
        let v6 = Invested{
            share_id      : *0x2::object::uid_as_inner(&v5.id),
            fund_id       : v5.fund_id,
            invest_amount : v5.invest_amount,
            investor      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Invested>(v6);
        v5
    }

    public fun split(arg0: &mut FundShare, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FundShare {
        assert_if_amount_not_enough(arg0, arg1);
        arg0.invest_amount = arg0.invest_amount - arg1;
        FundShare{
            id            : 0x2::object::new(arg2),
            fund_id       : arg0.fund_id,
            trader        : arg0.trader,
            fund_type     : arg0.fund_type,
            invest_amount : arg1,
            end_time      : arg0.end_time,
        }
    }

    // decompiled from Move bytecode v6
}

