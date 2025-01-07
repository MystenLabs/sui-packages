module 0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    struct BirdAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardTreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserReward has drop, store {
        owner: address,
        pool: address,
        amount: u64,
        nonce: u128,
    }

    struct RewardClaimedEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
        nonce: u128,
    }

    struct RewardDepositEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardEmergencyWithdrawEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        active: bool,
        coins: 0x2::coin::Coin<T0>,
        reward_limit: u64,
    }

    struct EggBreakEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct CheckinEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct Checkin has drop, store {
        amount: u64,
        last_time: u64,
    }

    struct BreakEgg has drop, store {
        amount: u64,
        last_time: u64,
    }

    struct BirdArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        last_time: u64,
        checkin: Checkin,
        break_egg: BreakEgg,
        nonce: u128,
    }

    struct BirdAction {
        type: u8,
        owner: address,
        amount: u64,
        nonce: u128,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        total_break: u128,
        total_checkin: u128,
        validator: 0x1::option::Option<vector<u8>>,
        validator_fee_enabled: bool,
        validator_fee: u64,
    }

    struct TransporterVault has store, key {
        id: 0x2::object::UID,
        admin_cap: 0x1::option::Option<BirdAdminCap>,
        new_owner: 0x1::option::Option<address>,
        og_owner: 0x1::option::Option<address>,
        treasure_cap: 0x1::option::Option<RewardTreasureCap>,
        new_treasure_owner: 0x1::option::Option<address>,
        og_treasure_owner: 0x1::option::Option<address>,
    }

    struct BirdReg has store, key {
        id: 0x2::object::UID,
        egg_regs: 0x2::table::Table<address, bool>,
    }

    public fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 8000);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg2.validator), &arg1), 8000);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        let v2 = 0x2::bcs::peel_u128(&mut v0);
        assert!(v1 <= 1, 8004);
        assert!(v2 > arg3.nonce, 8003);
        arg3.nonce = v2;
        if (v1 == 1) {
            arg2.total_checkin = arg2.total_checkin + 1;
            checkIn(arg3, 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), arg4, arg6);
        } else if (v1 == 0) {
            arg2.total_break = arg2.total_break + 1;
            breakEgg(arg3, 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), arg4, arg6);
        };
    }

    fun breakEgg(arg0: &mut BirdArchieve, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 == 0x2::tx_context::sender(arg4), 8001);
        assert!(arg2 > 0, 8002);
        arg0.break_egg.amount = arg0.break_egg.amount + arg2;
        arg0.break_egg.last_time = 0x2::clock::timestamp_ms(arg3);
        let v0 = EggBreakEvent{
            owner     : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EggBreakEvent>(v0);
    }

    fun checkIn(arg0: &mut BirdArchieve, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 == 0x2::tx_context::sender(arg4), 8001);
        assert!(arg2 > 0, 8002);
        arg0.break_egg.amount = arg0.break_egg.amount + arg2;
        let v0 = CheckinEvent{
            owner     : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CheckinEvent>(v0);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut RewardPool<T0>, arg3: &mut BirdStore, arg4: &mut BirdArchieve, arg5: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg3.validator), 8000);
        assert!(arg2.active, 8009);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg3.validator), &arg1), 8000);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        assert!(0x2::object::id_address<RewardPool<T0>>(arg2) == 0x2::bcs::peel_address(&mut v0), 8011);
        assert!(v3 > arg4.nonce, 8003);
        assert!(arg2.reward_limit <= 0 || arg2.reward_limit >= v2, 8010);
        arg4.nonce = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.coins, v2, arg7), v1);
        let v4 = RewardClaimedEvent{
            owner     : v1,
            amount    : v2,
            timestamp : 0x2::clock::timestamp_ms(arg6),
            nonce     : v3,
        };
        0x2::event::emit<RewardClaimedEvent>(v4);
    }

    public fun claim_admin(arg0: &mut TransporterVault, arg1: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg1, 1);
        assert!(0x1::option::is_some<address>(&arg0.new_owner) && *0x1::option::borrow<address>(&arg0.new_owner) == 0x2::tx_context::sender(arg2), 8008);
        0x2::transfer::transfer<BirdAdminCap>(0x1::option::extract<BirdAdminCap>(&mut arg0.admin_cap), 0x2::tx_context::sender(arg2));
        0x1::option::extract<address>(&mut arg0.og_owner);
        0x1::option::extract<address>(&mut arg0.new_owner);
    }

    public fun claim_treasure(arg0: &mut TransporterVault, arg1: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg1, 1);
        assert!(0x1::option::is_some<address>(&arg0.new_treasure_owner) && *0x1::option::borrow<address>(&arg0.new_treasure_owner) == 0x2::tx_context::sender(arg2), 8008);
        0x2::transfer::transfer<RewardTreasureCap>(0x1::option::extract<RewardTreasureCap>(&mut arg0.treasure_cap), 0x2::tx_context::sender(arg2));
        0x1::option::extract<address>(&mut arg0.og_treasure_owner);
        0x1::option::extract<address>(&mut arg0.new_treasure_owner);
    }

    public fun configRewardPool<T0>(arg0: &BirdAdminCap, arg1: &mut RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg4, 1);
        arg1.active = arg2;
        arg1.reward_limit = arg3;
    }

    public fun createRewardPool<T0>(arg0: &BirdAdminCap, arg1: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg1, 1);
        let v0 = RewardPool<T0>{
            id           : 0x2::object::new(arg2),
            active       : true,
            coins        : 0x2::coin::zero<T0>(arg2),
            reward_limit : 0,
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>, arg2: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg2, 1);
        0x2::coin::join<T0>(&mut arg1.coins, arg0);
        let v0 = RewardDepositEvent{
            owner     : 0x2::tx_context::sender(arg4),
            amount    : 0x2::coin::value<T0>(&arg0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardDepositEvent>(v0);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &RewardTreasureCap, arg1: &mut RewardPool<T0>, arg2: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg2, 1);
        let v0 = 0x2::coin::value<T0>(&arg1.coins);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.coins, v0, arg4), 0x2::tx_context::sender(arg4));
        let v1 = RewardEmergencyWithdrawEvent{
            owner     : 0x2::tx_context::sender(arg4),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardEmergencyWithdrawEvent>(v1);
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BirdAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = RewardTreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<RewardTreasureCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = BirdStore{
            id                    : 0x2::object::new(arg1),
            total_break           : 0,
            total_checkin         : 0,
            validator             : 0x1::option::none<vector<u8>>(),
            validator_fee_enabled : false,
            validator_fee         : 0,
        };
        0x2::transfer::share_object<BirdStore>(v2);
        let v3 = BirdReg{
            id       : 0x2::object::new(arg1),
            egg_regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<BirdReg>(v3);
        let v4 = TransporterVault{
            id                 : 0x2::object::new(arg1),
            admin_cap          : 0x1::option::none<BirdAdminCap>(),
            new_owner          : 0x1::option::none<address>(),
            og_owner           : 0x1::option::none<address>(),
            treasure_cap       : 0x1::option::none<RewardTreasureCap>(),
            new_treasure_owner : 0x1::option::none<address>(),
            og_treasure_owner  : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<TransporterVault>(v4);
    }

    public fun register(arg0: &mut BirdReg, arg1: &0x2::clock::Clock, arg2: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg2, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.egg_regs, 0x2::tx_context::sender(arg3)), 8005);
        let v0 = Checkin{
            amount    : 0,
            last_time : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = BreakEgg{
            amount    : 0,
            last_time : 0x2::clock::timestamp_ms(arg1),
        };
        let v2 = BirdArchieve{
            id        : 0x2::object::new(arg3),
            owner     : 0x2::tx_context::sender(arg3),
            last_time : 0x2::clock::timestamp_ms(arg1),
            checkin   : v0,
            break_egg : v1,
            nonce     : 0,
        };
        0x2::transfer::public_transfer<BirdArchieve>(v2, 0x2::tx_context::sender(arg3));
        0x2::table::add<address, bool>(&mut arg0.egg_regs, 0x2::tx_context::sender(arg3), true);
    }

    public fun revoke_admin(arg0: &mut TransporterVault, arg1: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg1, 1);
        assert!(0x1::option::is_some<address>(&arg0.og_owner) && *0x1::option::borrow<address>(&arg0.og_owner) == 0x2::tx_context::sender(arg2), 8008);
        0x2::transfer::transfer<BirdAdminCap>(0x1::option::extract<BirdAdminCap>(&mut arg0.admin_cap), 0x2::tx_context::sender(arg2));
        0x1::option::extract<address>(&mut arg0.og_owner);
        0x1::option::extract<address>(&mut arg0.new_owner);
    }

    public fun revoke_treasure(arg0: &mut TransporterVault, arg1: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg1, 1);
        assert!(0x1::option::is_some<address>(&arg0.og_treasure_owner) && *0x1::option::borrow<address>(&arg0.og_treasure_owner) == 0x2::tx_context::sender(arg2), 8008);
        0x2::transfer::transfer<RewardTreasureCap>(0x1::option::extract<RewardTreasureCap>(&mut arg0.treasure_cap), 0x2::tx_context::sender(arg2));
        0x1::option::extract<address>(&mut arg0.og_treasure_owner);
        0x1::option::extract<address>(&mut arg0.new_treasure_owner);
    }

    public fun transfer_admin(arg0: BirdAdminCap, arg1: address, arg2: &mut TransporterVault, arg3: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg3, 1);
        0x1::option::fill<BirdAdminCap>(&mut arg2.admin_cap, arg0);
        0x1::option::fill<address>(&mut arg2.new_owner, arg1);
        0x1::option::fill<address>(&mut arg2.og_owner, 0x2::tx_context::sender(arg4));
    }

    public fun transfer_treasure(arg0: RewardTreasureCap, arg1: address, arg2: &mut TransporterVault, arg3: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg3, 1);
        0x1::option::fill<RewardTreasureCap>(&mut arg2.treasure_cap, arg0);
        0x1::option::fill<address>(&mut arg2.new_treasure_owner, arg1);
        0x1::option::fill<address>(&mut arg2.og_treasure_owner, 0x2::tx_context::sender(arg4));
    }

    public fun update_validator(arg0: &BirdAdminCap, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::Version) {
        0x5adb22ae1a7255cd74cd6bca96c626a37e9a592b8c569155bdb01b2462a95818::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    // decompiled from Move bytecode v6
}

