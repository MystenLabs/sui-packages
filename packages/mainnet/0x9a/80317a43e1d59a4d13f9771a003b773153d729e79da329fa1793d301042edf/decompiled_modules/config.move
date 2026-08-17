module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        paused: bool,
        whitelisted_collections: vector<0x1::type_name::TypeName>,
    }

    struct ConfigUpdated has copy, drop {
        entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct TreeConfig has key {
        id: 0x2::object::UID,
        admin: address,
        utility_coin: 0x1::type_name::TypeName,
        reroll_cost: u64,
        boost_cost: u64,
        boost_growth: u64,
        max_tree_advantage: u64,
        advantage_per_tier: u64,
        min_tree_for_advantage: u64,
    }

    struct TreeConfigUpdated has copy, drop {
        reroll_cost: u64,
        boost_cost: u64,
        boost_growth: u64,
        max_tree_advantage: u64,
        advantage_per_tier: u64,
        min_tree_for_advantage: u64,
    }

    struct TreeAdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun advantage_per_tier(arg0: &TreeConfig) : u64 {
        arg0.advantage_per_tier
    }

    public fun boost_cost(arg0: &TreeConfig) : u64 {
        arg0.boost_cost
    }

    public fun boost_growth(arg0: &TreeConfig) : u64 {
        arg0.boost_growth
    }

    public fun entry_fee(arg0: &Config) : u64 {
        arg0.entry_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                      : 0x2::object::new(arg0),
            admin                   : 0x2::tx_context::sender(arg0),
            treasury                : @0x956624f2fbbdf16bb5e334b550efd975ff7677e34bbd4e18cb6f485756af6c08,
            entry_fee               : 100000000,
            winner_payout           : 150000000,
            treasury_share          : 50000000,
            paused                  : false,
            whitelisted_collections : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun init_tree_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreeConfig{
            id                     : 0x2::object::new(arg0),
            admin                  : 0x2::tx_context::sender(arg0),
            utility_coin           : 0x1::type_name::with_original_ids<0x2::sui::SUI>(),
            reroll_cost            : 0,
            boost_cost             : 0,
            boost_growth           : 0,
            max_tree_advantage     : 0,
            advantage_per_tier     : 0,
            min_tree_for_advantage : 0,
        };
        0x2::transfer::share_object<TreeConfig>(v0);
    }

    public fun is_collection_whitelisted<T0: store + key>(arg0: &Config) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.whitelisted_collections, &v0)
    }

    public fun is_utility_coin<T0>(arg0: &TreeConfig) : bool {
        0x1::type_name::with_original_ids<T0>() == arg0.utility_coin
    }

    public fun max_tree_advantage(arg0: &TreeConfig) : u64 {
        arg0.max_tree_advantage
    }

    public fun min_tree_for_advantage(arg0: &TreeConfig) : u64 {
        arg0.min_tree_for_advantage
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun remove_collection<T0: store + key>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.whitelisted_collections, &v0);
        if (v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.whitelisted_collections, v2);
        };
    }

    public fun reroll_cost(arg0: &TreeConfig) : u64 {
        arg0.reroll_cost
    }

    public fun set_economics(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(arg2 + arg3 <= 2 * arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_economics());
        arg0.entry_fee = arg1;
        arg0.winner_payout = arg2;
        arg0.treasury_share = arg3;
        let v0 = ConfigUpdated{
            entry_fee      : arg1,
            winner_payout  : arg2,
            treasury_share : arg3,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        arg0.paused = arg1;
    }

    public fun set_treasury(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(arg1 != @0x0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        arg0.treasury = arg1;
        let v0 = TreasuryUpdated{
            old_treasury : arg0.treasury,
            new_treasury : arg1,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun set_tree_params(arg0: &mut TreeConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        arg0.reroll_cost = arg1;
        arg0.boost_cost = arg2;
        arg0.boost_growth = arg3;
        arg0.max_tree_advantage = arg4;
        arg0.advantage_per_tier = arg5;
        arg0.min_tree_for_advantage = arg6;
        let v0 = TreeConfigUpdated{
            reroll_cost            : arg1,
            boost_cost             : arg2,
            boost_growth           : arg3,
            max_tree_advantage     : arg4,
            advantage_per_tier     : arg5,
            min_tree_for_advantage : arg6,
        };
        0x2::event::emit<TreeConfigUpdated>(v0);
    }

    public fun set_utility_coin<T0>(arg0: &mut TreeConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        arg0.utility_coin = 0x1::type_name::with_original_ids<T0>();
    }

    public fun transfer_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(arg1 != @0x0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        assert!(arg1 != arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_transfer_noop());
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun transfer_tree_admin(arg0: &mut TreeConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(arg1 != @0x0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        assert!(arg1 != arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_transfer_noop());
        arg0.admin = arg1;
        let v0 = TreeAdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<TreeAdminTransferred>(v0);
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun treasury_share(arg0: &Config) : u64 {
        arg0.treasury_share
    }

    public fun tree_admin(arg0: &TreeConfig) : address {
        arg0.admin
    }

    public fun utility_coin(arg0: &TreeConfig) : 0x1::type_name::TypeName {
        arg0.utility_coin
    }

    public fun whitelist_collection<T0: store + key>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.whitelisted_collections, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.whitelisted_collections, v0);
        };
    }

    public fun winner_payout(arg0: &Config) : u64 {
        arg0.winner_payout
    }

    // decompiled from Move bytecode v7
}

