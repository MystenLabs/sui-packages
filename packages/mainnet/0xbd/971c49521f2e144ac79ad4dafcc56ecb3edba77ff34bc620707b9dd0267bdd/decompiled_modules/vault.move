module 0x81f077d146435758456c9962dffc03425af3c47f0b442869af63bf898b6c3ecf::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::coin::Coin<T0>,
        lp_price: u256,
        lp_supply: u256,
        lp_valult: 0x2::coin::Coin<T1>,
        total_fee: u256,
        liquidity_reward_basis_oints: u64,
        staking_reward_basis_points: u64,
        treasury_reward_basis_points: u64,
        host_fee_basis_points: u64,
        vault_fee_basis_points: u64,
        player_fee_basis_points: u64,
        liquidity_rewards: 0x2::coin::Coin<T0>,
        staking_rewards: 0x2::coin::Coin<T0>,
        treasury_rewards: 0x2::coin::Coin<T0>,
        users: 0x2::vec_map::VecMap<address, u64>,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = collect_vault_fee<T0, T1>(arg0, arg1, arg2);
        0x2::coin::join<T0>(&mut arg0.pool, v0);
        let v1 = (0x2::coin::value<T0>(&arg0.pool) as u256) * (arg0.lp_price as u256) / (1000000000 as u256);
        let v2 = if (v1 == 0) {
            (0x2::coin::value<T0>(&v0) as u256) * (arg0.lp_price as u256) / (1000000000 as u256)
        } else {
            (0x2::coin::value<T0>(&v0) as u256) * (arg0.lp_price as u256) / (1000000000 as u256) * arg0.lp_supply / v1
        };
        arg0.lp_supply = arg0.lp_supply + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.lp_valult, (v2 as u64), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun change_host_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        arg0.host_fee_basis_points = arg2;
    }

    public entry fun change_liquidity_reward_basis_points<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        arg0.liquidity_reward_basis_oints = arg2;
    }

    public entry fun change_player_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        arg0.player_fee_basis_points = arg2;
    }

    public entry fun change_staking_reward_basis_points<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        arg0.staking_reward_basis_points = arg2;
    }

    public entry fun change_treasury_reward_basis_points<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        arg0.treasury_reward_basis_points = arg2;
    }

    public entry fun change_vault_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg3), 1005);
        arg0.vault_fee_basis_points = arg2;
    }

    public fun check_pool_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : bool {
        0x2::coin::value<T0>(&arg0.pool) * 100 / 10000 >= arg1
    }

    public entry fun claim_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg2), 1005);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.liquidity_rewards, 0x2::coin::value<T0>(&arg0.liquidity_rewards), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_staking<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg2), 1005);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.staking_rewards, 0x2::coin::value<T0>(&arg0.staking_rewards), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun cliam_treasury<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::is_admin(arg1, arg2), 1005);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.treasury_rewards, 0x2::coin::value<T0>(&arg0.treasury_rewards), arg2), 0x2::tx_context::sender(arg2));
    }

    fun collect_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::join<T0>(&mut arg0.liquidity_rewards, 0x2::coin::split<T0>(&mut arg1, v0 * arg0.liquidity_reward_basis_oints / 10000, arg2));
        0x2::coin::join<T0>(&mut arg0.staking_rewards, 0x2::coin::split<T0>(&mut arg1, v0 * arg0.staking_reward_basis_points / 10000, arg2));
        0x2::coin::join<T0>(&mut arg0.treasury_rewards, 0x2::coin::split<T0>(&mut arg1, v0 * arg0.treasury_reward_basis_points / 10000, arg2));
        0x2::coin::join<T0>(&mut arg0.treasury_rewards, arg1);
    }

    fun collect_host_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.total_fee = arg0.total_fee + (arg1 as u256);
        0x2::coin::join<T0>(&mut arg0.liquidity_rewards, 0x2::coin::split<T0>(&mut arg0.pool, arg1 * arg0.liquidity_reward_basis_oints / 10000, arg2));
        0x2::coin::join<T0>(&mut arg0.staking_rewards, 0x2::coin::split<T0>(&mut arg0.pool, arg1 * arg0.staking_reward_basis_points / 10000, arg2));
        0x2::coin::join<T0>(&mut arg0.treasury_rewards, 0x2::coin::split<T0>(&mut arg0.pool, arg1 * arg0.treasury_reward_basis_points / 10000, arg2));
    }

    public(friend) fun collect_player_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::split<T0>(&mut arg1, arg2 * arg0.player_fee_basis_points / 10000, arg3);
        collect_fee<T0, T1>(arg0, v0, arg3);
        arg1
    }

    public(friend) fun collect_vault_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) * arg0.vault_fee_basis_points / 10000, arg2);
        collect_fee<T0, T1>(arg0, v0, arg2);
        arg1
    }

    public entry fun create_vault<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0, T1>{
            id                           : 0x2::object::new(arg1),
            pool                         : 0x2::coin::zero<T0>(arg1),
            lp_price                     : (1000000000 as u256),
            lp_supply                    : 0,
            lp_valult                    : arg0,
            total_fee                    : 0,
            liquidity_reward_basis_oints : 3000,
            staking_reward_basis_points  : 5000,
            treasury_reward_basis_points : 2000,
            host_fee_basis_points        : 500,
            vault_fee_basis_points       : 100,
            player_fee_basis_points      : 200,
            liquidity_rewards            : 0x2::coin::zero<T0>(arg1),
            staking_rewards              : 0x2::coin::zero<T0>(arg1),
            treasury_rewards             : 0x2::coin::zero<T0>(arg1),
            users                        : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::public_share_object<Vault<T0, T1>>(v0);
    }

    public fun get_player_fee<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.player_fee_basis_points
    }

    public fun get_vault_fee<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.vault_fee_basis_points
    }

    public(friend) fun lose<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T0>(&arg0.pool);
        arg0.lp_price = ((v1 as u256) + (v0 as u256) * arg0.lp_price / 1000000000) * 1000000000 / (v1 as u256);
        let v2 = (((v0 as u256) * (arg0.host_fee_basis_points as u256) / (10000 as u256)) as u64);
        collect_host_fee<T0, T1>(arg0, v2, arg2);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::split<T0>(&mut arg0.pool, v0 - v2, arg2));
        arg1
    }

    public(friend) fun lose_amount<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0.pool);
        arg0.lp_price = ((v0 as u256) + (arg2 as u256) * arg0.lp_price / 1000000000) * 1000000000 / (v0 as u256);
        let v1 = (((arg2 as u256) * (arg0.host_fee_basis_points as u256) / (10000 as u256)) as u64);
        collect_host_fee<T0, T1>(arg0, v1, arg3);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::split<T0>(&mut arg0.pool, arg2 - v1, arg3));
        arg1
    }

    public(friend) fun lost_multiple_times<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 1, 1101);
        let v0 = ((0x2::coin::value<T0>(&arg1) * (arg2 - 1)) as u256);
        let v1 = (0x2::coin::value<T0>(&arg0.pool) as u256);
        arg0.lp_price = ((v1 as u256) + v0 * arg0.lp_price / 1000000000) * 1000000000 / v1;
        let v2 = ((v0 * (arg0.host_fee_basis_points as u256) / (10000 as u256)) as u64);
        collect_host_fee<T0, T1>(arg0, v2, arg3);
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::split<T0>(&mut arg0.pool, (v0 as u64) - v2, arg3));
        arg1
    }

    public fun pool_amount<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::value<T0>(&arg0.pool)
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        arg0.lp_supply = arg0.lp_supply - (v0 as u256);
        0x2::coin::join<T1>(&mut arg0.lp_valult, arg1);
        let v1 = 0x2::coin::split<T0>(&mut arg0.pool, (((v0 as u256) * (0x2::coin::value<T0>(&arg0.pool) as u256) * (1000000000 as u256) / (1000000000 as u256) / arg0.lp_supply) as u64), arg2);
        let v2 = collect_vault_fee<T0, T1>(arg0, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun return_bet<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0.pool);
        arg0.lp_price = ((v0 as u256) + (arg1 as u256) * arg0.lp_price / 1000000000) * 1000000000 / (v0 as u256);
        0x2::coin::split<T0>(&mut arg0.pool, arg1, arg2)
    }

    public(friend) fun take_bet<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0.pool);
        arg0.lp_price = ((v0 as u256) + (0x2::coin::value<T0>(&arg1) as u256) * (arg0.lp_price as u256) / (1000000000 as u256)) * 1000000000 / (v0 as u256);
        0x2::coin::join<T0>(&mut arg0.pool, arg1);
    }

    public(friend) fun take_treasury<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.treasury_rewards, arg1);
    }

    public(friend) fun win<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg0.pool);
        arg0.lp_price = ((v0 as u256) + (0x2::coin::value<T0>(&arg1) as u256) * arg0.lp_price / (1000000000 as u256)) * (1000000000 as u256) / (v0 as u256);
        0x2::coin::join<T0>(&mut arg0.pool, arg1);
    }

    // decompiled from Move bytecode v6
}

