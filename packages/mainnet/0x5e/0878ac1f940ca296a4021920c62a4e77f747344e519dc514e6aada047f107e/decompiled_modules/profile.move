module 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile {
    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
        total_profiles: u64,
        dev_address: address,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        username: 0x1::string::String,
        bio: 0x1::string::String,
        avatar_blob_id: 0x1::option::Option<0x1::string::String>,
        banner_blob_id: 0x1::option::Option<0x1::string::String>,
        follower_count: u64,
        following_count: u64,
        post_count: u64,
        capy_earned: u64,
        created_at: u64,
        verified_status: u8,
        badge_type: u8,
        staked_capy: 0x2::balance::Balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>,
        stake_epoch: u64,
        rejection_epoch: u64,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        username: 0x1::string::String,
    }

    struct ProfileUpdated has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
    }

    struct VerificationApplied has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        epoch: u64,
    }

    struct VerificationApproved has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        badge_type: u8,
    }

    struct VerificationRejected has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        capy_refunded: u64,
    }

    struct VerificationRevoked has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        reason: vector<u8>,
    }

    struct Unstaked has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct NotableBadgeGranted has copy, drop {
        profile_id: 0x2::object::ID,
        owner: address,
    }

    public(friend) fun add_capy_earned(arg0: &mut Profile, arg1: u64) {
        arg0.capy_earned = arg0.capy_earned + arg1;
    }

    public fun apply_for_verification(arg0: &mut Profile, arg1: 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 2);
        assert!(arg0.verified_status != 2, 5);
        assert!(arg0.verified_status != 1, 6);
        assert!(0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg1) == 100000000000000, 8);
        if (arg0.verified_status == 3) {
            assert!(0x2::tx_context::epoch(arg2) >= arg0.rejection_epoch + 60, 7);
        };
        0x2::balance::join<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg0.staked_capy, 0x2::coin::into_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg1));
        arg0.verified_status = 1;
        arg0.stake_epoch = 0x2::tx_context::epoch(arg2);
        let v1 = VerificationApplied{
            profile_id : 0x2::object::id<Profile>(arg0),
            owner      : v0,
            epoch      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<VerificationApplied>(v1);
    }

    public fun approve_verification(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut Profile) {
        assert!(arg1.verified_status == 1, 9);
        arg1.verified_status = 2;
        arg1.badge_type = 1;
        let v0 = VerificationApproved{
            profile_id : 0x2::object::id<Profile>(arg1),
            owner      : arg1.owner,
            badge_type : 1,
        };
        0x2::event::emit<VerificationApproved>(v0);
    }

    public fun assign_dev_badge(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &ProfileRegistry, arg2: &mut Profile) {
        assert!(arg2.owner == arg1.dev_address, 2);
        arg2.verified_status = 2;
        arg2.badge_type = 3;
    }

    public fun avatar_blob_id(arg0: &Profile) : &0x1::option::Option<0x1::string::String> {
        &arg0.avatar_blob_id
    }

    public fun badge_type(arg0: &Profile) : u8 {
        arg0.badge_type
    }

    public fun banner_blob_id(arg0: &Profile) : &0x1::option::Option<0x1::string::String> {
        &arg0.banner_blob_id
    }

    public fun bio(arg0: &Profile) : &0x1::string::String {
        &arg0.bio
    }

    public fun capy_earned(arg0: &Profile) : u64 {
        arg0.capy_earned
    }

    public fun create_profile(arg0: &mut ProfileRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, v0), 1);
        assert!(0x1::vector::length<u8>(&arg1) <= 32, 3);
        assert!(0x1::vector::length<u8>(&arg2) <= 280, 4);
        let v1 = Profile{
            id              : 0x2::object::new(arg3),
            owner           : v0,
            username        : 0x1::string::utf8(arg1),
            bio             : 0x1::string::utf8(arg2),
            avatar_blob_id  : 0x1::option::none<0x1::string::String>(),
            banner_blob_id  : 0x1::option::none<0x1::string::String>(),
            follower_count  : 0,
            following_count : 0,
            post_count      : 0,
            capy_earned     : 0,
            created_at      : 0x2::tx_context::epoch_timestamp_ms(arg3),
            verified_status : 0,
            badge_type      : 0,
            staked_capy     : 0x2::balance::zero<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(),
            stake_epoch     : 0,
            rejection_epoch : 0,
        };
        let v2 = 0x2::object::id<Profile>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, v0, v2);
        arg0.total_profiles = arg0.total_profiles + 1;
        let v3 = ProfileCreated{
            profile_id : v2,
            owner      : v0,
            username   : v1.username,
        };
        0x2::event::emit<ProfileCreated>(v3);
        0x2::transfer::share_object<Profile>(v1);
    }

    public fun created_at(arg0: &Profile) : u64 {
        arg0.created_at
    }

    public(friend) fun decrement_follower_count(arg0: &mut Profile) {
        if (arg0.follower_count > 0) {
            arg0.follower_count = arg0.follower_count - 1;
        };
    }

    public(friend) fun decrement_following_count(arg0: &mut Profile) {
        if (arg0.following_count > 0) {
            arg0.following_count = arg0.following_count - 1;
        };
    }

    public fun dev_address(arg0: &ProfileRegistry) : address {
        arg0.dev_address
    }

    public fun follower_count(arg0: &Profile) : u64 {
        arg0.follower_count
    }

    public fun following_count(arg0: &Profile) : u64 {
        arg0.following_count
    }

    public fun get_profile_id(arg0: &ProfileRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.profiles, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun grant_notable_badge(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut Profile) {
        arg1.verified_status = 2;
        arg1.badge_type = 2;
        let v0 = NotableBadgeGranted{
            profile_id : 0x2::object::id<Profile>(arg1),
            owner      : arg1.owner,
        };
        0x2::event::emit<NotableBadgeGranted>(v0);
    }

    public(friend) fun increment_follower_count(arg0: &mut Profile) {
        arg0.follower_count = arg0.follower_count + 1;
    }

    public(friend) fun increment_following_count(arg0: &mut Profile) {
        arg0.following_count = arg0.following_count + 1;
    }

    public(friend) fun increment_post_count(arg0: &mut Profile) {
        arg0.post_count = arg0.post_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileRegistry{
            id             : 0x2::object::new(arg0),
            profiles       : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_profiles : 0,
            dev_address    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<ProfileRegistry>(v0);
    }

    public fun is_pending(arg0: &Profile) : bool {
        arg0.verified_status == 1
    }

    public fun is_verified(arg0: &Profile) : bool {
        arg0.verified_status == 2
    }

    public fun locked_amount(arg0: &Profile) : u64 {
        0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg0.staked_capy)
    }

    public fun owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun post_count(arg0: &Profile) : u64 {
        arg0.post_count
    }

    public fun reject_verification(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.verified_status == 1, 9);
        let v0 = 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg1.staked_capy);
        let v1 = if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg1.staked_capy, v0), arg2), arg1.owner);
            v0
        } else {
            0
        };
        arg1.verified_status = 3;
        arg1.badge_type = 0;
        arg1.rejection_epoch = 0x2::tx_context::epoch(arg2);
        let v2 = VerificationRejected{
            profile_id    : 0x2::object::id<Profile>(arg1),
            owner         : arg1.owner,
            capy_refunded : v1,
        };
        0x2::event::emit<VerificationRejected>(v2);
    }

    public fun rejection_epoch(arg0: &Profile) : u64 {
        arg0.rejection_epoch
    }

    public fun revoke_and_refund_verification(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg1.staked_capy);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg1.staked_capy, v0), arg2), arg1.owner);
        };
        arg1.verified_status = 0;
        arg1.badge_type = 0;
        let v1 = VerificationRevoked{
            profile_id : 0x2::object::id<Profile>(arg1),
            owner      : arg1.owner,
            reason     : b"revoked_and_refunded",
        };
        0x2::event::emit<VerificationRevoked>(v1);
    }

    public fun revoke_verification(arg0: &0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::AdminCap, arg1: &mut Profile, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.verified_status = 0;
        arg1.badge_type = 0;
        let v0 = VerificationRevoked{
            profile_id : 0x2::object::id<Profile>(arg1),
            owner      : arg1.owner,
            reason     : arg2,
        };
        0x2::event::emit<VerificationRevoked>(v0);
    }

    public fun set_avatar(arg0: &mut Profile, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.avatar_blob_id = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg1));
    }

    public fun set_banner(arg0: &mut Profile, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.banner_blob_id = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg1));
    }

    public fun stake_epoch(arg0: &Profile) : u64 {
        arg0.stake_epoch
    }

    public fun staked_amount(arg0: &Profile) : u64 {
        0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg0.staked_capy)
    }

    public fun total_profiles(arg0: &ProfileRegistry) : u64 {
        arg0.total_profiles
    }

    public fun unstake_verification(arg0: &mut Profile, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        assert!(arg0.verified_status == 1, 9);
        let v0 = 0x2::balance::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg0.staked_capy);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(0x2::coin::from_balance<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(0x2::balance::split<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&mut arg0.staked_capy, v0), arg1), arg0.owner);
        };
        arg0.verified_status = 0;
        arg0.badge_type = 0;
        let v1 = Unstaked{
            profile_id : 0x2::object::id<Profile>(arg0),
            owner      : arg0.owner,
            amount     : v0,
        };
        0x2::event::emit<Unstaked>(v1);
    }

    public fun update_profile(arg0: &mut Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(0x1::vector::length<u8>(&arg1) <= 32, 3);
        assert!(0x1::vector::length<u8>(&arg2) <= 280, 4);
        arg0.username = 0x1::string::utf8(arg1);
        arg0.bio = 0x1::string::utf8(arg2);
        let v0 = ProfileUpdated{
            profile_id : 0x2::object::id<Profile>(arg0),
            owner      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProfileUpdated>(v0);
    }

    public fun username(arg0: &Profile) : &0x1::string::String {
        &arg0.username
    }

    public fun verification_fee() : u64 {
        100000000000000
    }

    public fun verified_status(arg0: &Profile) : u8 {
        arg0.verified_status
    }

    public fun wallet_tier(arg0: u64) : u8 {
        let v0 = arg0 / 1000000000;
        if (v0 >= 10000000) {
            7
        } else if (v0 >= 1000000) {
            6
        } else if (v0 >= 500000) {
            5
        } else if (v0 >= 100000) {
            4
        } else if (v0 >= 50000) {
            3
        } else if (v0 >= 10000) {
            2
        } else if (v0 >= 1000) {
            1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

