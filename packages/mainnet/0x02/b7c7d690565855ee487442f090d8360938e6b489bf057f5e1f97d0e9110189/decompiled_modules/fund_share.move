module 0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::fund_share {
    struct FundShare has store, key {
        id: 0x2::object::UID,
        fund_id: 0x2::object::ID,
        is_init: bool,
        trader: address,
        fund_type: 0x1::string::String,
        invest_amount: u64,
        base_receiver: address,
        reward_receiver: address,
    }

    struct Invested has copy, drop {
        share_id: 0x2::object::ID,
        fund_id: 0x2::object::ID,
        invest_amount: u64,
        investor: address,
    }

    struct Splited has copy, drop {
        new_share_id: 0x2::object::ID,
        invest_amount: u64,
    }

    struct Merged has copy, drop {
        base_share_id: 0x2::object::ID,
        base_invest_amount: u64,
        burn_share_id: 0x2::object::ID,
        burn_invest_amount: u64,
    }

    struct MintRequest<phantom T0> {
        fund_id: 0x2::object::ID,
        is_init: bool,
        trader: address,
        fund_type: 0x1::string::String,
        invest_amount: u64,
        base_receiver: address,
        reward_receiver: address,
    }

    struct BurnRequest<phantom T0> {
        fund_id: 0x2::object::ID,
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
    }

    public fun base_receiver(arg0: &FundShare) : address {
        arg0.base_receiver
    }

    public(friend) fun burn<T0>(arg0: &0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::GlobalConfig, arg1: BurnRequest<T0>, arg2: FundShare) {
        0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::assert_if_version_not_matched(arg0, 1);
        let BurnRequest { fund_id: v0 } = arg1;
        assert_if_fund_id_not_matched(&arg2, v0);
        let FundShare {
            id              : v1,
            fund_id         : _,
            is_init         : _,
            trader          : _,
            fund_type       : _,
            invest_amount   : _,
            base_receiver   : _,
            reward_receiver : _,
        } = arg2;
        0x2::object::delete(v1);
    }

    public(friend) fun create_burn_request<T0>(arg0: &0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::GlobalConfig, arg1: 0x2::object::ID) : BurnRequest<T0> {
        0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::assert_if_version_not_matched(arg0, 1);
        BurnRequest<T0>{fund_id: arg1}
    }

    public(friend) fun create_mint_request<T0>(arg0: &0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::GlobalConfig, arg1: 0x2::object::ID, arg2: bool, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: address) : MintRequest<T0> {
        0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::assert_if_version_not_matched(arg0, 1);
        MintRequest<T0>{
            fund_id         : arg1,
            is_init         : arg2,
            trader          : arg3,
            fund_type       : arg4,
            invest_amount   : arg5,
            base_receiver   : arg6,
            reward_receiver : arg7,
        }
    }

    public fun fund_id(arg0: &FundShare) : 0x2::object::ID {
        arg0.fund_id
    }

    public fun id(arg0: &FundShare) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun invest_amount(arg0: &FundShare) : u64 {
        arg0.invest_amount
    }

    public fun is_init(arg0: &FundShare) : bool {
        arg0.is_init
    }

    public fun join(arg0: &mut FundShare, arg1: FundShare) {
        assert_if_share_not_same_category(arg0, &arg1);
        let FundShare {
            id              : v0,
            fund_id         : _,
            is_init         : _,
            trader          : _,
            fund_type       : _,
            invest_amount   : v5,
            base_receiver   : _,
            reward_receiver : _,
        } = arg1;
        let v8 = v0;
        arg0.invest_amount = arg0.invest_amount + v5;
        let v9 = Merged{
            base_share_id      : *0x2::object::uid_as_inner(&arg0.id),
            base_invest_amount : arg0.invest_amount,
            burn_share_id      : *0x2::object::uid_as_inner(&v8),
            burn_invest_amount : v5,
        };
        0x2::event::emit<Merged>(v9);
        0x2::object::delete(v8);
    }

    public fun mint<T0>(arg0: &mut 0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::GlobalConfig, arg1: MintRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : FundShare {
        0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::config::assert_if_version_not_matched(arg0, 1);
        let MintRequest {
            fund_id         : v0,
            is_init         : v1,
            trader          : v2,
            fund_type       : v3,
            invest_amount   : v4,
            base_receiver   : v5,
            reward_receiver : v6,
        } = arg1;
        let v7 = FundShare{
            id              : 0x2::object::new(arg2),
            fund_id         : v0,
            is_init         : v1,
            trader          : v2,
            fund_type       : v3,
            invest_amount   : v4,
            base_receiver   : v5,
            reward_receiver : v6,
        };
        let v8 = Invested{
            share_id      : *0x2::object::uid_as_inner(&v7.id),
            fund_id       : v7.fund_id,
            invest_amount : v7.invest_amount,
            investor      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Invested>(v8);
        v7
    }

    public fun reward_receiver(arg0: &FundShare) : address {
        arg0.reward_receiver
    }

    public fun split(arg0: &mut FundShare, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FundShare {
        assert_if_amount_not_enough(arg0, arg1);
        arg0.invest_amount = arg0.invest_amount - arg1;
        let v0 = FundShare{
            id              : 0x2::object::new(arg2),
            fund_id         : arg0.fund_id,
            is_init         : arg0.is_init,
            trader          : arg0.trader,
            fund_type       : arg0.fund_type,
            invest_amount   : arg1,
            base_receiver   : arg0.base_receiver,
            reward_receiver : arg0.reward_receiver,
        };
        let v1 = Splited{
            new_share_id  : *0x2::object::uid_as_inner(&v0.id),
            invest_amount : arg1,
        };
        0x2::event::emit<Splited>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

