module 0x9dd8b49b2c55794a5b8e07da4f94196fdcf1bbaba04c40775a4455c5479bc70e::permission {
    struct Permission has copy, drop, store {
        feature_permission: FeaturePermission,
        launch: LaunchConfig,
    }

    struct LaunchConfig has copy, drop, store {
        liquidity_open_time: u64,
        swap_open_time: u64,
    }

    struct FeaturePermission has copy, drop, store {
        disable_add: bool,
        disable_remove: bool,
        disable_swap: bool,
        disable_flash_loan: bool,
        disable_collect_fee: bool,
        disable_add_reward: bool,
        disable_collect_reward: bool,
    }

    public fun feature_permission(arg0: &Permission) : FeaturePermission {
        arg0.feature_permission
    }

    public fun launch(arg0: &Permission) : LaunchConfig {
        arg0.launch
    }

    public fun liquidity_open_time(arg0: &Permission) : u64 {
        arg0.launch.liquidity_open_time
    }

    public(friend) fun new(arg0: u64, arg1: u64) : Permission {
        let v0 = FeaturePermission{
            disable_add            : false,
            disable_remove         : false,
            disable_swap           : false,
            disable_flash_loan     : false,
            disable_collect_fee    : false,
            disable_add_reward     : false,
            disable_collect_reward : false,
        };
        let v1 = LaunchConfig{
            liquidity_open_time : arg0,
            swap_open_time      : arg1,
        };
        Permission{
            feature_permission : v0,
            launch             : v1,
        }
    }

    public fun swap_open_time(arg0: &Permission) : u64 {
        arg0.launch.swap_open_time
    }

    public fun update(arg0: &mut Permission, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: bool) {
        arg0.feature_permission.disable_add = arg1;
        arg0.feature_permission.disable_remove = arg2;
        arg0.feature_permission.disable_swap = arg3;
        arg0.feature_permission.disable_flash_loan = arg4;
        arg0.feature_permission.disable_collect_fee = arg5;
        arg0.feature_permission.disable_add_reward = arg6;
        arg0.feature_permission.disable_collect_reward = arg7;
    }

    public fun validate_add(arg0: &Permission, arg1: &0x2::clock::Clock) {
        assert!(!arg0.feature_permission.disable_add, 13835058746771898369);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.launch.liquidity_open_time, 13837029080199725071);
    }

    public fun validate_add_reward(arg0: &Permission) {
        assert!(!arg0.feature_permission.disable_add_reward, 13836747983180005389);
    }

    public fun validate_collect_fee(arg0: &Permission) {
        assert!(!arg0.feature_permission.disable_collect_fee, 13836184912967237641);
    }

    public fun validate_collect_reward(arg0: &Permission) {
        assert!(!arg0.feature_permission.disable_collect_reward, 13836466448073621515);
    }

    public fun validate_flash_loan(arg0: &Permission) {
        assert!(!arg0.feature_permission.disable_flash_loan, 13835903377860853767);
    }

    public fun validate_remove(arg0: &Permission) {
        assert!(!arg0.feature_permission.disable_remove, 13835340290468216835);
    }

    public fun validate_swap(arg0: &Permission, arg1: &0x2::clock::Clock) {
        assert!(!arg0.feature_permission.disable_swap, 13835621834164535301);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.launch.swap_open_time, 13837310692615520273);
    }

    // decompiled from Move bytecode v6
}

