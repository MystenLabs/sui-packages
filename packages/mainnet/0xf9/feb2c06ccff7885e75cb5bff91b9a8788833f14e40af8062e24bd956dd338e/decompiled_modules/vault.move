module 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::vault {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct VaultAccess has store {
        id: 0x2::object::UID,
    }

    struct StrategyWithdrawInfo<phantom T0> has store {
        to_withdraw: u64,
        withdrawn_balance: 0x2::balance::Balance<T0>,
        has_withdrawn: bool,
    }

    struct WithdrawTicket<phantom T0, phantom T1> {
        to_withdraw_from_free_balance: u64,
        strategy_infos: 0x2::vec_map::VecMap<0x2::object::ID, StrategyWithdrawInfo<T0>>,
        lp_to_burn: 0x2::balance::Balance<T1>,
    }

    struct RebalanceInfo has copy, drop, store {
        to_repay: u64,
        can_borrow: u64,
    }

    struct RebalanceAmounts has copy, drop {
        inner: 0x2::vec_map::VecMap<0x2::object::ID, RebalanceInfo>,
    }

    struct StrategyState has store {
        borrowed: u64,
        target_alloc_weight_bps: u64,
        max_borrow: 0x1::option::Option<u64>,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        free_balance: 0x2::balance::Balance<T0>,
        time_locked_profit: 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::TimeLockedBalance<T0>,
        lp_treasury: 0x2::coin::TreasuryCap<T1>,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, StrategyState>,
        performance_fee_balance: 0x2::balance::Balance<T1>,
        strategy_withdraw_priority_order: vector<0x2::object::ID>,
        withdraw_ticket_issued: bool,
        tvl_cap: 0x1::option::Option<u64>,
        profit_unlock_duration_sec: u64,
        performance_fee_bps: u64,
    }

    struct EventTimeLockedProfitState has copy, drop, store {
        max_withdrawable: u64,
        remaining_unlock: u64,
        extraneous_locked_amount: u64,
        unlock_per_second: u64,
    }

    struct EventStrategyState has copy, drop, store {
        borrowed: u64,
        target_alloc_weight_bps: u64,
        max_borrow: 0x1::option::Option<u64>,
    }

    struct EventVaultState has copy, drop, store {
        free_balance: u64,
        lp_supply: u64,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, EventStrategyState>,
        performance_fee_balance: u64,
        strategy_withdraw_priority_order: vector<0x2::object::ID>,
        withdraw_ticket_issued: bool,
        tvl_cap: 0x1::option::Option<u64>,
        profit_unlock_duration_sec: u64,
        performance_fee_bps: u64,
    }

    struct EventAddStrategyInit has copy, drop, store {
        vault: EventVaultState,
    }

    struct EventAddStrategyResult has copy, drop, store {
        vault: EventVaultState,
    }

    struct EventDepositInit has copy, drop, store {
        vault: EventVaultState,
        time_locked_profit: EventTimeLockedProfitState,
        balance: u64,
    }

    struct EventDepositResult has copy, drop, store {
        vault: EventVaultState,
        time_locked_profit: EventTimeLockedProfitState,
        lp_amount: u64,
    }

    struct EventWithdrawInit has copy, drop, store {
        vault: EventVaultState,
        time_locked_profit: EventTimeLockedProfitState,
        lp_amount: u64,
    }

    struct EventStrategyWithdrawInfo has copy, drop, store {
        to_withdraw: u64,
        withdrawn_balance: u64,
        has_withdrawn: bool,
    }

    struct EventWithdrawTicketState has copy, drop, store {
        to_withdraw_from_free_balance: u64,
        strategy_infos: 0x2::vec_map::VecMap<0x2::object::ID, EventStrategyWithdrawInfo>,
        lp_to_burn: u64,
    }

    struct EventWithdrawResult has copy, drop, store {
        ticket: EventWithdrawTicketState,
    }

    struct EventRedeemWithdrawTicketInit has copy, drop, store {
        vault: EventVaultState,
        ticket: EventWithdrawTicketState,
    }

    struct EventRedeemWithdrawTicketResult has copy, drop, store {
        vault: EventVaultState,
        out: u64,
    }

    struct EventCalcRebalanceAmountsInit has copy, drop, store {
        vault: EventVaultState,
        time_locked_profit: EventTimeLockedProfitState,
    }

    struct EventCalcRebalanceAmountsResult has copy, drop, store {
        infos: 0x2::vec_map::VecMap<0x2::object::ID, RebalanceInfo>,
    }

    struct EventStrategyRepayInit has copy, drop, store {
        vault: EventVaultState,
        strategy_id: 0x2::object::ID,
        balance: u64,
    }

    struct EventStrategyRepayResult has copy, drop, store {
        vault: EventVaultState,
        strategy_id: 0x2::object::ID,
    }

    struct EventStrategyBorrowInit has copy, drop, store {
        vault: EventVaultState,
        strategy_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventStrategyBorrowResult has copy, drop, store {
        vault: EventVaultState,
        strategy_id: 0x2::object::ID,
    }

    struct EventStrategyHandOverProfitInit has copy, drop, store {
        vault: EventVaultState,
        time_locked_profit: EventTimeLockedProfitState,
        strategy_id: 0x2::object::ID,
        profit: u64,
    }

    struct EventStrategyHandOverProfitResult has copy, drop, store {
        vault: EventVaultState,
        time_locked_profit: EventTimeLockedProfitState,
        strategy_id: 0x2::object::ID,
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T1> {
        let v0 = Vault<T0, T1>{
            id                               : 0x2::object::new(arg1),
            free_balance                     : 0x2::balance::zero<T0>(),
            time_locked_profit               : 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::create<T0>(0x2::balance::zero<T0>(), 0, 0),
            lp_treasury                      : arg0,
            strategies                       : 0x2::vec_map::empty<0x2::object::ID, StrategyState>(),
            performance_fee_balance          : 0x2::balance::zero<T1>(),
            strategy_withdraw_priority_order : 0x1::vector::empty<0x2::object::ID>(),
            withdraw_ticket_issued           : false,
            tvl_cap                          : 0x1::option::none<u64>(),
            profit_unlock_duration_sec       : 6000,
            performance_fee_bps              : 0,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        AdminCap<T1>{id: 0x2::object::new(arg1)}
    }

    public(friend) fun add_strategy<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : VaultAccess {
        let v0 = EventAddStrategyInit{vault: event_get_vault_state<T0, T1>(arg1)};
        0x2::event::emit<EventAddStrategyInit>(v0);
        let v1 = VaultAccess{id: 0x2::object::new(arg2)};
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        let v3 = StrategyState{
            borrowed                : 0,
            target_alloc_weight_bps : 0,
            max_borrow              : 0x1::option::none<u64>(),
        };
        0x2::vec_map::insert<0x2::object::ID, StrategyState>(&mut arg1.strategies, v2, v3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.strategy_withdraw_priority_order, v2);
        let v4 = EventAddStrategyResult{vault: event_get_vault_state<T0, T1>(arg1)};
        0x2::event::emit<EventAddStrategyResult>(v4);
        v1
    }

    public(friend) fun calc_rebalance_amounts<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : RebalanceAmounts {
        assert!(arg0.withdraw_ticket_issued == false, 2);
        let v0 = EventCalcRebalanceAmountsInit{
            vault              : event_get_vault_state<T0, T1>(arg0),
            time_locked_profit : event_get_time_locked_profit_state<T0, T1>(arg0, arg1),
        };
        0x2::event::emit<EventCalcRebalanceAmountsInit>(v0);
        let v1 = 0x2::vec_map::empty<0x2::object::ID, RebalanceInfo>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0 + 0x2::balance::value<T0>(&arg0.free_balance) + 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::max_withdrawable<T0>(&arg0.time_locked_profit, arg1);
        let v5 = 0;
        while (v5 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg0.strategies)) {
            let (v6, v7) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v5);
            let v8 = RebalanceInfo{
                to_repay   : 0,
                can_borrow : 0,
            };
            0x2::vec_map::insert<0x2::object::ID, RebalanceInfo>(&mut v1, *v6, v8);
            v4 = v4 + v7.borrowed;
            if (0x1::option::is_some<u64>(&v7.max_borrow)) {
                0x1::vector::push_back<u64>(&mut v2, v5);
            } else {
                0x1::vector::push_back<u64>(&mut v3, v5);
            };
            v5 = v5 + 1;
        };
        let v9 = v4;
        let v10 = 10000;
        let v11 = true;
        while (v11) {
            let v12 = 0;
            let v13 = 0x1::vector::empty<u64>();
            v11 = false;
            while (v12 < 0x1::vector::length<u64>(&v2)) {
                let v14 = *0x1::vector::borrow<u64>(&v2, v12);
                let (_, v16) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v14);
                let (_, v18) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, RebalanceInfo>(&mut v1, v14);
                let v19 = *0x1::option::borrow<u64>(&v16.max_borrow);
                let v20 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(v9, v16.target_alloc_weight_bps, v10);
                if (v20 <= v16.borrowed || v19 <= v16.borrowed) {
                    if (v20 < v19) {
                        0x1::vector::push_back<u64>(&mut v13, v14);
                    } else {
                        v18.to_repay = v16.borrowed - v19;
                        v9 = v9 - v19;
                        v10 = v10 - v16.target_alloc_weight_bps;
                        v11 = true;
                    };
                    v12 = v12 + 1;
                    continue
                };
                if (v20 >= v19) {
                    v18.can_borrow = v19 - v16.borrowed;
                    v9 = v9 - v19;
                    v10 = v10 - v16.target_alloc_weight_bps;
                    v11 = true;
                    v12 = v12 + 1;
                    continue
                };
                0x1::vector::push_back<u64>(&mut v13, v14);
                v12 = v12 + 1;
            };
            v2 = v13;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<u64>(&v2)) {
            let v22 = *0x1::vector::borrow<u64>(&v2, v21);
            let (_, v24) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v22);
            let (_, v26) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, RebalanceInfo>(&mut v1, v22);
            let v27 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(v9, v24.target_alloc_weight_bps, v10);
            if (v27 >= v24.borrowed) {
                v26.can_borrow = v27 - v24.borrowed;
            } else {
                v26.to_repay = v24.borrowed - v27;
            };
            v21 = v21 + 1;
        };
        let v28 = 0;
        while (v28 < 0x1::vector::length<u64>(&v3)) {
            let v29 = *0x1::vector::borrow<u64>(&v3, v28);
            let (_, v31) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v29);
            let (_, v33) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, RebalanceInfo>(&mut v1, v29);
            let v34 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(v9, v31.target_alloc_weight_bps, v10);
            if (v34 >= v31.borrowed) {
                v33.can_borrow = v34 - v31.borrowed;
            } else {
                v33.to_repay = v31.borrowed - v34;
            };
            v28 = v28 + 1;
        };
        let v35 = EventCalcRebalanceAmountsResult{infos: v1};
        0x2::event::emit<EventCalcRebalanceAmountsResult>(v35);
        RebalanceAmounts{inner: v1}
    }

    fun create_withdraw_ticket<T0, T1>(arg0: &Vault<T0, T1>) : WithdrawTicket<T0, T1> {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, StrategyWithdrawInfo<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v2 = StrategyWithdrawInfo<T0>{
                to_withdraw       : 0,
                withdrawn_balance : 0x2::balance::zero<T0>(),
                has_withdrawn     : false,
            };
            0x2::vec_map::insert<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v1), v2);
            v1 = v1 + 1;
        };
        WithdrawTicket<T0, T1>{
            to_withdraw_from_free_balance : 0,
            strategy_infos                : v0,
            lp_to_burn                    : 0x2::balance::zero<T1>(),
        }
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert!(arg0.withdraw_ticket_issued == false, 2);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        let v0 = EventDepositInit{
            vault              : event_get_vault_state<T0, T1>(arg0),
            time_locked_profit : event_get_time_locked_profit_state<T0, T1>(arg0, arg2),
            balance            : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<EventDepositInit>(v0);
        if (0x2::coin::total_supply<T1>(&arg0.lp_treasury) == 0) {
            0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.time_locked_profit, 0, arg2);
            0x2::balance::join<T0>(&mut arg0.free_balance, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.time_locked_profit));
            0x2::balance::join<T0>(&mut arg0.free_balance, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::withdraw_all<T0>(&mut arg0.time_locked_profit, arg2));
            0x2::balance::join<T1>(&mut arg0.performance_fee_balance, 0x2::coin::mint_balance<T1>(&mut arg0.lp_treasury, total_available_balance<T0, T1>(arg0, arg2)));
        };
        let v1 = total_available_balance<T0, T1>(arg0, arg2);
        if (0x1::option::is_some<u64>(&arg0.tvl_cap)) {
            assert!(v1 + 0x2::balance::value<T0>(&arg1) <= *0x1::option::borrow<u64>(&arg0.tvl_cap), 1);
        };
        let v2 = if (v1 == 0) {
            0x2::balance::value<T0>(&arg1)
        } else {
            0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0x2::coin::total_supply<T1>(&arg0.lp_treasury), 0x2::balance::value<T0>(&arg1), v1)
        };
        0x2::balance::join<T0>(&mut arg0.free_balance, arg1);
        let v3 = EventDepositResult{
            vault              : event_get_vault_state<T0, T1>(arg0),
            time_locked_profit : event_get_time_locked_profit_state<T0, T1>(arg0, arg2),
            lp_amount          : v2,
        };
        0x2::event::emit<EventDepositResult>(v3);
        0x2::coin::mint_balance<T1>(&mut arg0.lp_treasury, v2)
    }

    fun event_get_time_locked_profit_state<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : EventTimeLockedProfitState {
        EventTimeLockedProfitState{
            max_withdrawable         : 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::max_withdrawable<T0>(&arg0.time_locked_profit, arg1),
            remaining_unlock         : 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::remaining_unlock<T0>(&arg0.time_locked_profit, arg1),
            extraneous_locked_amount : 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::extraneous_locked_amount<T0>(&arg0.time_locked_profit),
            unlock_per_second        : 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::unlock_per_second<T0>(&arg0.time_locked_profit),
        }
    }

    fun event_get_vault_state<T0, T1>(arg0: &Vault<T0, T1>) : EventVaultState {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, EventStrategyState>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg0.strategies)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v1);
            let v4 = EventStrategyState{
                borrowed                : v3.borrowed,
                target_alloc_weight_bps : v3.target_alloc_weight_bps,
                max_borrow              : v3.max_borrow,
            };
            0x2::vec_map::insert<0x2::object::ID, EventStrategyState>(&mut v0, *v2, v4);
            v1 = v1 + 1;
        };
        EventVaultState{
            free_balance                     : 0x2::balance::value<T0>(&arg0.free_balance),
            lp_supply                        : 0x2::coin::total_supply<T1>(&arg0.lp_treasury),
            strategies                       : v0,
            performance_fee_balance          : 0x2::balance::value<T1>(&arg0.performance_fee_balance),
            strategy_withdraw_priority_order : arg0.strategy_withdraw_priority_order,
            withdraw_ticket_issued           : arg0.withdraw_ticket_issued,
            tvl_cap                          : arg0.tvl_cap,
            profit_unlock_duration_sec       : arg0.profit_unlock_duration_sec,
            performance_fee_bps              : arg0.performance_fee_bps,
        }
    }

    fun event_get_withdraw_ticket_state<T0, T1>(arg0: &WithdrawTicket<T0, T1>) : EventWithdrawTicketState {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, EventStrategyWithdrawInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, StrategyWithdrawInfo<T0>>(&arg0.strategy_infos)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyWithdrawInfo<T0>>(&arg0.strategy_infos, v1);
            let v4 = EventStrategyWithdrawInfo{
                to_withdraw       : v3.to_withdraw,
                withdrawn_balance : 0x2::balance::value<T0>(&v3.withdrawn_balance),
                has_withdrawn     : v3.has_withdrawn,
            };
            0x2::vec_map::insert<0x2::object::ID, EventStrategyWithdrawInfo>(&mut v0, *v2, v4);
            v1 = v1 + 1;
        };
        EventWithdrawTicketState{
            to_withdraw_from_free_balance : arg0.to_withdraw_from_free_balance,
            strategy_infos                : v0,
            lp_to_burn                    : 0x2::balance::value<T1>(&arg0.lp_to_burn),
        }
    }

    public fun free_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.free_balance)
    }

    public(friend) fun rebalance_amounts_get(arg0: &RebalanceAmounts, arg1: &VaultAccess) : (u64, u64) {
        let v0 = 0x2::vec_map::get<0x2::object::ID, RebalanceInfo>(&arg0.inner, 0x2::object::uid_as_inner(&arg1.id));
        (v0.can_borrow, v0.to_repay)
    }

    public fun redeem_withdraw_ticket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: WithdrawTicket<T0, T1>) : 0x2::balance::Balance<T0> {
        let v0 = EventRedeemWithdrawTicketInit{
            vault  : event_get_vault_state<T0, T1>(arg0),
            ticket : event_get_withdraw_ticket_state<T0, T1>(&arg1),
        };
        0x2::event::emit<EventRedeemWithdrawTicketInit>(v0);
        let v1 = 0x2::balance::zero<T0>();
        let WithdrawTicket {
            to_withdraw_from_free_balance : v2,
            strategy_infos                : v3,
            lp_to_burn                    : v4,
        } = arg1;
        let v5 = v3;
        while (0x2::vec_map::size<0x2::object::ID, StrategyWithdrawInfo<T0>>(&v5) > 0) {
            let (v6, v7) = 0x2::vec_map::pop<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v5);
            let v8 = v6;
            let StrategyWithdrawInfo {
                to_withdraw       : v9,
                withdrawn_balance : v10,
                has_withdrawn     : v11,
            } = v7;
            if (v9 > 0) {
                assert!(v11, 5);
            };
            let v12 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, &v8);
            v12.borrowed = v12.borrowed - v9;
            0x2::balance::join<T0>(&mut v1, v10);
        };
        0x2::vec_map::destroy_empty<0x2::object::ID, StrategyWithdrawInfo<T0>>(v5);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.free_balance, v2));
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(&mut arg0.lp_treasury), v4);
        arg0.withdraw_ticket_issued = false;
        let v13 = EventRedeemWithdrawTicketResult{
            vault : event_get_vault_state<T0, T1>(arg0),
            out   : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<EventRedeemWithdrawTicketResult>(v13);
        v1
    }

    public(friend) fun remove_strategy<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: VaultAccess, arg3: vector<0x2::object::ID>, arg4: vector<u64>) {
        let VaultAccess { id: v0 } = arg2;
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = &v1;
        0x2::object::delete(v0);
        let (_, v4) = 0x2::vec_map::remove<0x2::object::ID, StrategyState>(&mut arg1.strategies, v2);
        let StrategyState {
            borrowed                : v5,
            target_alloc_weight_bps : _,
            max_borrow              : _,
        } = v4;
        assert!(v5 == 0, 8);
        let (v8, v9) = 0x1::vector::index_of<0x2::object::ID>(&arg1.strategy_withdraw_priority_order, v2);
        assert!(v8, 9);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.strategy_withdraw_priority_order, v9);
        set_strategy_target_alloc_weights_bps<T0, T1>(arg0, arg1, arg3, arg4);
    }

    entry fun set_performance_fee_bps<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) {
        assert!(arg2 <= 10000, 0);
        arg1.performance_fee_bps = arg2;
    }

    entry fun set_profit_unlock_duration_sec<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) {
        arg1.profit_unlock_duration_sec = arg2;
    }

    public(friend) entry fun set_strategy_max_borrow<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: 0x1::option::Option<u64>) {
        0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg1.strategies, &arg2).max_borrow = arg3;
    }

    public(friend) entry fun set_strategy_target_alloc_weights_bps<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: vector<0x2::object::ID>, arg3: vector<u64>) {
        let v0 = 0x2::vec_set::empty<0x2::object::ID>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg1.strategies)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, v3);
            v1 = v1 + v4;
            0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg1.strategies, &v3).target_alloc_weight_bps = v4;
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 7);
    }

    entry fun set_tvl_cap<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: 0x1::option::Option<u64>) {
        arg1.tvl_cap = arg2;
    }

    public(friend) fun strategy_borrow<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.withdraw_ticket_issued == false, 2);
        let v0 = EventStrategyBorrowInit{
            vault       : event_get_vault_state<T0, T1>(arg0),
            strategy_id : 0x2::object::uid_to_inner(&arg1.id),
            amount      : arg2,
        };
        0x2::event::emit<EventStrategyBorrowInit>(v0);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, 0x2::object::uid_as_inner(&arg1.id));
        v1.borrowed = v1.borrowed + arg2;
        let v2 = EventStrategyBorrowResult{
            vault       : event_get_vault_state<T0, T1>(arg0),
            strategy_id : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<EventStrategyBorrowResult>(v2);
        0x2::balance::split<T0>(&mut arg0.free_balance, arg2)
    }

    public(friend) fun strategy_hand_over_profit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg0.withdraw_ticket_issued == false, 2);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyState>(&mut arg0.strategies, 0x2::object::uid_as_inner(&arg1.id)), 6);
        let v0 = EventStrategyHandOverProfitInit{
            vault              : event_get_vault_state<T0, T1>(arg0),
            time_locked_profit : event_get_time_locked_profit_state<T0, T1>(arg0, arg3),
            strategy_id        : 0x2::object::uid_to_inner(&arg1.id),
            profit             : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<EventStrategyHandOverProfitInit>(v0);
        let v1 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0x2::balance::value<T0>(&arg2), arg0.performance_fee_bps, 10000);
        if (v1 > 0) {
            0x2::balance::join<T1>(&mut arg0.performance_fee_balance, 0x2::coin::mint_balance<T1>(&mut arg0.lp_treasury, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0x2::coin::total_supply<T1>(&arg0.lp_treasury), v1, total_available_balance<T0, T1>(arg0, arg3) - v1)));
        };
        0x2::balance::join<T0>(&mut arg0.free_balance, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::withdraw_all<T0>(&mut arg0.time_locked_profit, arg3));
        0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.time_locked_profit, 0, arg3);
        let v2 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.time_locked_profit);
        0x2::balance::join<T0>(&mut v2, arg2);
        0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::change_unlock_start_ts_sec<T0>(&mut arg0.time_locked_profit, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::timestamp_sec(arg3), arg3);
        0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.time_locked_profit, 0x2::math::divide_and_round_up(0x2::balance::value<T0>(&v2), arg0.profit_unlock_duration_sec), arg3);
        0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::top_up<T0>(&mut arg0.time_locked_profit, v2, arg3);
        let v3 = EventStrategyHandOverProfitResult{
            vault              : event_get_vault_state<T0, T1>(arg0),
            time_locked_profit : event_get_time_locked_profit_state<T0, T1>(arg0, arg3),
            strategy_id        : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<EventStrategyHandOverProfitResult>(v3);
    }

    public(friend) fun strategy_repay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg0.withdraw_ticket_issued == false, 2);
        let v0 = EventStrategyRepayInit{
            vault       : event_get_vault_state<T0, T1>(arg0),
            strategy_id : 0x2::object::uid_to_inner(&arg1.id),
            balance     : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<EventStrategyRepayInit>(v0);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, 0x2::object::uid_as_inner(&arg1.id));
        v1.borrowed = v1.borrowed - 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.free_balance, arg2);
        let v2 = EventStrategyRepayResult{
            vault       : event_get_vault_state<T0, T1>(arg0),
            strategy_id : 0x2::object::uid_to_inner(&arg1.id),
        };
        0x2::event::emit<EventStrategyRepayResult>(v2);
    }

    public(friend) fun strategy_withdraw_to_ticket<T0, T1>(arg0: &mut WithdrawTicket<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut arg0.strategy_infos, 0x2::object::uid_as_inner(&arg1.id));
        assert!(v0.has_withdrawn == false, 4);
        v0.has_withdrawn = true;
        0x2::balance::join<T0>(&mut v0.withdrawn_balance, arg2);
    }

    public fun total_available_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0 + 0x2::balance::value<T0>(&arg0.free_balance) + 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::max_withdrawable<T0>(&arg0.time_locked_profit, arg1);
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg0.strategies)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v1);
            v0 = v0 + v3.borrowed;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun vault_access_id(arg0: &VaultAccess) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : WithdrawTicket<T0, T1> {
        let v0 = EventWithdrawInit{
            vault              : event_get_vault_state<T0, T1>(arg0),
            time_locked_profit : event_get_time_locked_profit_state<T0, T1>(arg0, arg2),
            lp_amount          : 0x2::balance::value<T1>(&arg1),
        };
        0x2::event::emit<EventWithdrawInit>(v0);
        assert!(arg0.withdraw_ticket_issued == false, 2);
        assert!(0x2::balance::value<T1>(&arg1) > 0, 3);
        arg0.withdraw_ticket_issued = true;
        let v1 = create_withdraw_ticket<T0, T1>(arg0);
        0x2::balance::join<T1>(&mut v1.lp_to_burn, arg1);
        0x2::balance::join<T0>(&mut arg0.free_balance, 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::time_locked_balance::withdraw_all<T0>(&mut arg0.time_locked_profit, arg2));
        let v2 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0x2::balance::value<T1>(&v1.lp_to_burn), total_available_balance<T0, T1>(arg0, arg2), 0x2::coin::total_supply<T1>(&arg0.lp_treasury));
        v1.to_withdraw_from_free_balance = 0x2::math::min(v2, 0x2::balance::value<T0>(&arg0.free_balance));
        let v3 = v2 - v1.to_withdraw_from_free_balance;
        let v4 = v3;
        if (v3 == 0) {
            return v1
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v7 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v6);
            let v8 = 0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, v7);
            let v9 = if (0x1::option::is_some<u64>(&v8.max_borrow)) {
                let v10 = *0x1::option::borrow<u64>(&v8.max_borrow);
                if (v8.borrowed > v10) {
                    v8.borrowed - v10
                } else {
                    0
                }
            } else {
                0
            };
            let v11 = if (v9 >= v4) {
                v4
            } else {
                v9
            };
            v4 = v4 - v11;
            let v12 = v5 + v8.borrowed;
            v5 = v12 - v9;
            0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v1.strategy_infos, v7).to_withdraw = v9;
            v6 = v6 + 1;
        };
        if (v4 == 0) {
            return v1
        };
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v14 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v13);
            let v15 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v1.strategy_infos, v14);
            let v16 = 0xf9feb2c06ccff7885e75cb5bff91b9a8788833f14e40af8062e24bd956dd338e::util::muldiv(0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, v14).borrowed - v15.to_withdraw, v4, v5);
            v15.to_withdraw = v15.to_withdraw + v16;
            v4 = v4 - v16;
            v13 = v13 + 1;
        };
        if (v4 == 0) {
            return v1
        };
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v18 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v17);
            let v19 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v1.strategy_infos, v18);
            let v20 = 0x2::math::min(0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, v18).borrowed - v19.to_withdraw, v4);
            v19.to_withdraw = v19.to_withdraw + v20;
            let v21 = v4 - v20;
            v4 = v21;
            if (v21 == 0) {
                break
            };
            v17 = v17 + 1;
        };
        let v22 = EventWithdrawResult{ticket: event_get_withdraw_ticket_state<T0, T1>(&v1)};
        0x2::event::emit<EventWithdrawResult>(v22);
        v1
    }

    public fun withdraw_performance_fee<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg1.performance_fee_balance, arg2)
    }

    public(friend) fun withdraw_ticket_to_withdraw<T0, T1>(arg0: &WithdrawTicket<T0, T1>, arg1: &VaultAccess) : u64 {
        0x2::vec_map::get<0x2::object::ID, StrategyWithdrawInfo<T0>>(&arg0.strategy_infos, 0x2::object::uid_as_inner(&arg1.id)).to_withdraw
    }

    // decompiled from Move bytecode v6
}

