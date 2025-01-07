module 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u16,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingKey has copy, drop, store {
        name: 0x1::string::String,
    }

    struct OpenEndedStaking has store {
        cooldown_period: u64,
        withdrawal_period: u64,
        reward_payout_frequency: u64,
        apy_bps: 0x2::vec_map::VecMap<u64, u16>,
        min_stakable_amount: u64,
        max_lockable_amount: u64,
    }

    struct LockedStaking has store {
        rules: 0x2::vec_map::VecMap<u64, LockedStakingRule>,
    }

    struct LockedStakingRule has drop, store {
        staking_window: u64,
        apy_bp: u16,
        min_stakable_amount: u64,
        max_lockable_amount: u64,
        restakable_window: u64,
    }

    fun borrow<T0: copy + drop + store, T1: store>(arg0: &Config, arg1: T0) : &T1 {
        assert!(is_version_eq(arg0), 0);
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut Config, arg1: T0) : &mut T1 {
        assert!(is_version_eq(arg0), 0);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public fun add_new_ls_rule(arg0: &AdminCap, arg1: &mut Config, arg2: LockedStakingRule, arg3: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool) {
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::add_new_stats(arg3, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str(), 0x1::option::some<u64>(arg2.staking_window));
        0x2::vec_map::insert<u64, LockedStakingRule>(&mut borrow_mut_ls(arg1).rules, arg2.staking_window, arg2);
    }

    public fun add_oes_new_apy_bp(arg0: &AdminCap, arg1: &mut Config, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::max_bps() >= arg2 && arg2 > 0, 1);
        assert!(arg3 >= 0x2::tx_context::epoch(arg4), 2);
        0x2::vec_map::insert<u64, u16>(&mut borrow_mut_oes(arg1).apy_bps, arg3, arg2);
    }

    public fun borrow_ls(arg0: &Config) : &LockedStaking {
        borrow<StakingKey, LockedStaking>(arg0, config_staking_key(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str()))
    }

    fun borrow_mut_ls(arg0: &mut Config) : &mut LockedStaking {
        borrow_mut<StakingKey, LockedStaking>(arg0, config_staking_key(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str()))
    }

    fun borrow_mut_oes(arg0: &mut Config) : &mut OpenEndedStaking {
        borrow_mut<StakingKey, OpenEndedStaking>(arg0, config_staking_key(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::open_ended_str()))
    }

    public fun borrow_oes(arg0: &Config) : &OpenEndedStaking {
        borrow<StakingKey, OpenEndedStaking>(arg0, config_staking_key(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::open_ended_str()))
    }

    fun config_staking_key(arg0: 0x1::string::String) : StakingKey {
        StakingKey{name: arg0}
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg1),
            version : 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::package::version(),
        };
        let v1 = OpenEndedStaking{
            cooldown_period         : 10,
            withdrawal_period       : 2,
            reward_payout_frequency : 7,
            apy_bps                 : 0x2::vec_map::empty<u64, u16>(),
            min_stakable_amount     : 200 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            max_lockable_amount     : 1000000 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
        };
        0x2::vec_map::insert<u64, u16>(&mut v1.apy_bps, 0x2::tx_context::epoch(arg1), 400);
        let v2 = LockedStaking{rules: 0x2::vec_map::empty<u64, LockedStakingRule>()};
        let v3 = LockedStakingRule{
            staking_window      : 90,
            apy_bp              : 600,
            min_stakable_amount : 200 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            max_lockable_amount : 2000000 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            restakable_window   : 1,
        };
        0x2::vec_map::insert<u64, LockedStakingRule>(&mut v2.rules, 90, v3);
        let v4 = LockedStakingRule{
            staking_window      : 182,
            apy_bp              : 1400,
            min_stakable_amount : 200 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            max_lockable_amount : 4000000 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            restakable_window   : 1,
        };
        0x2::vec_map::insert<u64, LockedStakingRule>(&mut v2.rules, 182, v4);
        let v5 = LockedStakingRule{
            staking_window      : 365,
            apy_bp              : 1800,
            min_stakable_amount : 200 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            max_lockable_amount : 6000000 * 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::times_token_decimals(),
            restakable_window   : 1,
        };
        0x2::vec_map::insert<u64, LockedStakingRule>(&mut v2.rules, 365, v5);
        let v6 = StakingKey{name: 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::open_ended_str()};
        0x2::dynamic_field::add<StakingKey, OpenEndedStaking>(&mut v0.id, v6, v1);
        let v7 = StakingKey{name: 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str()};
        0x2::dynamic_field::add<StakingKey, LockedStaking>(&mut v0.id, v7, v2);
        0x2::transfer::share_object<Config>(v0);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<CONFIG>(arg0, arg1);
    }

    public fun is_version_eq(arg0: &Config) : bool {
        arg0.version == 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::package::version()
    }

    public fun ls_apy_bp(arg0: &LockedStaking, arg1: u64) : u16 {
        0x2::vec_map::get<u64, LockedStakingRule>(&arg0.rules, &arg1).apy_bp
    }

    public fun ls_max_lockable_amount(arg0: &LockedStaking, arg1: u64) : u64 {
        0x2::vec_map::get<u64, LockedStakingRule>(&arg0.rules, &arg1).max_lockable_amount
    }

    public fun ls_min_stakable_amount(arg0: &LockedStaking, arg1: u64) : u64 {
        0x2::vec_map::get<u64, LockedStakingRule>(&arg0.rules, &arg1).min_stakable_amount
    }

    public fun ls_restakable_window(arg0: &LockedStaking, arg1: u64) : u64 {
        0x2::vec_map::get<u64, LockedStakingRule>(&arg0.rules, &arg1).restakable_window
    }

    public fun ls_staking_windows(arg0: &LockedStaking) : vector<u64> {
        0x2::vec_map::keys<u64, LockedStakingRule>(&arg0.rules)
    }

    public fun new_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::package::from_package<AdminCap>(arg0), 3);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun new_ls_rule(arg0: &AdminCap, arg1: u64, arg2: u16, arg3: u64, arg4: u64, arg5: u64) : LockedStakingRule {
        assert!(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::max_bps() >= arg2 && arg2 > 0, 1);
        LockedStakingRule{
            staking_window      : arg1,
            apy_bp              : arg2,
            min_stakable_amount : arg3,
            max_lockable_amount : arg4,
            restakable_window   : arg5,
        }
    }

    public fun oes_applied_apy_bp(arg0: &OpenEndedStaking, arg1: u64) : 0x1::option::Option<u16> {
        let v0 = 0x2::vec_map::keys<u64, u16>(&arg0.apy_bps);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            if (*0x1::vector::borrow<u64>(&v0, v1) > v2 && *0x1::vector::borrow<u64>(&v0, v1) <= arg1) {
                v2 = *0x1::vector::borrow<u64>(&v0, v1);
            };
            v1 = v1 + 1;
        };
        0x2::vec_map::try_get<u64, u16>(&arg0.apy_bps, &v2)
    }

    public fun oes_apy_bps(arg0: &OpenEndedStaking) : 0x2::vec_map::VecMap<u64, u16> {
        arg0.apy_bps
    }

    public fun oes_cooldown_period(arg0: &OpenEndedStaking) : u64 {
        arg0.cooldown_period
    }

    public fun oes_max_lockable_amount(arg0: &OpenEndedStaking) : u64 {
        arg0.max_lockable_amount
    }

    public fun oes_min_stakable_amount(arg0: &OpenEndedStaking) : u64 {
        arg0.min_stakable_amount
    }

    public fun oes_reward_payout_frequency(arg0: &OpenEndedStaking) : u64 {
        arg0.reward_payout_frequency
    }

    public fun oes_withdrawal_period(arg0: &OpenEndedStaking) : u64 {
        arg0.withdrawal_period
    }

    public fun remove_ls_rule(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool) {
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::remove_stats(arg3, 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::locked_str(), 0x1::option::some<u64>(arg2));
        let (_, _) = 0x2::vec_map::remove<u64, LockedStakingRule>(&mut borrow_mut_ls(arg1).rules, &arg2);
    }

    public fun take_from_pool(arg0: &AdminCap, arg1: &mut 0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::RewardPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x46fbe54691b27d7abd2c9e5a01088913531f241b98f3c2351f8215e45cc17a4c::times::TIMES> {
        0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::pool::take_from_pool(arg1, arg2, arg3)
    }

    public fun update_ls_apy_bp(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u16) {
        assert!(0xea39a4d37298e200d16cc760bd30b5704d000b95ccbde59734f08f6f3e9516e8::constants::max_bps() >= arg3 && arg3 > 0, 1);
        0x2::vec_map::get_mut<u64, LockedStakingRule>(&mut borrow_mut_ls(arg1).rules, &arg2).apy_bp = arg3;
    }

    public fun update_ls_max_lockable_amount(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        0x2::vec_map::get_mut<u64, LockedStakingRule>(&mut borrow_mut_ls(arg1).rules, &arg2).max_lockable_amount = arg3;
    }

    public fun update_ls_min_stakable_amount(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        0x2::vec_map::get_mut<u64, LockedStakingRule>(&mut borrow_mut_ls(arg1).rules, &arg2).min_stakable_amount = arg3;
    }

    public fun update_ls_restakable_window(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        0x2::vec_map::get_mut<u64, LockedStakingRule>(&mut borrow_mut_ls(arg1).rules, &arg2).restakable_window = arg3;
    }

    public fun update_oes_cooldown_period(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        borrow_mut_oes(arg1).cooldown_period = arg2;
    }

    public fun update_oes_max_lockable_amount(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        borrow_mut_oes(arg1).max_lockable_amount = arg2;
    }

    public fun update_oes_min_stakable_amount(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        borrow_mut_oes(arg1).min_stakable_amount = arg2;
    }

    public fun update_oes_reward_payout_frequency(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0, 5);
        borrow_mut_oes(arg1).reward_payout_frequency = arg2;
    }

    public fun update_oes_withdrawal_period(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0, 4);
        borrow_mut_oes(arg1).withdrawal_period = arg2;
    }

    // decompiled from Move bytecode v6
}

