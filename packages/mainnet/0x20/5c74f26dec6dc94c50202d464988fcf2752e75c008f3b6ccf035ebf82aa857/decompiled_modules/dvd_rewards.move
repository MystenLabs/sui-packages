module 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards {
    struct RewardRegistry has key {
        id: 0x2::object::UID,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        gangsters: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        game_resources: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        perks: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        physical_items: vector<0x1::string::String>,
        hq_aesthetics: 0x1::string::String,
        spin_ticket: u8,
        nft: 0x2::bag::Bag,
    }

    struct SpinReward has store, key {
        id: 0x2::object::UID,
        reward: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun add_gangster_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg8), arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.gangsters, 0x1::string::utf8(b"henchman"), arg5);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.gangsters, 0x1::string::utf8(b"bouncer"), arg6);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.gangsters, 0x1::string::utf8(b"enforcer"), arg7);
    }

    public fun add_hq_aesthetics_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4).hq_aesthetics = arg5;
    }

    public fun add_nft_reward<T0: store + key>(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: T0, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4);
        0x2::bag::add<u64, T0>(&mut v0.nft, 0x2::bag::length(&v0.nft), arg5);
    }

    public fun add_perks_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: u8, arg6: u8, arg7: u8, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg8), arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.perks, 0x1::string::utf8(b"blackmail_protection"), arg5);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.perks, 0x1::string::utf8(b"boost_production"), arg6);
        0x2::vec_map::insert<0x1::string::String, u8>(&mut v0.perks, 0x1::string::utf8(b"attack_protection"), arg7);
    }

    public fun add_physical_items_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: vector<0x1::string::String>, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4).physical_items = arg5;
    }

    public fun add_resource_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg8), arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.game_resources, 0x1::string::utf8(b"cash"), arg5);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.game_resources, 0x1::string::utf8(b"dirty_cops"), arg7);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.game_resources, 0x1::string::utf8(b"weapon"), arg6);
    }

    public fun add_spin_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut RewardRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg3.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg11), arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SpinReward>(&mut arg3.id, arg4);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.reward, 0x1::string::utf8(b"henchman"), arg5);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.reward, 0x1::string::utf8(b"enforcer"), arg6);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.reward, 0x1::string::utf8(b"cash"), arg7);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.reward, 0x1::string::utf8(b"weapon"), arg8);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.reward, 0x1::string::utf8(b"dirty_cop"), arg9);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0.reward, 0x1::string::utf8(b"bouncer"), arg10);
    }

    public fun add_spin_ticket_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        0x2::dynamic_object_field::borrow_mut<u8, Reward>(&mut arg2.id, arg4).spin_ticket = arg5;
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

    public fun borrow_physical_items_reward(arg0: &Reward) : vector<0x1::string::String> {
        arg0.physical_items
    }

    public fun borrow_spin_count_reward(arg0: &Reward) : u8 {
        arg0.spin_ticket
    }

    public(friend) fun borrow_spin_reward(arg0: &RewardRegistry, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: 0x1::string::String) : &SpinReward {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg2), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        0x2::dynamic_object_field::borrow<0x1::string::String, SpinReward>(&arg0.id, arg2)
    }

    public fun borrow_spin_reward_value_by_idx(arg0: &SpinReward, arg1: u64) : (0x1::string::String, u64) {
        let (v0, v1) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, u64>(&arg0.reward, arg1);
        (*v0, *v1)
    }

    public(friend) fun borrow_tier_reward(arg0: &RewardRegistry, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: u8) : &Reward {
        assert!(0x2::dynamic_object_field::exists_<u8>(&arg0.id, arg2), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        0x2::dynamic_object_field::borrow<u8, Reward>(&arg0.id, arg2)
    }

    public fun create_spin_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut RewardRegistry, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg3.id, arg4), 0);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg5), arg1);
        let v0 = SpinReward{
            id     : 0x2::object::new(arg5),
            reward : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, SpinReward>(&mut arg3.id, arg4, v0);
    }

    public fun create_tier_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut RewardRegistry, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<u8>(&arg3.id, arg4), 0);
        assert!(arg4 <= 6, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg5), arg1);
        let v0 = Reward{
            id             : 0x2::object::new(arg5),
            gangsters      : 0x2::vec_map::empty<0x1::string::String, u8>(),
            game_resources : 0x2::vec_map::empty<0x1::string::String, u64>(),
            perks          : 0x2::vec_map::empty<0x1::string::String, u8>(),
            physical_items : 0x1::vector::empty<0x1::string::String>(),
            hq_aesthetics  : 0x1::string::utf8(b""),
            spin_ticket    : 0,
            nft            : 0x2::bag::new(arg5),
        };
        0x2::dynamic_object_field::add<u8, Reward>(&mut arg3.id, arg4, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardRegistry>(v0);
    }

    public fun remove_tier_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &mut RewardRegistry, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg3, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg5), arg1);
        assert!(!0x2::dynamic_object_field::exists_<u8>(&arg2.id, arg4), 1);
        let Reward {
            id             : v0,
            gangsters      : _,
            game_resources : _,
            perks          : _,
            physical_items : _,
            hq_aesthetics  : _,
            spin_ticket    : _,
            nft            : v7,
        } = 0x2::dynamic_object_field::remove<u8, Reward>(&mut arg2.id, arg4);
        0x2::bag::destroy_empty(v7);
        0x2::object::delete(v0);
    }

    public fun update_spin_reward(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut RewardRegistry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg3.id, arg4), 1);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg7), arg1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, SpinReward>(&mut arg3.id, arg4);
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(&v0.reward, &arg5), 1);
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.reward, &arg5) = arg6;
    }

    // decompiled from Move bytecode v6
}

