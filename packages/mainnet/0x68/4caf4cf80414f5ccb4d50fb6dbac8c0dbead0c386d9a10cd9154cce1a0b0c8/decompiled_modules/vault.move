module 0x684caf4cf80414f5ccb4d50fb6dbac8c0dbead0c386d9a10cd9154cce1a0b0c8::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        main_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        deposits: 0x2::table::Table<0x1::string::String, DepositInfo>,
        total_deposited: u64,
        deposit_counter: u64,
        treasury_cap: 0x2::coin::TreasuryCap<VAULT>,
        total_rewards_committed: u64,
    }

    struct DepositInfo has store {
        user: address,
        manager: address,
        strategy: u64,
        amount: u64,
        manager_withdrawn: u64,
        rewards_earned: u64,
        is_active: bool,
    }

    struct DepositEvent has copy, drop {
        deposit_id: 0x1::string::String,
        user: address,
        manager: address,
        strategy: u64,
        amount: u64,
        samsui_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        deposit_id: 0x1::string::String,
        user: address,
        amount: u64,
        samsui_burned: u64,
    }

    struct RewardWithdrawEvent has copy, drop {
        deposit_id: 0x1::string::String,
        user: address,
        reward_amount: u64,
    }

    struct ManagerDepositEvent has copy, drop {
        deposit_id: 0x1::string::String,
        manager: address,
        amount: u64,
    }

    struct ManagerWithdrawEvent has copy, drop {
        deposit_id: 0x1::string::String,
        manager: address,
        amount: u64,
    }

    struct ManagerRewardDepositEvent has copy, drop {
        deposit_id: 0x1::string::String,
        manager: address,
        reward_amount: u64,
    }

    struct UserDepositMapping has copy, drop {
        user: address,
        deposit_id: 0x1::string::String,
    }

    public fun deposit(arg0: &mut Vault, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<VAULT>, 0x1::string::String) {
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 > 0, 5);
        assert!(v1 <= 100000000000000, 9);
        assert!(arg0.total_deposited <= 18446744073709551615 - v1, 9);
        arg0.deposit_counter = arg0.deposit_counter + 1;
        let v2 = generate_deposit_id(arg0.deposit_counter);
        let v3 = DepositInfo{
            user              : 0x2::tx_context::sender(arg4),
            manager           : arg1,
            strategy          : arg2,
            amount            : v1,
            manager_withdrawn : 0,
            rewards_earned    : 0,
            is_active         : true,
        };
        0x2::table::add<0x1::string::String, DepositInfo>(&mut arg0.deposits, v2, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.main_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.total_deposited = arg0.total_deposited + v1;
        let v4 = DepositEvent{
            deposit_id    : v2,
            user          : 0x2::tx_context::sender(arg4),
            manager       : arg1,
            strategy      : arg2,
            amount        : v1,
            samsui_minted : v1,
        };
        0x2::event::emit<DepositEvent>(v4);
        let v5 = UserDepositMapping{
            user       : 0x2::tx_context::sender(arg4),
            deposit_id : v2,
        };
        0x2::event::emit<UserDepositMapping>(v5);
        (0x2::coin::mint<VAULT>(&mut arg0.treasury_cap, v1, arg4), v2)
    }

    public entry fun deposit_by_manager(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
        assert!(v0.manager == 0x2::tx_context::sender(arg3), 4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 5);
        v0.amount = v0.amount + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.main_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v2 = ManagerDepositEvent{
            deposit_id : arg1,
            manager    : 0x2::tx_context::sender(arg3),
            amount     : v1,
        };
        0x2::event::emit<ManagerDepositEvent>(v2);
    }

    public entry fun deposit_entry(arg0: &mut Vault, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = deposit(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun deposit_rewards_by_manager(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
        assert!(v0.manager == 0x2::tx_context::sender(arg3), 4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 5);
        let v2 = v0.rewards_earned + v1;
        assert!(v2 <= 10000000000000, 10);
        let v3 = arg0.total_rewards_committed + v1;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) + v1 >= v3, 12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v0.rewards_earned = v2;
        arg0.total_rewards_committed = v3;
        let v4 = ManagerRewardDepositEvent{
            deposit_id    : arg1,
            manager       : 0x2::tx_context::sender(arg3),
            reward_amount : v1,
        };
        0x2::event::emit<ManagerRewardDepositEvent>(v4);
    }

    fun generate_deposit_id(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"DEPOSIT_");
        0x1::vector::append<u8>(&mut v0, num_to_bytes(arg0));
        0x1::string::utf8(v0)
    }

    public fun get_deposit_info(arg0: &Vault, arg1: 0x1::string::String) : (address, address, u64, u64, u64, u64, bool) {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow<0x1::string::String, DepositInfo>(&arg0.deposits, arg1);
        (v0.user, v0.manager, v0.strategy, v0.amount, v0.manager_withdrawn, v0.rewards_earned, v0.is_active)
    }

    public fun get_manager_available_withdrawal(arg0: &Vault, arg1: 0x1::string::String) : u64 {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow<0x1::string::String, DepositInfo>(&arg0.deposits, arg1);
        v0.amount - v0.manager_withdrawn
    }

    public fun get_total_rewards_committed(arg0: &Vault) : u64 {
        arg0.total_rewards_committed
    }

    public fun get_total_supply(arg0: &Vault) : u64 {
        0x2::coin::total_supply<VAULT>(&arg0.treasury_cap)
    }

    public fun get_vault_balances(arg0: &Vault) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.main_balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance))
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAULT>(arg0, 9, b"samSUI", b"samSUI", b"Receipt token for SUI deposits in the staking vault", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAULT>>(v1);
        let v2 = Vault{
            id                      : 0x2::object::new(arg1),
            main_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            reward_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            deposits                : 0x2::table::new<0x1::string::String, DepositInfo>(arg1),
            total_deposited         : 0,
            deposit_counter         : 0,
            treasury_cap            : v0,
            total_rewards_committed : 0,
        };
        0x2::transfer::share_object<Vault>(v2);
    }

    fun num_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun withdraw(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<VAULT>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
        assert!(v0.user == 0x2::tx_context::sender(arg4), 4);
        assert!(v0.is_active, 7);
        assert!(0x2::coin::value<VAULT>(&arg2) >= arg3, 6);
        assert!(v0.amount >= arg3, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.main_balance) >= arg3, 2);
        v0.amount = v0.amount - arg3;
        if (v0.amount == 0) {
            v0.is_active = false;
            if (v0.rewards_earned == 0) {
                let DepositInfo {
                    user              : _,
                    manager           : _,
                    strategy          : _,
                    amount            : _,
                    manager_withdrawn : _,
                    rewards_earned    : _,
                    is_active         : _,
                } = 0x2::table::remove<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
            };
        };
        0x2::coin::burn<VAULT>(&mut arg0.treasury_cap, 0x2::coin::split<VAULT>(&mut arg2, arg3, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(arg2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.main_balance, arg3), arg4), 0x2::tx_context::sender(arg4));
        arg0.total_deposited = arg0.total_deposited - arg3;
        let v8 = WithdrawEvent{
            deposit_id    : arg1,
            user          : 0x2::tx_context::sender(arg4),
            amount        : arg3,
            samsui_burned : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v8);
    }

    public entry fun withdraw_by_manager(arg0: &mut Vault, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
        assert!(v0.manager == 0x2::tx_context::sender(arg3), 4);
        assert!(arg2 > 0, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.main_balance) >= arg2, 2);
        assert!(arg2 <= v0.amount - v0.manager_withdrawn, 8);
        v0.manager_withdrawn = v0.manager_withdrawn + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.main_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v1 = ManagerWithdrawEvent{
            deposit_id : arg1,
            manager    : 0x2::tx_context::sender(arg3),
            amount     : arg2,
        };
        0x2::event::emit<ManagerWithdrawEvent>(v1);
    }

    public entry fun withdraw_rewards(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, DepositInfo>(&arg0.deposits, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
        assert!(v0.user == 0x2::tx_context::sender(arg2), 4);
        assert!(v0.is_active, 7);
        let v1 = v0.rewards_earned;
        assert!(v1 > 0, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.reward_balance) >= v1, 2);
        arg0.total_rewards_committed = arg0.total_rewards_committed - v1;
        v0.rewards_earned = 0;
        if (v0.amount == 0) {
            v0.is_active = false;
            let DepositInfo {
                user              : _,
                manager           : _,
                strategy          : _,
                amount            : _,
                manager_withdrawn : _,
                rewards_earned    : _,
                is_active         : _,
            } = 0x2::table::remove<0x1::string::String, DepositInfo>(&mut arg0.deposits, arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_balance, v1), arg2), 0x2::tx_context::sender(arg2));
        let v9 = RewardWithdrawEvent{
            deposit_id    : arg1,
            user          : 0x2::tx_context::sender(arg2),
            reward_amount : v1,
        };
        0x2::event::emit<RewardWithdrawEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

