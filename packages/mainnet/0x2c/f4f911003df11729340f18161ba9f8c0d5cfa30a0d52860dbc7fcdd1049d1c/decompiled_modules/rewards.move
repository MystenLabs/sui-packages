module 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards {
    struct RewardRegistry has key {
        id: 0x2::object::UID,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        gangsters: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        game_resources: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        perks: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        hq_aesthetics: 0x1::string::String,
        spin_ticket: u8,
        nft: 0x2::bag::Bag,
    }

    public fun add_gangster_reward(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: u8, arg5: u8, arg6: u8) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg1.id, arg3);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.gangsters, 0x1::string::utf8(b"henchman"), arg4);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.gangsters, 0x1::string::utf8(b"bouncer"), arg5);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.gangsters, 0x1::string::utf8(b"enforcer"), arg6);
    }

    public fun add_nft_reward<T0: store + key>(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: T0) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg1.id, arg3);
        0x2::bag::add<u64, T0>(&mut v0.nft, 0x2::bag::length(&v0.nft), arg4);
    }

    public fun add_perks_reward(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: u8, arg5: u8, arg6: u8) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg1.id, arg3);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.perks, 0x1::string::utf8(b"blackmail_protection"), arg4);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.perks, 0x1::string::utf8(b"boost_production"), arg5);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.perks, 0x1::string::utf8(b"attack_protection"), arg6);
    }

    public fun add_resource_reward(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: u64, arg5: u64, arg6: u64) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg1.id, arg3);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.game_resources, 0x1::string::utf8(b"cash"), arg4);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.game_resources, 0x1::string::utf8(b"dirty_cops"), arg6);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.game_resources, 0x1::string::utf8(b"weapon"), arg5);
    }

    public fun add_spin_ticket_reward(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: u8) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg1.id, arg3).spin_ticket = arg4;
    }

    public fun borrow_game_resources_reward(arg0: &Reward) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        arg0.game_resources
    }

    public fun borrow_gangsters_reward(arg0: &Reward) : 0x2::vec_map::VecMap<0x1::string::String, u8> {
        arg0.gangsters
    }

    public fun borrow_hq_aesthetics_reward(arg0: &Reward) : 0x1::string::String {
        arg0.hq_aesthetics
    }

    public fun borrow_perks_reward(arg0: &Reward) : 0x2::vec_map::VecMap<0x1::string::String, u8> {
        arg0.perks
    }

    public fun borrow_spin_reward(arg0: &Reward) : u8 {
        arg0.spin_ticket
    }

    public(friend) fun borrow_tier_reward(arg0: &RewardRegistry, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: u8) : &Reward {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg2), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        0x2::dynamic_object_field::borrow<u8, Reward>(&arg0.id, arg2)
    }

    public fun create_reward_type(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut RewardRegistry, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        let v0 = Reward{
            id             : 0x2::object::new(arg4),
            gangsters      : 0x2::vec_map::empty<0x1::string::String, u8>(),
            game_resources : 0x2::vec_map::empty<0x1::string::String, u64>(),
            perks          : 0x2::vec_map::empty<0x1::string::String, u8>(),
            hq_aesthetics  : 0x1::string::utf8(b""),
            spin_ticket    : 0,
            nft            : 0x2::bag::new(arg4),
        };
        0x2::dynamic_object_field::add<u8, Reward>(&mut arg2.id, arg3, v0);
    }

    public fun create_spin_reward(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        let v0 = Reward{
            id             : 0x2::object::new(arg4),
            gangsters      : 0x2::vec_map::empty<0x1::string::String, u8>(),
            game_resources : 0x2::vec_map::empty<0x1::string::String, u64>(),
            perks          : 0x2::vec_map::empty<0x1::string::String, u8>(),
            hq_aesthetics  : 0x1::string::utf8(b""),
            spin_ticket    : 0,
            nft            : 0x2::bag::new(arg4),
        };
        0x2::dynamic_object_field::add<u8, Reward>(&mut arg1.id, arg3, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardRegistry>(v0);
    }

    public fun remove_tier_reward(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg2, 1);
        assert!(!0x2::dynamic_object_field::exists_<u8>(&arg1.id, arg3), 0);
        let Reward {
            id             : v0,
            gangsters      : _,
            game_resources : _,
            perks          : _,
            hq_aesthetics  : _,
            spin_ticket    : _,
            nft            : v6,
        } = 0x2::dynamic_object_field::remove<u8, Reward>(&mut arg1.id, arg3);
        0x2::bag::destroy_empty(v6);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

