module 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::events {
    struct NewSavingPoolEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
    }

    struct UpdateSavingRateEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
        saving_rate_bps: u64,
    }

    struct UpdateDepositCapEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
        deposit_cap_amount: 0x1::option::Option<u64>,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
        account_address: address,
        deposited_usdb_amount: u64,
        minted_lp_amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
        account_address: address,
        burned_lp_amount: u64,
        withdrawal_usdb_amount: u64,
    }

    struct SupplyEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct InterestEmittedEvent<phantom T0> has copy, drop {
        saving_pool_id: 0x2::object::ID,
        interest_amount: u64,
    }

    public(friend) fun emit_deposit_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = DepositEvent<T0>{
            saving_pool_id        : arg0,
            account_address       : arg1,
            deposited_usdb_amount : arg2,
            minted_lp_amount      : arg3,
        };
        0x2::event::emit<DepositEvent<T0>>(v0);
    }

    public(friend) fun emit_interest_emitted_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = InterestEmittedEvent<T0>{
            saving_pool_id  : arg0,
            interest_amount : arg1,
        };
        0x2::event::emit<InterestEmittedEvent<T0>>(v0);
    }

    public(friend) fun emit_new_saving_pool_event<T0>(arg0: 0x2::object::ID) {
        let v0 = NewSavingPoolEvent<T0>{saving_pool_id: arg0};
        0x2::event::emit<NewSavingPoolEvent<T0>>(v0);
    }

    public(friend) fun emit_supply_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SupplyEvent<T0>{
            saving_pool_id : arg0,
            amount         : arg1,
        };
        0x2::event::emit<SupplyEvent<T0>>(v0);
    }

    public(friend) fun emit_update_deposit_cap_event<T0>(arg0: 0x2::object::ID, arg1: 0x1::option::Option<u64>) {
        let v0 = UpdateDepositCapEvent<T0>{
            saving_pool_id     : arg0,
            deposit_cap_amount : arg1,
        };
        0x2::event::emit<UpdateDepositCapEvent<T0>>(v0);
    }

    public(friend) fun emit_update_saving_rate_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UpdateSavingRateEvent<T0>{
            saving_pool_id  : arg0,
            saving_rate_bps : arg1,
        };
        0x2::event::emit<UpdateSavingRateEvent<T0>>(v0);
    }

    public(friend) fun emit_withdraw_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = WithdrawEvent<T0>{
            saving_pool_id         : arg0,
            account_address        : arg1,
            burned_lp_amount       : arg2,
            withdrawal_usdb_amount : arg3,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

