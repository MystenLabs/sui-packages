module 0xbc027df4904e0f4671882796a4df6684070670304f7d824fd3807c81664b11fc::rewards_admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasurerCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardsConfig has key {
        id: 0x2::object::UID,
        holder_coin_type: 0x1::type_name::TypeName,
        next_epoch_no: u64,
        default_reward_bps: u16,
        paused: bool,
        total_epochs_created: u64,
        total_epochs_finalized: u64,
    }

    struct ConfigInitialized has copy, drop {
        config_id: 0x2::object::ID,
        holder_coin_type: 0x1::string::String,
        default_reward_bps: u16,
    }

    struct RewardBpsUpdated has copy, drop {
        old_bps: u16,
        new_bps: u16,
    }

    struct PausedStateChanged has copy, drop {
        paused: bool,
    }

    public(friend) fun assert_holder_coin<T0>(arg0: &RewardsConfig) {
        assert!(arg0.holder_coin_type == 0x1::type_name::with_defining_ids<T0>(), 3);
    }

    public(friend) fun assert_not_paused(arg0: &RewardsConfig) {
        assert!(!arg0.paused, 1);
    }

    public fun bps_denominator() : u16 {
        10000
    }

    public fun default_reward_bps(arg0: &RewardsConfig) : u16 {
        arg0.default_reward_bps
    }

    public fun holder_coin_type(arg0: &RewardsConfig) : 0x1::type_name::TypeName {
        arg0.holder_coin_type
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = TreasurerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TreasurerCap>(v2, v0);
        let v3 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<KeeperCap>(v3, v0);
    }

    public fun initialize<T0>(arg0: &AdminCap, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = RewardsConfig{
            id                     : 0x2::object::new(arg2),
            holder_coin_type       : v0,
            next_epoch_no          : 1,
            default_reward_bps     : arg1,
            paused                 : false,
            total_epochs_created   : 0,
            total_epochs_finalized : 0,
        };
        let v2 = ConfigInitialized{
            config_id          : 0x2::object::id<RewardsConfig>(&v1),
            holder_coin_type   : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            default_reward_bps : arg1,
        };
        0x2::event::emit<ConfigInitialized>(v2);
        0x2::transfer::share_object<RewardsConfig>(v1);
    }

    public fun is_paused(arg0: &RewardsConfig) : bool {
        arg0.paused
    }

    public fun next_epoch_no(arg0: &RewardsConfig) : u64 {
        arg0.next_epoch_no
    }

    public(friend) fun record_finalized(arg0: &mut RewardsConfig) {
        arg0.total_epochs_finalized = arg0.total_epochs_finalized + 1;
    }

    public fun set_default_reward_bps(arg0: &AdminCap, arg1: &mut RewardsConfig, arg2: u16) {
        assert!(arg2 <= 10000, 2);
        arg1.default_reward_bps = arg2;
        let v0 = RewardBpsUpdated{
            old_bps : arg1.default_reward_bps,
            new_bps : arg2,
        };
        0x2::event::emit<RewardBpsUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut RewardsConfig, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedStateChanged{paused: arg2};
        0x2::event::emit<PausedStateChanged>(v0);
    }

    public(friend) fun take_next_epoch_no(arg0: &mut RewardsConfig) : u64 {
        let v0 = arg0.next_epoch_no;
        arg0.next_epoch_no = v0 + 1;
        arg0.total_epochs_created = arg0.total_epochs_created + 1;
        v0
    }

    public fun total_epochs_finalized(arg0: &RewardsConfig) : u64 {
        arg0.total_epochs_finalized
    }

    // decompiled from Move bytecode v7
}

