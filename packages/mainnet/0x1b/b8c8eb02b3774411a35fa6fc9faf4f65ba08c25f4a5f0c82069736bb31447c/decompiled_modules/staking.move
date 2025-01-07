module 0x1bb8c8eb02b3774411a35fa6fc9faf4f65ba08c25f4a5f0c82069736bb31447c::staking {
    struct STAKING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingHub has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        staked: u64,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        fee_for_stake: u64,
        fee_for_unstake: u64,
        points_per_minute: u64,
        staked: u64,
    }

    struct StakingTicket has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        nft_id: 0x2::object::ID,
        start_time: u64,
    }

    struct RewardInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        claimed: u64,
        supply: 0x1::option::Option<u64>,
        per_address: 0x1::option::Option<u64>,
        points: u64,
    }

    struct Reward has key {
        id: 0x2::object::UID,
        reward_info_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Staked has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct Unstaked has copy, drop {
        nft_id: 0x2::object::ID,
        points: u64,
    }

    struct PointsClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        points: u64,
    }

    struct RewardClaimed has copy, drop {
        reward_info_id: 0x2::object::ID,
    }

    fun add_points(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        let v0 = 0;
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(arg0, arg1);
            0x2::table::remove<address, u64>(arg0, arg1);
        };
        0x2::table::add<address, u64>(arg0, arg1, v0 + arg2);
    }

    entry fun add_pool_reward<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, rewards_key())) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<0x2::object::ID, RewardInfo>>(&mut arg1.id, rewards_key(), 0x2::table::new<0x2::object::ID, RewardInfo>(arg8));
        };
        let v0 = if (arg5 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg5)
        };
        let v1 = if (arg6 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg6)
        };
        let v2 = RewardInfo{
            id          : 0x2::object::new(arg8),
            name        : arg2,
            description : arg3,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            claimed     : 0,
            supply      : v0,
            per_address : v1,
            points      : arg7,
        };
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<address, u64>>(&mut v2.id, claimers_key(), 0x2::table::new<address, u64>(arg8));
        0x2::table::add<0x2::object::ID, RewardInfo>(borrow_pool_rewards_mut<T0>(arg1), 0x2::object::id<RewardInfo>(&v2), v2);
    }

    public fun borrow_hub_points(arg0: &StakingHub) : &0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::table::Table<address, u64>>(&arg0.id, points_key())
    }

    fun borrow_hub_points_mut(arg0: &mut StakingHub) : &mut 0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, u64>>(&mut arg0.id, points_key())
    }

    public fun borrow_hub_pools(arg0: &StakingHub) : &0x2::table::Table<0x2::object::ID, bool> {
        0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::table::Table<0x2::object::ID, bool>>(&arg0.id, pools_key())
    }

    fun borrow_hub_pools_mut(arg0: &mut StakingHub) : &mut 0x2::table::Table<0x2::object::ID, bool> {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg0.id, pools_key())
    }

    public fun borrow_pool_points<T0>(arg0: &StakingPool<T0>) : &0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::table::Table<address, u64>>(&arg0.id, points_key())
    }

    fun borrow_pool_points_mut<T0>(arg0: &mut StakingPool<T0>) : &mut 0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, u64>>(&mut arg0.id, points_key())
    }

    public fun borrow_pool_rewards<T0>(arg0: &StakingPool<T0>) : &0x2::table::Table<0x2::object::ID, RewardInfo> {
        0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::table::Table<0x2::object::ID, RewardInfo>>(&arg0.id, rewards_key())
    }

    fun borrow_pool_rewards_mut<T0>(arg0: &mut StakingPool<T0>) : &mut 0x2::table::Table<0x2::object::ID, RewardInfo> {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<0x2::object::ID, RewardInfo>>(&mut arg0.id, rewards_key())
    }

    public fun borrow_reward_claimers(arg0: &RewardInfo) : &0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow<0x1::string::String, 0x2::table::Table<address, u64>>(&arg0.id, claimers_key())
    }

    fun borrow_reward_claimers_mut(arg0: &mut RewardInfo) : &mut 0x2::table::Table<address, u64> {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::table::Table<address, u64>>(&mut arg0.id, claimers_key())
    }

    fun calculate_points(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (arg1 - arg0) / 60000 * arg2
    }

    entry fun claim_points<T0: store + key>(arg0: &mut StakingTicket, arg1: &mut StakingHub, arg2: &mut StakingPool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::clock::timestamp_ms(arg3) - arg0.start_time) / 60000 * arg2.points_per_minute;
        if (v0 > 0) {
            let v1 = borrow_hub_points_mut(arg1);
            add_points(v1, 0x2::tx_context::sender(arg4), v0);
            let v2 = borrow_pool_points_mut<T0>(arg2);
            add_points(v2, 0x2::tx_context::sender(arg4), v0);
        };
        let v3 = PointsClaimed{
            nft_id : arg0.nft_id,
            points : v0,
        };
        0x2::event::emit<PointsClaimed>(v3);
        arg0.start_time = 0x2::clock::timestamp_ms(arg3);
    }

    entry fun claim_reward<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pool_rewards_mut<T0>(arg0);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, RewardInfo>(v0, arg1);
        let v2 = v1.points;
        let v3 = 0x1::option::is_some<u64>(&v1.per_address);
        v1.claimed = v1.claimed + 1;
        if (0x1::option::is_some<u64>(&v1.supply)) {
            assert!(v1.claimed <= *0x1::option::borrow<u64>(&v1.supply), 3);
        };
        let v4 = borrow_reward_claimers_mut(v1);
        if (!0x2::table::contains<address, u64>(v4, 0x2::tx_context::sender(arg2))) {
            0x2::table::add<address, u64>(v4, 0x2::tx_context::sender(arg2), 0);
        };
        let v5 = 0x2::table::borrow_mut<address, u64>(v4, 0x2::tx_context::sender(arg2));
        *v5 = *v5 + 1;
        if (v3) {
            assert!(*v5 <= *0x1::option::borrow<u64>(&v1.per_address), 4);
        };
        let v6 = Reward{
            id             : 0x2::object::new(arg2),
            reward_info_id : arg1,
            name           : v1.name,
            description    : v1.description,
            url            : v1.url,
        };
        let v7 = borrow_pool_points_mut<T0>(arg0);
        sub_points(v7, 0x2::tx_context::sender(arg2), v2);
        let v8 = RewardClaimed{reward_info_id: arg1};
        0x2::event::emit<RewardClaimed>(v8);
        0x2::transfer::transfer<Reward>(v6, 0x2::tx_context::sender(arg2));
    }

    public fun claimers_key() : 0x1::string::String {
        0x1::string::utf8(b"claimers")
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: &mut StakingHub, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id                : 0x2::object::new(arg3),
            name              : arg2,
            fee_for_stake     : 1000000000,
            fee_for_unstake   : 3000000000,
            points_per_minute : 1,
            staked            : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<address, u64>>(&mut v0.id, points_key(), 0x2::table::new<address, u64>(arg3));
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<0x2::object::ID, RewardInfo>>(&mut v0.id, rewards_key(), 0x2::table::new<0x2::object::ID, RewardInfo>(arg3));
        0x2::table::add<0x2::object::ID, bool>(borrow_hub_pools_mut(arg1), 0x2::object::id<StakingPool<T0>>(&v0), true);
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public fun get_address_hub_points<T0>(arg0: &StakingHub, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(borrow_hub_points(arg0), arg1)
    }

    public fun get_address_pool_points<T0>(arg0: &StakingPool<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(borrow_pool_points<T0>(arg0), arg1)
    }

    fun handle_payment(arg0: &mut StakingHub, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3));
        0x2::pay::keep<0x2::sui::SUI>(arg1, arg3);
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::package::claim<STAKING>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://www.holasui.xyz"));
        let v6 = 0x2::display::new_with_fields<StakingTicket>(&v1, v2, v4, arg1);
        0x2::display::update_version<StakingTicket>(&mut v6);
        update_reward_display(&v0, &v1, arg1);
        let v7 = StakingHub{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            staked  : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<address, u64>>(&mut v7.id, points_key(), 0x2::table::new<address, u64>(arg1));
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::table::Table<0x2::object::ID, bool>>(&mut v7.id, pools_key(), 0x2::table::new<0x2::object::ID, bool>(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<StakingTicket>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingHub>(v7);
    }

    public fun points_key() : 0x1::string::String {
        0x1::string::utf8(b"points")
    }

    public fun pools_key() : 0x1::string::String {
        0x1::string::utf8(b"pools")
    }

    public entry fun remove_pool_reward<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: 0x2::object::ID) {
        let RewardInfo {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            claimed     : _,
            supply      : _,
            per_address : _,
            points      : _,
        } = 0x2::table::remove<0x2::object::ID, RewardInfo>(borrow_pool_rewards_mut<T0>(arg1), arg2);
        0x2::object::delete(v0);
    }

    public fun rewards_key() : 0x1::string::String {
        0x1::string::utf8(b"rewards")
    }

    public entry fun set_fee_for_stake<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.fee_for_stake = arg2;
    }

    public entry fun set_fee_for_unstake<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.fee_for_unstake = arg2;
    }

    public entry fun set_points_per_minute<T0>(arg0: &AdminCap, arg1: &mut StakingPool<T0>, arg2: u64) {
        arg1.points_per_minute = arg2;
    }

    public entry fun stake<T0: store + key>(arg0: T0, arg1: &mut StakingHub, arg2: &mut StakingPool<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        handle_payment(arg1, arg3, arg2.fee_for_stake, arg5);
        let v0 = 0x2::object::id<T0>(&arg0);
        let v1 = arg2.name;
        0x1::string::append_utf8(&mut v1, b" ");
        0x1::string::append_utf8(&mut v1, b"Staking Ticket");
        let v2 = StakingTicket{
            id         : 0x2::object::new(arg5),
            name       : v1,
            url        : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmQiqGdJJb16QHaLPXDY6VZGqiDpehaSviU6vZQSvKdhNd"),
            nft_id     : v0,
            start_time : 0x2::clock::timestamp_ms(arg4),
        };
        arg1.staked = arg1.staked + 1;
        arg2.staked = arg2.staked + 1;
        let v3 = Staked{nft_id: v0};
        0x2::event::emit<Staked>(v3);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg2.id, v0, arg0);
        0x2::transfer::transfer<StakingTicket>(v2, 0x2::tx_context::sender(arg5));
    }

    fun sub_points(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(arg0, arg1) && *0x2::table::borrow<address, u64>(arg0, arg1) >= arg2, 2);
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        *v0 = *v0 - arg2;
    }

    public entry fun unstake<T0: store + key>(arg0: StakingTicket, arg1: &mut StakingHub, arg2: &mut StakingPool<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        handle_payment(arg1, arg3, arg2.fee_for_unstake, arg5);
        let StakingTicket {
            id         : v0,
            name       : _,
            url        : _,
            nft_id     : v3,
            start_time : v4,
        } = arg0;
        let v5 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg2.id, v3);
        let v6 = (0x2::clock::timestamp_ms(arg4) - v4) / 60000 * arg2.points_per_minute;
        if (v6 > 0) {
            let v7 = borrow_hub_points_mut(arg1);
            add_points(v7, 0x2::tx_context::sender(arg5), v6);
            let v8 = borrow_pool_points_mut<T0>(arg2);
            add_points(v8, 0x2::tx_context::sender(arg5), v6);
        };
        let v9 = if (arg1.staked > 0) {
            arg1.staked - 1
        } else {
            0
        };
        arg1.staked = v9;
        let v10 = if (arg2.staked > 0) {
            arg2.staked - 1
        } else {
            0
        };
        arg2.staked = v10;
        let v11 = Unstaked{
            nft_id : v3,
            points : v6,
        };
        0x2::event::emit<Unstaked>(v11);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v5, 0x2::tx_context::sender(arg5));
    }

    entry fun update_reward_display(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.holasui.app"));
        let v4 = 0x2::display::new_with_fields<Reward>(arg1, v0, v2, arg2);
        0x2::display::update_version<Reward>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Reward>>(v4, 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut StakingHub, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

