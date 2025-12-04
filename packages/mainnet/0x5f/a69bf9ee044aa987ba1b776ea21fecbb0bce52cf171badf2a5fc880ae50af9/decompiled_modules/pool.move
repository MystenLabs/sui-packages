module 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        treasury_balance: 0x2::balance::Balance<T0>,
        decimal: u8,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct PoolCreate has copy, drop {
        creator: address,
    }

    struct PoolBalanceRegister has copy, drop {
        sender: address,
        amount: u64,
        new_amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolDeposit has copy, drop {
        sender: address,
        amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolWithdraw has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        pool: 0x1::ascii::String,
    }

    struct PoolWithdrawReserve has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
        before: u64,
        after: u64,
        pool: 0x1::ascii::String,
        poolId: address,
    }

    struct PoolManagerKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun convert_amount(arg0: u64, arg1: u8, arg2: u8) : u64 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public(friend) fun create_pool<T0>(arg0: &PoolAdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id               : 0x2::object::new(arg2),
            balance          : 0x2::balance::zero<T0>(),
            treasury_balance : 0x2::balance::zero<T0>(),
            decimal          : arg1,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        let v1 = PoolCreate{creator: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<PoolCreate>(v1);
    }

    public(friend) fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = PoolDeposit{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
            pool   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolDeposit>(v0);
    }

    public(friend) fun deposit_balance<T0>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        let v1 = PoolManagerKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PoolManagerKey>(&arg0.id, v1)) {
            let v2 = PoolManagerKey{dummy_field: false};
            0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::update_deposit(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v2), v0);
        };
        let v3 = PoolDeposit{
            sender : arg2,
            amount : v0,
            pool   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolDeposit>(v3);
    }

    public(friend) fun deposit_treasury<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::error::insufficient_balance());
        let v0 = PoolManagerKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PoolManagerKey>(&arg0.id, v0)) {
            let v1 = PoolManagerKey{dummy_field: false};
            0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::update_withdraw(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v1), arg1);
        };
        0x2::balance::join<T0>(&mut arg0.treasury_balance, 0x2::balance::split<T0>(&mut arg0.balance, arg1));
    }

    public fun direct_deposit_sui(arg0: &PoolAdminCap, arg1: &mut Pool<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        deposit<0x2::sui::SUI>(arg1, arg2, arg3);
    }

    public(friend) fun direct_withdraw_balance_v2<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = PoolManagerKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PoolManagerKey>(&arg0.id, v0)) {
            let v1 = PoolManagerKey{dummy_field: false};
            0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::update_withdraw(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v1), arg1);
        };
        let v2 = PoolWithdraw{
            sender    : arg2,
            recipient : arg2,
            amount    : arg1,
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolWithdraw>(v2);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun disable_manage(arg0: &PoolAdminCap, arg1: &mut Pool<0x2::sui::SUI>) {
        let v0 = PoolManagerKey{dummy_field: false};
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::disable_manage(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg1.id, v0), 0x2::balance::value<0x2::sui::SUI>(&arg1.balance));
    }

    public fun enable_manage(arg0: &PoolAdminCap, arg1: &mut Pool<0x2::sui::SUI>) {
        let v0 = PoolManagerKey{dummy_field: false};
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::enable_manage(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg1.id, v0));
    }

    public fun get_coin_decimal<T0>(arg0: &Pool<T0>) : u8 {
        arg0.decimal
    }

    public fun get_treasury_sui_amount(arg0: &Pool<0x2::sui::SUI>) : u64 {
        let v0 = PoolManagerKey{dummy_field: false};
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::get_treasury_sui_amount(0x2::dynamic_field::borrow<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&arg0.id, v0), 0x2::balance::value<0x2::sui::SUI>(&arg0.balance))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_sui_pool_manager(arg0: &PoolAdminCap, arg1: &mut Pool<0x2::sui::SUI>, arg2: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::stake_pool::StakePool, arg3: 0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::Metadata<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<PoolManagerKey>(&arg1.id, v0), 0);
        let v1 = PoolManagerKey{dummy_field: false};
        0x2::dynamic_field::add<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg1.id, v1, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::new(arg2, arg3, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg4, arg5));
    }

    public fun normal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, get_coin_decimal<T0>(arg0), 9)
    }

    public fun refresh_stake(arg0: &mut Pool<0x2::sui::SUI>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerKey{dummy_field: false};
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::refresh_stake(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v0), &mut arg0.balance, arg1, arg2);
    }

    public fun set_target_sui_amount(arg0: &PoolAdminCap, arg1: &mut Pool<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg1.id, v0);
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::set_target_sui_amount(v1, arg2);
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::refresh_stake(v1, &mut arg1.balance, arg3, arg4);
    }

    public fun set_validator_weights_vsui(arg0: &mut Pool<0x2::sui::SUI>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::stake_pool::OperatorCap, arg3: 0x2::vec_map::VecMap<address, u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerKey{dummy_field: false};
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::set_validator_weights_vsui(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v0), arg1, arg2, arg3, arg4);
    }

    public fun uid<T0>(arg0: &Pool<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun unnormal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, 9, get_coin_decimal<T0>(arg0))
    }

    public fun unstake_vsui(arg0: &mut Pool<0x2::sui::SUI>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = PoolManagerKey{dummy_field: false};
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::unstake_vsui(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v0), arg1, arg2, arg3)
    }

    public(friend) fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolWithdraw{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            amount    : arg1,
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolWithdraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    public(friend) fun withdraw_balance<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = PoolManagerKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PoolManagerKey>(&arg0.id, v0)) {
            abort 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::error::invalid_function_call()
        };
        let v1 = PoolWithdraw{
            sender    : arg2,
            recipient : arg2,
            amount    : arg1,
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolWithdraw>(v1);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public(friend) fun withdraw_balance_v2<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v0 = PoolManagerKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_<PoolManagerKey>(&arg0.id, v0)) {
            let v2 = PoolManagerKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg0.id, v2);
            0x2::balance::join<T0>(&mut arg0.balance, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::prepare_before_withdraw<T0>(v3, arg1, 0x2::balance::value<T0>(&arg0.balance), arg3, arg4));
            0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::update_withdraw(v3, arg1);
            0x2::balance::split<T0>(&mut arg0.balance, arg1)
        } else {
            0x2::balance::split<T0>(&mut arg0.balance, arg1)
        };
        let v4 = PoolWithdraw{
            sender    : arg2,
            recipient : arg2,
            amount    : arg1,
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<PoolWithdraw>(v4);
        v1
    }

    public(friend) fun withdraw_reserve_balance<T0>(arg0: &PoolAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::error::invalid_function_call()
    }

    public(friend) fun withdraw_reserve_balance_v2<T0>(arg0: &PoolAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PoolManagerKey>(&arg1.id, v0)) {
            let v1 = PoolManagerKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg1.id, v1);
            0x2::balance::join<T0>(&mut arg1.balance, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::prepare_before_withdraw<T0>(v2, arg2, 0x2::balance::value<T0>(&arg1.balance), arg4, arg5));
            0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::update_withdraw(v2, arg2);
        };
        let v3 = 0x2::balance::value<T0>(&arg1.balance);
        assert!(v3 >= arg2, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::error::insufficient_balance());
        let v4 = PoolWithdrawReserve{
            sender    : 0x2::tx_context::sender(arg5),
            recipient : arg3,
            amount    : arg2,
            before    : v3,
            after     : 0x2::balance::value<T0>(&arg1.balance),
            pool      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            poolId    : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::event::emit<PoolWithdrawReserve>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg5), arg3);
    }

    public fun withdraw_treasury<T0>(arg0: &mut PoolAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.treasury_balance) >= arg2, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::error::insufficient_balance());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury_balance, arg2), arg4), arg3);
    }

    public fun withdraw_vsui_from_treasury(arg0: &PoolAdminCap, arg1: &mut Pool<0x2::sui::SUI>, arg2: address, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolManagerKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>>(0x2::coin::from_balance<0x634511c660964940915acb37dde75963e35f2d1b0a034b41e2da8f3e9d1491ae::cert::CERT>(0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::take_vsui_from_treasury(0x2::dynamic_field::borrow_mut<PoolManagerKey, 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::pool_manager::SuiPoolManager>(&mut arg1.id, v0), 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg3, arg4), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

