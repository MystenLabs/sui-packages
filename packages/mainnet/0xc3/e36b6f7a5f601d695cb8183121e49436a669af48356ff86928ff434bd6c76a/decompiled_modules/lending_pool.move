module 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::lending_pool {
    struct EventNewPool has copy, drop {
        base_asset: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
    }

    struct EventWithdrawalStarted<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        withdrawer: address,
        base_to_return: u64,
        base_paid: u64,
    }

    struct EventBorrow<phantom T0> has copy, drop {
        margin_account_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventDeposit<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        shares_minted: u64,
    }

    struct EventRegisteredLendingPool has copy, drop {
        pool_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
    }

    struct LendingPoolRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct Withdrawal<phantom T0> has store {
        owed: u64,
        paid: 0x2::balance::Balance<T0>,
        ticket_ref: 0x2::object::ID,
    }

    struct WithdrawalTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        queue_index: u64,
    }

    struct LendingPool<phantom T0> has key {
        id: 0x2::object::UID,
        base_deposited: u64,
        total_shares_supply: u64,
        borrowable_base: 0x2::balance::Balance<T0>,
        completed_withdrawals: 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<T0>>,
        pending_withdrawals: 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::Queue<Withdrawal<T0>>,
        borrowing_fee: 0x1::uq32_32::UQ32_32,
        protocol_fee: 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::protocol_fee::ProtocolFeeInfo,
        outstanding_debt: 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::OutstandingDebt<T0>,
    }

    struct DebtPoolShare<phantom T0> has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: address, arg3: &mut LendingPoolRegistry, arg4: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::admin::AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_new<T0>(arg0, arg1, arg2, arg5);
        add_lending_pool<T0>(arg3, &v0);
        let v1 = EventNewPool{
            base_asset : 0x1::type_name::get<T0>(),
            pool_id    : 0x2::object::id<LendingPool<T0>>(&v0),
        };
        0x2::event::emit<EventNewPool>(v1);
        0x2::transfer::share_object<LendingPool<T0>>(v0);
    }

    fun add_lending_pool<T0>(arg0: &mut LendingPoolRegistry, arg1: &LendingPool<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, v0), 6);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, v0, 0x2::object::uid_to_inner(&arg1.id));
        let v1 = EventRegisteredLendingPool{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            asset   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventRegisteredLendingPool>(v1);
    }

    public fun borrow_and_check_later<T0>(arg0: &mut LendingPool<T0>, arg1: &mut 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MarginAccount, arg2: u64, arg3: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MustCheckBorrowLimit) {
        let v0 = 0x1::uq32_32::int_mul(arg2, arg0.borrowing_fee);
        deposit_virtual_fees<T0>(arg0, v0);
        let v1 = 0x1::uq32_32::int_mul(arg2, 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::protocol_fee::fees(&arg0.protocol_fee));
        assert!(0x2::balance::value<T0>(&arg0.borrowable_base) >= arg2 + v1, 4);
        let (v2, v3) = 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::inscrease_debt<T0>(arg1, arg2 + v0 + v1, arg3, arg4, arg5);
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::join_outstanding_debt<T0>(&mut arg0.outstanding_debt, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.borrowable_base, v1), arg5), 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::protocol_fee::recipient(&arg0.protocol_fee));
        let v4 = EventBorrow<T0>{
            margin_account_id : 0x2::object::id<0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MarginAccount>(arg1),
            amount            : arg2,
        };
        0x2::event::emit<EventBorrow<T0>>(v4);
        (0x2::balance::split<T0>(&mut arg0.borrowable_base, arg2), v1 + v0, v3)
    }

    public fun deposit_fees<T0>(arg0: &mut LendingPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        arg0.base_deposited = arg0.base_deposited + 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.borrowable_base, arg1);
    }

    fun deposit_virtual_fees<T0>(arg0: &mut LendingPool<T0>, arg1: u64) {
        arg0.base_deposited = arg0.base_deposited + arg1;
    }

    public fun destroy<T0>(arg0: LendingPool<T0>, arg1: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::admin::AdminCap) : 0x2::balance::Balance<T0> {
        assert!(arg0.total_shares_supply == 0, 0);
        let LendingPool {
            id                    : v0,
            base_deposited        : _,
            total_shares_supply   : _,
            borrowable_base       : v3,
            completed_withdrawals : v4,
            pending_withdrawals   : v5,
            borrowing_fee         : _,
            protocol_fee          : _,
            outstanding_debt      : v8,
        } = arg0;
        0x2::table::destroy_empty<0x2::object::ID, 0x2::balance::Balance<T0>>(v4);
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::destroy_empty<Withdrawal<T0>>(v5);
        0x2::object::delete(v0);
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::destroy_zero_outstanding_debt<T0>(v8);
        v3
    }

    public fun destroy_debt_pool_share<T0>(arg0: DebtPoolShare<T0>) {
        assert!(arg0.value == 0, 5);
        let DebtPoolShare {
            id    : v0,
            value : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun finish_withdrawal<T0>(arg0: &mut LendingPool<T0>, arg1: WithdrawalTicket<T0>) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<T0>>(&arg0.completed_withdrawals, 0x2::object::uid_to_inner(&arg1.id)), 3);
        let WithdrawalTicket {
            id          : v0,
            queue_index : _,
        } = arg1;
        let v2 = v0;
        0x2::object::delete(v2);
        0x2::table::remove<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg0.completed_withdrawals, 0x2::object::uid_to_inner(&v2))
    }

    fun internal_new<T0>(arg0: u64, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : LendingPool<T0> {
        LendingPool<T0>{
            id                    : 0x2::object::new(arg3),
            base_deposited        : 0,
            total_shares_supply   : 0,
            borrowable_base       : 0x2::balance::zero<T0>(),
            completed_withdrawals : 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<T0>>(arg3),
            pending_withdrawals   : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::new<Withdrawal<T0>>(arg3),
            borrowing_fee         : 0x1::uq32_32::from_quotient(arg0, 10000),
            protocol_fee          : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::protocol_fee::new(arg1, arg2),
            outstanding_debt      : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::empty_outstanding_debt<T0>(),
        }
    }

    public(friend) fun internal_swap_borrow_and_check_later<T0>(arg0: &mut LendingPool<T0>, arg1: &mut 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MarginAccount, arg2: u64, arg3: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MustCheckBorrowLimit) {
        borrow_and_check_later<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun internal_swap_repay_for_margin_account<T0>(arg0: &mut LendingPool<T0>, arg1: &mut 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MarginAccount, arg2: 0x2::balance::Balance<T0>, arg3: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        repay_for_margin_account<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun into_completed_withdrawal_parts<T0>(arg0: Withdrawal<T0>) : (0x2::object::ID, 0x2::balance::Balance<T0>) {
        let Withdrawal {
            owed       : v0,
            paid       : v1,
            ticket_ref : v2,
        } = arg0;
        assert!(v0 == 0, 2);
        (v2, v1)
    }

    public fun join_debt_pool_shares<T0>(arg0: &mut DebtPoolShare<T0>, arg1: DebtPoolShare<T0>) {
        arg0.value = arg0.value + arg1.value;
        let DebtPoolShare {
            id    : v0,
            value : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public(friend) fun new_lending_registry(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LendingPoolRegistry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<LendingPoolRegistry>(v0);
        0x2::object::id<LendingPoolRegistry>(&v0)
    }

    public fun provide_base<T0>(arg0: &mut LendingPool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : DebtPoolShare<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.borrowable_base, arg1);
        let v1 = if (arg0.total_shares_supply == 0) {
            0x1::uq32_32::from_int(1)
        } else {
            0x1::uq32_32::from_quotient(arg0.total_shares_supply, arg0.base_deposited)
        };
        let v2 = 0x1::uq32_32::int_mul(v0, v1);
        arg0.base_deposited = arg0.base_deposited + v0;
        arg0.total_shares_supply = arg0.total_shares_supply + v2;
        let v3 = EventDeposit<T0>{
            pool_id       : 0x2::object::uid_to_inner(&arg0.id),
            depositor     : 0x2::tx_context::sender(arg2),
            amount        : v0,
            shares_minted : v2,
        };
        0x2::event::emit<EventDeposit<T0>>(v3);
        DebtPoolShare<T0>{
            id    : 0x2::object::new(arg2),
            value : v2,
        }
    }

    public fun repay<T0>(arg0: &mut LendingPool<T0>, arg1: 0x2::balance::Balance<T0>) : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::OutstandingDebt<T0> {
        assert!(0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::outstanding_debt_value<T0>(&arg0.outstanding_debt) >= 0x2::balance::value<T0>(&arg1), 1);
        while (!0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::is_empty<Withdrawal<T0>>(&arg0.pending_withdrawals) && 0x2::balance::value<T0>(&arg1) > 0) {
            let v0 = 0x1::u64::min(0x2::balance::value<T0>(&arg1), 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::borrow_front<Withdrawal<T0>>(&arg0.pending_withdrawals).owed);
            let v1 = 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::borrow_mut_front<Withdrawal<T0>>(&mut arg0.pending_withdrawals);
            0x2::balance::join<T0>(&mut v1.paid, 0x2::balance::split<T0>(&mut arg1, v0));
            v1.owed = v1.owed - v0;
            if (v1.owed == 0) {
                let (v2, v3) = into_completed_withdrawal_parts<T0>(0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::pop_front<Withdrawal<T0>>(&mut arg0.pending_withdrawals));
                0x2::table::add<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg0.completed_withdrawals, v2, v3);
            };
        };
        0x2::balance::join<T0>(&mut arg0.borrowable_base, arg1);
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::split_outstanding_debt<T0>(&mut arg0.outstanding_debt, 0x2::balance::value<T0>(&arg1))
    }

    public fun repay_for_margin_account<T0>(arg0: &mut LendingPool<T0>, arg1: &mut 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::MarginAccount, arg2: 0x2::balance::Balance<T0>, arg3: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::margin_account::decrease_debt<T0>(arg1, repay<T0>(arg0, arg2), arg3, arg4, arg5);
    }

    public fun split_debt_pool_share<T0>(arg0: &mut DebtPoolShare<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DebtPoolShare<T0> {
        assert!(arg0.value >= arg1, 4);
        arg0.value = arg0.value - arg1;
        DebtPoolShare<T0>{
            id    : 0x2::object::new(arg2),
            value : arg1,
        }
    }

    public fun start_withdrawal<T0>(arg0: &mut LendingPool<T0>, arg1: DebtPoolShare<T0>, arg2: &mut 0x2::tx_context::TxContext) : WithdrawalTicket<T0> {
        let DebtPoolShare {
            id    : v0,
            value : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = 0x1::uq32_32::int_mul(v1, 0x1::uq32_32::from_quotient(arg0.base_deposited, arg0.total_shares_supply));
        arg0.total_shares_supply = arg0.total_shares_supply - v1;
        arg0.base_deposited = arg0.base_deposited - v2;
        let v3 = 0x2::object::new(arg2);
        let v4 = WithdrawalTicket<T0>{
            id          : v3,
            queue_index : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::next_index<Withdrawal<T0>>(&arg0.pending_withdrawals),
        };
        let v5 = 0x1::u64::min(v2, 0x2::balance::value<T0>(&arg0.borrowable_base));
        if (v5 == v2) {
            0x2::table::add<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut arg0.completed_withdrawals, 0x2::object::uid_to_inner(&v3), 0x2::balance::split<T0>(&mut arg0.borrowable_base, v5));
        } else {
            let v6 = Withdrawal<T0>{
                owed       : v2 - v5,
                paid       : 0x2::balance::split<T0>(&mut arg0.borrowable_base, v5),
                ticket_ref : 0x2::object::uid_to_inner(&v3),
            };
            0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::push<Withdrawal<T0>>(&mut arg0.pending_withdrawals, v6);
        };
        let v7 = EventWithdrawalStarted<T0>{
            pool_id        : 0x2::object::uid_to_inner(&arg0.id),
            ticket_id      : 0x2::object::uid_to_inner(&v4.id),
            withdrawer     : 0x2::tx_context::sender(arg2),
            base_to_return : v2,
            base_paid      : v5,
        };
        0x2::event::emit<EventWithdrawalStarted<T0>>(v7);
        v4
    }

    public fun update_borrowing_fees<T0>(arg0: &mut LendingPool<T0>, arg1: 0x1::uq32_32::UQ32_32, arg2: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::admin::AdminCap) {
        arg0.borrowing_fee = arg1;
    }

    public fun update_protocol_fees<T0>(arg0: &mut LendingPool<T0>, arg1: 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::protocol_fee::ProtocolFeeInfo, arg2: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::admin::AdminCap) {
        arg0.protocol_fee = arg1;
    }

    public fun value_of_debt_pool_share<T0>(arg0: &DebtPoolShare<T0>) : u64 {
        arg0.value
    }

    public fun withdrawable_base<T0>(arg0: &LendingPool<T0>, arg1: &WithdrawalTicket<T0>) : u64 {
        let v0 = 0x2::object::id<WithdrawalTicket<T0>>(arg1);
        if (0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<T0>>(&arg0.completed_withdrawals, v0)) {
            return 0x2::balance::value<T0>(0x2::table::borrow<0x2::object::ID, 0x2::balance::Balance<T0>>(&arg0.completed_withdrawals, v0))
        };
        0x2::balance::value<T0>(&0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::queue::borrow_at<Withdrawal<T0>>(&arg0.pending_withdrawals, arg1.queue_index).paid)
    }

    // decompiled from Move bytecode v6
}

