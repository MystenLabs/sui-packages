module 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::protocol {
    struct FeesData has store {
        streamflow_fee_percentage: u64,
        streamflow_fee: u64,
        streamflow_fee_withdrawn: u64,
        partner_fee_percentage: u64,
        partner_fee: u64,
        partner_fee_withdrawn: u64,
    }

    struct ContractMeta has store {
        cancelable_by_sender: bool,
        cancelable_by_recipient: bool,
        transferable_by_sender: bool,
        transferable_by_recipient: bool,
        can_topup: bool,
        pausable: bool,
        can_update_rate: bool,
        automatic_withdrawal: bool,
        withdrawal_frequency: u64,
        contract_name: vector<u8>,
    }

    struct Contract<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        meta: ContractMeta,
        amount: u64,
        period: u64,
        amount_per_period: u64,
        start: u64,
        end: u64,
        cliff_amount: u64,
        withdrawn: u64,
        last_withdrawn_at: u64,
        created: u64,
        canceled_at: u64,
        recipient: address,
        sender: address,
        partner: address,
        fees: FeesData,
        closed: bool,
        current_pause_start: u64,
        pause_cumulative: u64,
        last_rate_change_time: u64,
        funds_unlocked_at_last_rate_change: u64,
        version: u64,
    }

    struct ContractCreated has copy, drop {
        address: address,
    }

    struct ContractWithdrawn has copy, drop {
        address: address,
        amount: u64,
        streamflow_amount: u64,
        partner_amount: u64,
    }

    public entry fun transfer<T0>(arg0: &mut Contract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_transfer<T0>(arg0, 0x2::tx_context::sender(arg2));
        arg0.recipient = arg1;
    }

    public fun amount<T0>(arg0: &Contract<T0>) : u64 {
        arg0.amount
    }

    public fun amount_per_period<T0>(arg0: &Contract<T0>) : u64 {
        arg0.amount_per_period
    }

    fun assert_cancel<T0>(arg0: &Contract<T0>, arg1: address) {
        assert!(!arg0.closed, 5);
        assert!(arg1 == arg0.sender || arg1 == arg0.recipient, 3);
        if (!arg0.meta.cancelable_by_sender && arg1 == arg0.sender) {
            abort 3
        };
        if (!arg0.meta.cancelable_by_recipient && arg1 == arg0.recipient) {
            abort 3
        };
    }

    fun assert_pause<T0>(arg0: &Contract<T0>, arg1: address) {
        assert!(!arg0.closed, 5);
        assert!(arg0.meta.pausable && arg1 == arg0.sender, 3);
        assert!(arg0.current_pause_start == 0, 15);
    }

    fun assert_topup<T0>(arg0: &Contract<T0>) {
        assert!(!arg0.closed, 5);
        assert!(arg0.meta.can_topup, 3);
    }

    fun assert_transfer<T0>(arg0: &Contract<T0>, arg1: address) {
        assert!(!arg0.closed, 5);
        assert!(arg1 == arg0.sender || arg1 == arg0.recipient, 3);
        if (!arg0.meta.transferable_by_sender && arg1 == arg0.sender) {
            abort 3
        };
        if (!arg0.meta.transferable_by_recipient && arg1 == arg0.recipient) {
            abort 3
        };
    }

    fun assert_unpause<T0>(arg0: &Contract<T0>, arg1: address) {
        assert!(!arg0.closed, 5);
        assert!(arg1 == arg0.sender, 3);
        assert!(arg0.current_pause_start > 0, 16);
    }

    public fun automatic_withdrawal<T0>(arg0: &Contract<T0>) : bool {
        arg0.meta.automatic_withdrawal
    }

    public fun balance_value<T0>(arg0: &Contract<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun calculate_available<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: &Contract<T0>, arg4: u64) : u64 {
        if (arg3.current_pause_start != 0 && arg3.current_pause_start < arg3.start) {
            return 0
        };
        if (arg0 < arg3.start || arg1 == arg2 || arg1 == 0) {
            return 0
        };
        if (arg3.current_pause_start == 0 && arg0 >= arg3.end) {
            return arg1 - arg2
        };
        let v0 = if (arg3.current_pause_start == 0) {
            arg3.pause_cumulative
        } else {
            arg0 + arg3.pause_cumulative - arg3.current_pause_start
        };
        calculate_fee_amount(arg3.funds_unlocked_at_last_rate_change + (arg0 - 0x2::math::max(arg3.start, arg3.last_rate_change_time) - v0) / arg3.period * arg3.amount_per_period, arg4) + calculate_fee_amount(arg3.cliff_amount, arg4) - arg2
    }

    fun calculate_current_pause_length<T0>(arg0: &Contract<T0>, arg1: u64) : u64 {
        let v0 = arg1 - arg0.current_pause_start;
        if (arg0.current_pause_start <= arg0.start && arg1 >= arg0.start) {
            v0 = arg1 - arg0.start;
        };
        v0
    }

    fun calculate_end(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        0x2::math::max(arg4, arg5) + 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::ceil_div(arg0 - arg1 - arg2, arg7) * arg3 + arg6
    }

    fun calculate_fee_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 10000) {
            return arg0
        };
        arg0 * arg1 / 10000
    }

    fun calculate_last_unlock_time<T0>(arg0: u64, arg1: &Contract<T0>) : u64 {
        let v0 = arg1.pause_cumulative;
        if (arg1.current_pause_start > 0) {
            v0 = arg0 + arg1.pause_cumulative - arg1.current_pause_start;
        };
        let v1 = 0x2::math::max(arg1.start, arg1.last_rate_change_time);
        v1 + (arg0 - v1 - v0) / arg1.period * arg1.period
    }

    public fun calculate_withdrawal_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0 || arg1 == 0 || arg0 > arg1) {
            return 0
        };
        arg3 * 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::ceil_div(arg1 - arg0, arg2)
    }

    public entry fun cancel<T0>(arg0: &mut Contract<T0>, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_cancel<T0>(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::timestamp_seconds(arg2);
        assert!(v0 < arg0.end, 5);
        arg0.canceled_at = v0;
        arg0.closed = true;
        withdraw_by_amount<T0>(arg0, arg1, v0, 0x1::option::none<u64>(), arg3);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg3), arg0.sender);
        };
    }

    public fun closed<T0>(arg0: &Contract<T0>) : bool {
        arg0.closed
    }

    public entry fun create<T0>(arg0: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::fee_manager::FeeTable, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: bool, arg15: bool, arg16: bool, arg17: bool, arg18: u64, arg19: vector<u8>, arg20: address, arg21: address, arg22: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::timestamp_seconds(arg2);
        if (arg8 == 0) {
            arg8 = v0;
        };
        if (arg18 < 30 && arg18 != 0) {
            arg18 = 30;
        };
        validate_contract_params(arg5, arg6, arg7, arg18, arg8, arg9, v0);
        let v1 = calculate_end(arg5, arg9, 0, arg6, arg8, 0, 0, arg7);
        let v2 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::fee_manager::get_streamflow_fee(arg1, arg0, arg21);
        let v3 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::fee_manager::get_partner_fee(arg1, arg0, arg21);
        let v4 = calculate_fee_amount(arg5, v2);
        let v5 = calculate_fee_amount(arg5, v3);
        let v6 = arg5 + v4 + v5;
        assert!(0x2::coin::value<T0>(arg3) >= v6, 14);
        let v7 = ContractMeta{
            cancelable_by_sender      : arg10,
            cancelable_by_recipient   : arg11,
            transferable_by_sender    : arg12,
            transferable_by_recipient : arg13,
            can_topup                 : arg14,
            pausable                  : arg15,
            can_update_rate           : arg16,
            automatic_withdrawal      : arg17,
            withdrawal_frequency      : arg18,
            contract_name             : arg19,
        };
        let v8 = FeesData{
            streamflow_fee_percentage : v2,
            streamflow_fee            : v4,
            streamflow_fee_withdrawn  : 0,
            partner_fee_percentage    : v3,
            partner_fee               : v5,
            partner_fee_withdrawn     : 0,
        };
        let v9 = Contract<T0>{
            id                                 : 0x2::object::new(arg22),
            balance                            : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, v6, arg22)),
            meta                               : v7,
            amount                             : arg5,
            period                             : arg6,
            amount_per_period                  : arg7,
            start                              : arg8,
            end                                : v1,
            cliff_amount                       : arg9,
            withdrawn                          : 0,
            last_withdrawn_at                  : 0,
            created                            : v0,
            canceled_at                        : 0,
            recipient                          : arg20,
            sender                             : 0x2::tx_context::sender(arg22),
            partner                            : arg21,
            fees                               : v8,
            closed                             : false,
            current_pause_start                : 0,
            pause_cumulative                   : 0,
            last_rate_change_time              : 0,
            funds_unlocked_at_last_rate_change : 0,
            version                            : 1,
        };
        if (arg17 && arg18 > 0) {
            let v10 = calculate_withdrawal_fees(arg8, v1, arg18, 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_tx_fee(arg0));
            assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v10, 13);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v10, arg22), 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_withdrawor(arg0));
        };
        let v11 = ContractCreated{address: 0x2::object::uid_to_address(&v9.id)};
        0x2::event::emit<ContractCreated>(v11);
        0x2::transfer::share_object<Contract<T0>>(v9);
    }

    fun deposit_net<T0>(arg0: &mut Contract<T0>, arg1: u64) {
        arg0.fees.streamflow_fee = arg0.fees.streamflow_fee + calculate_fee_amount(arg1, arg0.fees.streamflow_fee_percentage);
        arg0.fees.partner_fee = arg0.fees.partner_fee + calculate_fee_amount(arg1, arg0.fees.partner_fee_percentage);
        arg0.amount = arg0.amount + arg1;
        arg0.end = calculate_end(arg0.amount, arg0.cliff_amount, arg0.funds_unlocked_at_last_rate_change, arg0.period, arg0.start, arg0.last_rate_change_time, arg0.pause_cumulative, arg0.amount_per_period);
    }

    public fun end<T0>(arg0: &Contract<T0>) : u64 {
        arg0.end
    }

    public fun partner_fee<T0>(arg0: &Contract<T0>) : u64 {
        arg0.fees.partner_fee
    }

    public entry fun pause<T0>(arg0: &mut Contract<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_pause<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::timestamp_seconds(arg1);
        assert!(v0 < arg0.end, 5);
        arg0.current_pause_start = v0;
    }

    public fun pause_cumulative<T0>(arg0: &Contract<T0>) : u64 {
        arg0.pause_cumulative
    }

    public fun start<T0>(arg0: &Contract<T0>) : u64 {
        arg0.start
    }

    public fun streamflow_fee<T0>(arg0: &Contract<T0>) : u64 {
        arg0.fees.streamflow_fee
    }

    public entry fun topup<T0>(arg0: &mut Contract<T0>, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_topup<T0>(arg0);
        assert!(arg4 > 0, 2);
        let v0 = arg0.end;
        deposit_net<T0>(arg0, arg4);
        let v1 = arg4 + calculate_fee_amount(arg4, arg0.fees.streamflow_fee_percentage) + calculate_fee_amount(arg4, arg0.fees.partner_fee_percentage);
        assert!(0x2::coin::value<T0>(arg2) >= v1, 14);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v1, arg5)));
        if (arg0.meta.automatic_withdrawal && arg0.meta.withdrawal_frequency > 0) {
            let v2 = calculate_withdrawal_fees(v0, arg0.end, arg0.meta.withdrawal_frequency, 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_tx_fee(arg1));
            if (v2 > 0) {
                assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v2, 13);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v2, arg5), 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_withdrawor(arg1));
            };
        };
    }

    public entry fun unpause<T0>(arg0: &mut Contract<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_unpause<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::timestamp_seconds(arg1);
        let v1 = calculate_current_pause_length<T0>(arg0, v0);
        if (arg0.current_pause_start >= arg0.start || v0 >= arg0.start) {
            arg0.end = arg0.end + v1;
        };
        if (v0 >= arg0.start) {
            arg0.pause_cumulative = arg0.pause_cumulative + v1;
        };
        if (arg0.current_pause_start <= arg0.start && v0 >= arg0.start) {
            arg0.start = v0;
            arg0.pause_cumulative = 0;
        };
        arg0.current_pause_start = 0;
    }

    public entry fun update<T0>(arg0: &mut Contract<T0>, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<bool>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!arg0.closed, 5);
        assert!(v0 == arg0.sender || v0 == arg0.recipient, 3);
        assert!(0x1::option::is_some<bool>(&arg4) || 0x1::option::is_some<u64>(&arg5) || 0x1::option::is_some<u64>(&arg6), 4);
        if (arg4 == 0x1::option::some<bool>(true) && !arg0.meta.automatic_withdrawal) {
            let v1 = 0x1::option::destroy_with_default<u64>(arg5, arg0.meta.withdrawal_frequency);
            let v2 = v1;
            assert!(v1 == 0 || v1 >= arg0.period, 4);
            if (v1 == 0) {
                v2 = arg0.period;
            };
            if (v2 < 30) {
                v2 = 0x2::math::max(30, arg0.period);
            };
            arg0.meta.automatic_withdrawal = true;
            arg0.meta.withdrawal_frequency = v2;
            let v3 = calculate_withdrawal_fees(arg0.start, arg0.end, v2, 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_tx_fee(arg1));
            assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v3, 13);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v3, arg7), 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_withdrawor(arg1));
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            let v4 = 0x1::option::destroy_some<u64>(arg6);
            assert!(arg0.meta.can_update_rate, 3);
            assert!(v4 > 0, 6);
            let v5 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::timestamp_seconds(arg2);
            let v6 = calculate_available<T0>(v5, arg0.amount, arg0.withdrawn, arg0, 10000) + arg0.withdrawn;
            assert!(v4 <= arg0.amount - v6, 6);
            if (v6 > 0) {
                arg0.funds_unlocked_at_last_rate_change = v6 - arg0.cliff_amount;
                arg0.last_rate_change_time = calculate_last_unlock_time<T0>(v5, arg0);
            };
            let v7 = arg0.end;
            arg0.amount_per_period = v4;
            arg0.end = calculate_end(arg0.amount, arg0.cliff_amount, arg0.funds_unlocked_at_last_rate_change, arg0.period, arg0.start, arg0.last_rate_change_time, arg0.pause_cumulative, arg0.amount_per_period);
            if (v7 < arg0.end && arg0.meta.automatic_withdrawal) {
                let v8 = calculate_withdrawal_fees(v7, arg0.end, arg0.meta.withdrawal_frequency, 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_tx_fee(arg1));
                assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v8, 13);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v8, arg7), 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_withdrawor(arg1));
            };
        };
    }

    fun validate_contract_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg2 <= arg0, 6);
        assert!(arg2 > 0, 6);
        if (arg5 > 0) {
            assert!(arg5 <= arg0, 9);
        };
        assert!(arg1 > 0, 10);
        assert!(arg3 == 0 || arg3 >= arg1, 4);
        assert!(arg6 <= arg4, 11);
        assert!(arg4 < arg6 + 2207520000, 11);
    }

    public entry fun withdraw<T0>(arg0: &mut Contract<T0>, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.closed, 5);
        let v0 = 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::utils::timestamp_seconds(arg2);
        if (!arg0.meta.automatic_withdrawal && arg0.end > v0) {
            assert!(0x2::tx_context::sender(arg4) == arg0.recipient, 3);
        };
        withdraw_by_amount<T0>(arg0, arg1, v0, 0x1::option::some<u64>(arg3), arg4);
        if (arg0.withdrawn == arg0.amount) {
            arg0.closed = true;
        };
    }

    fun withdraw_by_amount<T0>(arg0: &mut Contract<T0>, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_available<T0>(arg2, arg0.amount, arg0.withdrawn, arg0, 10000);
        let v1 = calculate_available<T0>(arg2, arg0.fees.streamflow_fee, arg0.fees.streamflow_fee_withdrawn, arg0, arg0.fees.streamflow_fee_percentage);
        let v2 = calculate_available<T0>(arg2, arg0.fees.partner_fee, arg0.fees.partner_fee_withdrawn, arg0, arg0.fees.partner_fee_percentage);
        let v3 = v0;
        if (0x1::option::is_some<u64>(&arg3) && arg3 != 0x1::option::some<u64>(18446744073709551615)) {
            let v4 = 0x1::option::destroy_some<u64>(arg3);
            v3 = v4;
            assert!(v0 >= v4, 2);
        };
        if (v3 > 0) {
            arg0.withdrawn = arg0.withdrawn + v3;
            arg0.last_withdrawn_at = arg2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v3, arg4), arg0.recipient);
        };
        if (v1 > 0) {
            arg0.fees.streamflow_fee_withdrawn = arg0.fees.streamflow_fee_withdrawn + v1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg4), 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_treasury(arg1));
        };
        if (v2 > 0) {
            arg0.fees.partner_fee_withdrawn = arg0.fees.partner_fee_withdrawn + v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v2, arg4), arg0.partner);
        };
        let v5 = ContractWithdrawn{
            address           : 0x2::object::uid_to_address(&arg0.id),
            amount            : v3,
            streamflow_amount : v1,
            partner_amount    : v2,
        };
        0x2::event::emit<ContractWithdrawn>(v5);
    }

    public fun withdrawal_frequency<T0>(arg0: &Contract<T0>) : u64 {
        arg0.meta.withdrawal_frequency
    }

    // decompiled from Move bytecode v6
}

