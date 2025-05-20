module 0x8a5b5e989383393d2b09b0d0b755de77d78d8ee39d63fa22fc9fccdbe6464836::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminWithdrawEvent has copy, drop {
        amount: u64,
    }

    struct FundsStakedEvent has copy, drop {
        amount: u64,
    }

    struct FundsUnstakedEvent has copy, drop {
        amount: u64,
    }

    struct RewardsAddedEvent has copy, drop {
        amount: u64,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::table::Table<address, u64>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_staked: u64,
        total_rewards_collected: u64,
        total_deposited: u64,
        operators: vector<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_funds_to_pool(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (arg2) {
            arg0.total_rewards_collected = arg0.total_rewards_collected + v1;
            let v2 = RewardsAddedEvent{amount: v1};
            0x2::event::emit<RewardsAddedEvent>(v2);
        };
    }

    public entry fun add_operator(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        if (!0x1::vector::contains<address>(&arg0.operators, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.operators, arg2);
        };
    }

    public entry fun admin_withdraw(arg0: &mut StakingPool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.admin, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg3), v0);
        let v1 = AdminWithdrawEvent{amount: arg2};
        0x2::event::emit<AdminWithdrawEvent>(v1);
    }

    public entry fun create_pool(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = StakingPool{
            id                      : 0x2::object::new(arg1),
            admin                   : v0,
            balances                : 0x2::table::new<address, u64>(arg1),
            sui_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_staked            : 0,
            total_rewards_collected : 0,
            total_deposited         : 0,
            operators               : v1,
        };
        0x2::transfer::share_object<StakingPool>(v2);
    }

    public entry fun deposit(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 2);
        if (0x2::table::contains<address, u64>(&arg0.balances, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v0);
            *v2 = *v2 + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, v0, v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_deposited = arg0.total_deposited + v1;
        let v3 = DepositEvent{
            user   : v0,
            amount : v1,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun get_available_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_balance(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    public fun get_operators(arg0: &StakingPool) : vector<address> {
        arg0.operators
    }

    public fun get_total_deposited(arg0: &StakingPool) : u64 {
        arg0.total_deposited
    }

    public fun get_total_rewards_collected(arg0: &StakingPool) : u64 {
        arg0.total_rewards_collected
    }

    public fun get_total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = 0x2::package::claim<POOL>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"SUI Staking Pool"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"A staking pool for SUI that allows users to deposit SUI with staking managed off-chain"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://sui.io/branding/sui-logo.png"));
        let v7 = 0x2::display::new_with_fields<StakingPool>(&v2, v3, v5, arg1);
        0x2::display::update_version<StakingPool>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
        0x2::transfer::public_transfer<0x2::display::Display<StakingPool>>(v7, v0);
    }

    public fun is_admin(arg0: &StakingPool, arg1: address) : bool {
        arg0.admin == arg1
    }

    public fun is_operator(arg0: &StakingPool, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public entry fun move_funds_for_staking(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2), v0);
        arg0.total_staked = arg0.total_staked + arg1;
        let v1 = FundsStakedEvent{amount: arg1};
        0x2::event::emit<FundsStakedEvent>(v1);
    }

    public entry fun record_unstaking(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 3);
        let v1 = if (arg0.total_staked >= arg1) {
            arg0.total_staked - arg1
        } else {
            0
        };
        arg0.total_staked = v1;
        let v2 = FundsUnstakedEvent{amount: arg1};
        0x2::event::emit<FundsUnstakedEvent>(v2);
    }

    public entry fun remove_operator(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.operators, v1);
        };
    }

    public entry fun transfer_admin(arg0: &mut StakingPool, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.admin = arg2;
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public entry fun withdraw(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.balances, v0);
        assert!(*v1 >= arg1, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 1);
        *v1 = *v1 - arg1;
        if (*v1 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.balances, v0);
        };
        arg0.total_deposited = arg0.total_deposited - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2), v0);
        let v2 = WithdrawEvent{
            user   : v0,
            amount : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

