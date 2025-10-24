module 0x2bd491ff17d05a26aa3546167cc1dcc7b1d28855edce422efe0ca5c252df0036::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        reward_balances: 0x2::bag::Bag,
        accumulated_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        admin_reward_fees: 0x2::bag::Bag,
        total_shares: u64,
        user_shares: 0x2::table::Table<address, u64>,
        accumulated_fees_a: u64,
        accumulated_fees_b: u64,
        last_fee_collection: u64,
        admin: address,
        bot_address: address,
        is_paused: bool,
        reward_fee_bps: u64,
        pool_id: 0x2::object::ID,
        min_deposit_a: u64,
        min_deposit_b: u64,
    }

    struct VaultShare has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        admin: address,
        bot_address: address,
    }

    struct UserDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount_a: u64,
        amount_b: u64,
        shares_minted: u64,
        timestamp: u64,
    }

    struct UserWithdrew has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount_a: u64,
        amount_b: u64,
        shares_burned: u64,
        timestamp: u64,
    }

    struct FeesCollected has copy, drop {
        vault_id: 0x2::object::ID,
        fees_a: u64,
        fees_b: u64,
        timestamp: u64,
    }

    struct BotRebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        action: u8,
        amount_a: u64,
        amount_b: u64,
        timestamp: u64,
    }

    struct RewardDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    public fun admin_withdraw_reward_fees<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.admin_reward_fees, v0), 3);
        0x2::coin::from_balance<T2>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.admin_reward_fees, v0), arg2)
    }

    public fun bot_deposit_fees<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.bot_address, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        arg0.accumulated_fees_a = arg0.accumulated_fees_a + v0;
        arg0.accumulated_fees_b = arg0.accumulated_fees_b + v1;
        arg0.last_fee_collection = 0x2::clock::timestamp_ms(arg3);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        let v2 = FeesCollected{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            fees_a    : v0,
            fees_b    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesCollected>(v2);
    }

    public fun bot_deposit_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot_address, 0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let v1 = 0x1::type_name::get<T2>();
        let v2 = (((v0 as u128) * (arg0.reward_fee_bps as u128) / 10000) as u64);
        let v3 = 0x2::coin::into_balance<T2>(arg1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.admin_reward_fees, v1)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.admin_reward_fees, v1), 0x2::balance::split<T2>(&mut v3, v2));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.admin_reward_fees, v1, 0x2::balance::split<T2>(&mut v3, v2));
        };
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reward_balances, v1)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.reward_balances, v1), v3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.reward_balances, v1, v3);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.accumulated_rewards, &v1)) {
            let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.accumulated_rewards, &v1);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.accumulated_rewards, v1, v5 + v0);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.accumulated_rewards, v1, v0);
        };
        let v6 = RewardDeposited{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            reward_type : v1,
            amount      : v0 - v2,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RewardDeposited>(v6);
    }

    public fun bot_report_rebalance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.bot_address, 0);
        let v0 = BotRebalanced{
            vault_id  : 0x2::object::uid_to_inner(&arg0.id),
            action    : arg1,
            amount_a  : arg2,
            amount_b  : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BotRebalanced>(v0);
    }

    public fun bot_withdraw_for_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot_address, 0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, arg2), arg3))
    }

    public entry fun create_and_share_vault<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        0x2::transfer::transfer<VaultCap>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun create_vault<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, VaultCap) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0, T1>{
            id                  : v0,
            balance_a           : 0x2::balance::zero<T0>(),
            balance_b           : 0x2::balance::zero<T1>(),
            reward_balances     : 0x2::bag::new(arg5),
            accumulated_rewards : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            admin_reward_fees   : 0x2::bag::new(arg5),
            total_shares        : 0,
            user_shares         : 0x2::table::new<address, u64>(arg5),
            accumulated_fees_a  : 0,
            accumulated_fees_b  : 0,
            last_fee_collection : 0,
            admin               : 0x2::tx_context::sender(arg5),
            bot_address         : arg1,
            is_paused           : false,
            reward_fee_bps      : arg4,
            pool_id             : arg0,
            min_deposit_a       : arg2,
            min_deposit_b       : arg3,
        };
        let v3 = VaultCap{
            id       : 0x2::object::new(arg5),
            vault_id : v1,
        };
        let v4 = VaultCreated{
            vault_id    : v1,
            pool_id     : arg0,
            admin       : 0x2::tx_context::sender(arg5),
            bot_address : arg1,
        };
        0x2::event::emit<VaultCreated>(v4);
        (v2, v3)
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VaultShare {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 >= arg0.min_deposit_a, 3);
        assert!(v1 >= arg0.min_deposit_b, 3);
        let v2 = if (arg0.total_shares == 0) {
            (((v0 as u128) * (v1 as u128)) as u64) / 1000000
        } else {
            let v3 = (v0 as u128) * (arg0.total_shares as u128) / (0x2::balance::value<T0>(&arg0.balance_a) as u128);
            let v4 = (v1 as u128) * (arg0.total_shares as u128) / (0x2::balance::value<T1>(&arg0.balance_b) as u128);
            if (v3 < v4) {
                (v3 as u64)
            } else {
                (v4 as u64)
            }
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        let v5 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, u64>(&arg0.user_shares, v5)) {
            0x2::table::add<address, u64>(&mut arg0.user_shares, v5, 0x2::table::remove<address, u64>(&mut arg0.user_shares, v5) + v2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_shares, v5, v2);
        };
        arg0.total_shares = arg0.total_shares + v2;
        let v6 = VaultShare{
            id       : 0x2::object::new(arg4),
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            shares   : v2,
        };
        let v7 = UserDeposited{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            user          : v5,
            amount_a      : v0,
            amount_b      : v1,
            shares_minted : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UserDeposited>(v7);
        v6
    }

    public fun get_accumulated_reward<T0, T1, T2>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.accumulated_rewards, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.accumulated_rewards, &v0)
        } else {
            0
        }
    }

    public fun get_admin_reward_fees<T0, T1, T2>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.admin_reward_fees, v0)) {
            0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.admin_reward_fees, v0))
        } else {
            0
        }
    }

    public fun get_bot_address<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.bot_address
    }

    public fun get_reward_balance<T0, T1, T2>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reward_balances, v0)) {
            0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.reward_balances, v0))
        } else {
            0
        }
    }

    public fun get_reward_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.reward_fee_bps
    }

    public fun get_user_claimable_reward<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.user_shares, arg1)) {
            return 0
        };
        let v0 = *0x2::table::borrow<address, u64>(&arg0.user_shares, arg1);
        if (v0 == 0 || arg0.total_shares == 0) {
            return 0
        };
        let v1 = 0x1::type_name::get<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reward_balances, v1)) {
            return 0
        };
        (((v0 as u128) * (0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.reward_balances, v1)) as u128) / (arg0.total_shares as u128)) as u64)
    }

    public fun get_user_shares<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_shares, arg1)
        } else {
            0
        }
    }

    public fun get_vault_balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg0.total_shares)
    }

    public fun get_vault_fees<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (arg0.accumulated_fees_a, arg0.accumulated_fees_b, arg0.last_fee_collection)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VAULT>(arg0, arg1);
        let v1 = 0x2::display::new<VaultShare>(&v0, arg1);
        0x2::display::add<VaultShare>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Bluefin Vault Share"));
        0x2::display::add<VaultShare>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Represents your share in the Bluefin automated liquidity vault. Earn trading fees 24/7 while the bot manages your LP positions."));
        0x2::display::add<VaultShare>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/sui-coin.svg/public"));
        0x2::display::add<VaultShare>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://liquidity.quantumvoid.org"));
        0x2::display::add<VaultShare>(&mut v1, 0x1::string::utf8(b"shares"), 0x1::string::utf8(b"{shares}"));
        0x2::display::add<VaultShare>(&mut v1, 0x1::string::utf8(b"vault_id"), 0x1::string::utf8(b"{vault_id}"));
        0x2::display::update_version<VaultShare>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<VaultShare>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_vault_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.is_paused
    }

    public fun set_vault_status<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.is_paused = arg2;
    }

    public fun update_bot_address<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.bot_address = arg2;
    }

    public fun update_reward_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg2 <= 10000, 3);
        arg0.reward_fee_bps = arg2;
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: VaultShare, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.is_paused, 2);
        assert!(arg1.vault_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        let VaultShare {
            id       : v0,
            vault_id : _,
            shares   : v2,
        } = arg1;
        0x2::object::delete(v0);
        let v3 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, u64>(&arg0.user_shares, v3), 1);
        let v4 = 0x2::table::remove<address, u64>(&mut arg0.user_shares, v3);
        assert!(v4 >= v2, 1);
        if (v4 > v2) {
            0x2::table::add<address, u64>(&mut arg0.user_shares, v3, v4 - v2);
        };
        let v5 = (((v2 as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128) / (arg0.total_shares as u128)) as u64);
        let v6 = (((v2 as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128) / (arg0.total_shares as u128)) as u64);
        arg0.total_shares = arg0.total_shares - v2;
        let v7 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v5), arg3);
        let v8 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v6), arg3);
        withdraw_rewards_internal<T0, T1>(arg0, v2, v3, arg3);
        let v9 = UserWithdrew{
            vault_id      : 0x2::object::uid_to_inner(&arg0.id),
            user          : v3,
            amount_a      : v5,
            amount_b      : v6,
            shares_burned : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UserWithdrew>(v9);
        (v7, v8)
    }

    public fun withdraw_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::table::contains<address, u64>(&arg0.user_shares, arg1), 1);
        let v0 = *0x2::table::borrow<address, u64>(&arg0.user_shares, arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x1::type_name::get<T2>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.reward_balances, v1), 3);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.reward_balances, v1);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(v2, (((v0 as u128) * (0x2::balance::value<T2>(v2) as u128) / (arg0.total_shares as u128)) as u64)), arg2)
    }

    fun withdraw_rewards_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

