module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house {
    struct WithdrawalRequest has store {
        for: 0x2::object::ID,
        amount: u64,
    }

    struct KusdTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    struct ClearingHouse<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        kusd_balance: 0x2::balance::Balance<T1>,
        iou_supply: 0x2::balance::Supply<T0>,
        treasury: 0x2::balance::Balance<T2>,
        pnl_pool_size: u64,
        withdrawal_queue: 0x2::linked_table::LinkedTable<u128, WithdrawalRequest>,
    }

    struct DebtCreatedEvent<phantom T0> has copy, drop, store {
        ch_id: 0x2::object::ID,
        amount: u64,
    }

    struct DebtRepayedEvent<phantom T0> has copy, drop, store {
        ch_id: 0x2::object::ID,
        amount: u64,
    }

    struct KusdTreasurySuplied<phantom T0> has copy, drop, store {
        ch_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::balance::Supply<T0>, arg1: 0xdee9::clob_v2::PoolOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ClearingHouse<T0, T1, T2>{
            id               : 0x2::object::new(arg2),
            kusd_balance     : 0x2::balance::zero<T1>(),
            iou_supply       : arg0,
            treasury         : 0x2::balance::zero<T2>(),
            pnl_pool_size    : 0,
            withdrawal_queue : 0x2::linked_table::new<u128, WithdrawalRequest>(arg2),
        };
        0x2::dynamic_field::add<vector<u8>, 0xdee9::clob_v2::PoolOwnerCap>(&mut v0.id, b"pool_owner_cap", arg1);
        0x2::transfer::share_object<ClearingHouse<T0, T1, T2>>(v0);
        *0x2::object::uid_as_inner(&v0.id)
    }

    public(friend) fun dec_pnl_pool<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: u64) {
        assert!(0x2::balance::value<T2>(&arg0.treasury) >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_amount_to_transfer());
        assert!(arg0.pnl_pool_size >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_pnl_funds());
        arg0.pnl_pool_size = arg0.pnl_pool_size - arg1;
    }

    public(friend) fun deposit_collateral<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) : 0x2::balance::Balance<T1> {
        0x2::balance::join<T2>(&mut arg0.treasury, arg1);
        0x2::balance::split<T1>(&mut arg0.kusd_balance, 0x2::balance::value<T2>(&arg1))
    }

    public fun get_n_requests_addresses<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>, arg1: u64) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        let v2 = 0x2::linked_table::front<u128, WithdrawalRequest>(&arg0.withdrawal_queue);
        while (v1 < arg1) {
            if (0x1::option::is_some<u128>(v2)) {
                let v3 = 0x1::option::destroy_some<u128>(*v2);
                0x1::vector::push_back<address>(&mut v0, 0x2::object::id_to_address(&0x2::linked_table::borrow<u128, WithdrawalRequest>(&arg0.withdrawal_queue, v3).for));
                v2 = 0x2::linked_table::next<u128, WithdrawalRequest>(&arg0.withdrawal_queue, v3);
                v1 = v1 + 1;
            } else {
                break
            };
        };
        v0
    }

    public fun get_n_requests_amount<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x2::linked_table::front<u128, WithdrawalRequest>(&arg0.withdrawal_queue);
        let v2 = 0;
        while (v0 < arg1) {
            if (0x1::option::is_some<u128>(v1)) {
                let v3 = 0x1::option::destroy_some<u128>(*v1);
                v2 = v2 + 0x2::linked_table::borrow<u128, WithdrawalRequest>(&arg0.withdrawal_queue, v3).amount;
                v1 = 0x2::linked_table::next<u128, WithdrawalRequest>(&arg0.withdrawal_queue, v3);
                v0 = v0 + 1;
            } else {
                break
            };
        };
        v2
    }

    public(friend) fun inc_pnl_pool<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: u64) {
        assert!(0x2::balance::value<T2>(&arg0.treasury) >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::invalid_amount_to_transfer());
        arg0.pnl_pool_size = arg0.pnl_pool_size + arg1;
    }

    public(friend) fun init_treasury<T0>(arg0: 0x2::balance::Supply<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KusdTreasury<T0>{
            id     : 0x2::object::new(arg1),
            supply : arg0,
        };
        0x2::transfer::share_object<KusdTreasury<T0>>(v0);
    }

    public fun iou_supply_value<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.iou_supply)
    }

    public fun pnl_pool_size<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>) : u64 {
        arg0.pnl_pool_size
    }

    public(friend) fun pool_owner_cap<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>) : &0xdee9::clob_v2::PoolOwnerCap {
        0x2::dynamic_field::borrow<vector<u8>, 0xdee9::clob_v2::PoolOwnerCap>(&arg0.id, b"pool_owner_cap")
    }

    public(friend) fun pop_withdrawal_request<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>) : WithdrawalRequest {
        assert!(0x2::linked_table::length<u128, WithdrawalRequest>(&arg0.withdrawal_queue) > 0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::withdraw_queue_empty());
        let (_, v1) = 0x2::linked_table::pop_front<u128, WithdrawalRequest>(&mut arg0.withdrawal_queue);
        v1
    }

    public(friend) fun push_withdrawal_request<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x2::linked_table::back<u128, WithdrawalRequest>(&arg0.withdrawal_queue);
        if (0x1::option::is_some<u128>(v0)) {
            let v1 = WithdrawalRequest{
                for    : arg1,
                amount : arg2,
            };
            0x2::linked_table::push_back<u128, WithdrawalRequest>(&mut arg0.withdrawal_queue, 0x1::option::destroy_some<u128>(*v0) + 1, v1);
        } else {
            let v2 = WithdrawalRequest{
                for    : arg1,
                amount : arg2,
            };
            0x2::linked_table::push_back<u128, WithdrawalRequest>(&mut arg0.withdrawal_queue, 1, v2);
        };
    }

    public(friend) fun repay_debt_iou<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = DebtRepayedEvent<T0>{
            ch_id  : *0x2::object::uid_as_inner(&arg0.id),
            amount : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<DebtRepayedEvent<T0>>(v0);
        0x2::balance::decrease_supply<T0>(&mut arg0.iou_supply, arg1);
    }

    public(friend) fun repay_debt_kusd<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = DebtRepayedEvent<T1>{
            ch_id  : *0x2::object::uid_as_inner(&arg0.id),
            amount : 0x2::balance::value<T1>(&arg1),
        };
        0x2::event::emit<DebtRepayedEvent<T1>>(v0);
        0x2::balance::join<T1>(&mut arg0.kusd_balance, arg1);
    }

    public(friend) fun take_debt_iou<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = DebtCreatedEvent<T0>{
            ch_id  : *0x2::object::uid_as_inner(&arg0.id),
            amount : arg1,
        };
        0x2::event::emit<DebtCreatedEvent<T0>>(v0);
        0x2::balance::increase_supply<T0>(&mut arg0.iou_supply, arg1)
    }

    public(friend) fun take_debt_kusd<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T1>(&arg0.kusd_balance) >= arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_kusd_treasury());
        let v0 = DebtCreatedEvent<T1>{
            ch_id  : *0x2::object::uid_as_inner(&arg0.id),
            amount : arg1,
        };
        0x2::event::emit<DebtCreatedEvent<T1>>(v0);
        0x2::balance::split<T1>(&mut arg0.kusd_balance, arg1)
    }

    public(friend) fun topup_kusd_balance<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: &mut KusdTreasury<T1>, arg2: u64) {
        0x2::balance::join<T1>(&mut arg0.kusd_balance, 0x2::balance::increase_supply<T1>(&mut arg1.supply, arg2));
        let v0 = KusdTreasurySuplied<T1>{
            ch_id  : *0x2::object::uid_as_inner(&arg0.id),
            amount : arg2,
        };
        0x2::event::emit<KusdTreasurySuplied<T1>>(v0);
    }

    public(friend) fun unwrap_withdraw_request(arg0: WithdrawalRequest) : (0x2::object::ID, u64) {
        let WithdrawalRequest {
            for    : v0,
            amount : v1,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun withdraw_collateral<T0, T1, T2>(arg0: &mut ClearingHouse<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert!(0x2::balance::value<T2>(&arg0.treasury) >= v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::insufficient_usdc_treasury());
        0x2::balance::join<T1>(&mut arg0.kusd_balance, arg1);
        0x2::balance::split<T2>(&mut arg0.treasury, v0)
    }

    public fun withdrawal_queue_size<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>) : u64 {
        0x2::linked_table::length<u128, WithdrawalRequest>(&arg0.withdrawal_queue)
    }

    public fun wr_exist<T0, T1, T2>(arg0: &ClearingHouse<T0, T1, T2>) : bool {
        !0x2::linked_table::is_empty<u128, WithdrawalRequest>(&arg0.withdrawal_queue)
    }

    public fun wr_info(arg0: &WithdrawalRequest) : (0x2::object::ID, u64) {
        (arg0.for, arg0.amount)
    }

    // decompiled from Move bytecode v6
}

