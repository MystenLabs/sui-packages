module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::pixel {
    struct PixelGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        listing_fee: u64,
        decorate_fee: u64,
        migrate_fee: u64,
        buy_fee_rate: u64,
        sell_fee_rate: u64,
        stake_fee_rate: u64,
        alliance_fee_rate: u64,
        target_supply_threshold: u64,
        virtual_sui_amount: u64,
        pixel_list: 0x2::bag::Bag,
        pixel_index_list: 0x2::vec_map::VecMap<u64, 0x1::string::String>,
        pixel_balance_list: 0x2::table::Table<0x1::string::String, PixelBalance>,
    }

    struct Pixel<phantom T0> has store {
        version: u64,
        index: u64,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
        creator: address,
        is_active: bool,
        is_destroy: bool,
        token_balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_reserve: 0x2::balance::Balance<T0>,
        target_supply_threshold: u64,
        virtual_sui_amount: u64,
        stake_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        stake_amount: u64,
        last_fee_index: u64,
        stake_list: 0x2::table::Table<address, UserStake<T0>>,
        stake_address_list: vector<address>,
        leader_address: 0x1::option::Option<address>,
        leader_stake_amount: u64,
        alliance_list: 0x2::vec_map::VecMap<u64, 0x1::string::String>,
        decorate_address: 0x1::option::Option<address>,
    }

    struct PixelBalance has store {
        is_destroy: bool,
        sui_amount: u64,
        token_amount: u64,
        stake_amount: u64,
    }

    struct UserStake<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        stake_balance: 0x2::balance::Balance<T0>,
        fee_index: u64,
        rewards: u64,
    }

    public(friend) fun buy<T0>(arg0: &mut PixelGlobal, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = arg0.buy_fee_rate;
        let v2 = arg0.stake_fee_rate;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        let v5 = 0x2::bag::borrow<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0);
        let v6 = v5.name;
        let v7 = v5.symbol;
        assert!(v5.is_active == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_inactive());
        let v8 = get_swap_fees(v4, v1);
        let v9 = get_swap_fees(v4, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v8));
        let v10 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v10.stake_fee, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v9));
        v10.last_fee_index = get_last_fee_index(v10.last_fee_index, v9, v10.stake_amount);
        let (v11, v12) = get_pixel_balance_values<T0>(v10);
        let v13 = get_out_amount(v4 - v8 - v9, v11 + v10.virtual_sui_amount, v12);
        0x2::balance::join<0x2::sui::SUI>(&mut v10.sui_balance, v3);
        let (v14, v15) = get_pixel_balance_values<T0>(v10);
        assert!(v14 > 0 && v15 > 0 && v15 >= v13, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_swap_amount());
        if (v15 <= v10.target_supply_threshold) {
            v10.is_active = false;
            0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::migrate_pending_event(v6, v7, v0, v14, v15);
        };
        let v16 = 0x2::coin::take<T0>(&mut v10.token_balance, v13, arg2);
        assert!(0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v0), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_balance_not_exist());
        let v17 = 0x2::table::borrow_mut<0x1::string::String, PixelBalance>(&mut arg0.pixel_balance_list, v0);
        v17.sui_amount = v14;
        v17.token_amount = v15;
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::swap_event(true, 0x2::tx_context::sender(arg2), v6, v7, v0, v4, v13, v1, v2, v8, v9);
        v16
    }

    fun check_leader<T0>(arg0: &mut PixelGlobal, arg1: &0x2::tx_context::TxContext) {
        assert!(get_pixel_leader<T0>(arg0) != 0x1::option::some<address>(0x2::tx_context::sender(arg1)), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::you_are_not_leader());
    }

    public fun claim_stake_rewards<T0>(arg0: &mut PixelGlobal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = get_mut_pixel<T0>(arg0);
        assert!(v0.is_active == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_inactive());
        let v1 = v0.last_fee_index;
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(is_user_staked<T0>(v0, v2) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::user_stake_no_exist());
        let v3 = 0x2::table::borrow<address, UserStake<T0>>(&v0.stake_list, v2);
        let v4 = get_stake_rewards(v3.rewards, 0x2::balance::value<T0>(&v3.stake_balance), v3.fee_index, v1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0.stake_fee) >= v4, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::insufficient_stake_fee());
        let v5 = 0x2::table::borrow_mut<address, UserStake<T0>>(&mut v0.stake_list, v2);
        v5.fee_index = v1;
        v5.rewards = 0;
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::claim_stake_rewards_event(v0.index, v0.name, v0.symbol, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>(), v2, v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.stake_fee, v4), arg1)
    }

    public(friend) fun decorate_pixel<T0>(arg0: &mut PixelGlobal, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.decorate_fee, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::insufficient_coin_amount());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.decorate_fee, arg3)));
        let v1 = get_mut_pixel<T0>(arg0);
        v1.image_url = 0x1::option::some<0x2::url::Url>(arg2);
        v1.decorate_address = 0x1::option::some<address>(v0);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::decorate_pixel_event(v0, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>(), v1.name, v1.symbol, arg2, arg0.decorate_fee);
        arg1
    }

    public(friend) fun destroy_pixel<T0, T1, T2>(arg0: &mut PixelGlobal, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T1>>(&mut arg0.pixel_list, arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.sui_balance);
        let v2 = (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::div((v1 as u256), 2) as u64);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut v0.sui_balance, v2);
        let v4 = (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::sub((v1 as u256), (v2 as u256)) as u64);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v0.sui_balance, v4);
        v0.is_destroy = true;
        v0.is_active = false;
        let v6 = v0.symbol;
        let v7 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, arg1);
        assert!(is_alliance(&v7.alliance_list, arg2) == false, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_destroy_pixel());
        0x2::balance::join<0x2::sui::SUI>(&mut v7.sui_balance, v3);
        let v8 = v7.symbol;
        let v9 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T2>>(&mut arg0.pixel_list, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v9.sui_balance, v5);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::destroy_pixel_event(arg1, v7.name, v8, arg2, v0.name, v6, arg3, v9.name, v9.symbol, v1, v2, v4, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun get_alive_pixel_count(arg0: &PixelGlobal) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<u64, 0x1::string::String>(&arg0.pixel_index_list)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u64, 0x1::string::String>(&arg0.pixel_index_list, v1);
            let v4 = *v3;
            if (!0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v4)) {
                v1 = v1 + 1;
                continue
            };
            if (!0x2::table::borrow<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v4).is_destroy) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun get_last_fee_index(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::add((arg0 as u256), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::mul_div((arg1 as u256), (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::stake_scale() as u256), (arg2 as u256))) as u64)
    }

    fun get_mut_pixel<T0>(arg0: &mut PixelGlobal) : &mut Pixel<T0> {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0)
    }

    fun get_mut_stake<T0>(arg0: &mut Pixel<T0>, arg1: address) : &mut UserStake<T0> {
        assert!(is_user_staked<T0>(arg0, arg1) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::user_stake_no_exist());
        0x2::table::borrow_mut<address, UserStake<T0>>(&mut arg0.stake_list, arg1)
    }

    fun get_out_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::div(0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::mul((arg0 as u256), (arg2 as u256)), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::add((arg1 as u256), (arg0 as u256))) as u64)
    }

    fun get_pixel_balance_values<T0>(arg0: &Pixel<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance))
    }

    public fun get_pixel_leader<T0>(arg0: &mut PixelGlobal) : 0x1::option::Option<address> {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        0x2::bag::borrow<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0).leader_address
    }

    fun get_stake_rewards(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::add((arg0 as u256), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::mul_div((arg1 as u256), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::sub((arg3 as u256), (arg2 as u256)), (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::stake_scale() as u256))) as u64)
    }

    fun get_swap_fees(arg0: u64, arg1: u64) : u64 {
        (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::mul_div((arg0 as u256), (arg1 as u256), (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::rate_size() as u256)) as u64)
    }

    public(friend) fun get_winner_pixel(arg0: &PixelGlobal) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::option::none<0x1::string::String>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<u64, 0x1::string::String>(&arg0.pixel_index_list)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<u64, 0x1::string::String>(&arg0.pixel_index_list, v2);
            let v5 = *v4;
            if (!0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v5)) {
                v2 = v2 + 1;
                continue
            };
            let v6 = 0x2::table::borrow<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v5);
            if (v6.sui_amount >= v1) {
                v1 = v6.sui_amount;
                v0 = 0x1::option::some<0x1::string::String>(v5);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun init_pixel(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PixelGlobal{
            id                      : 0x2::object::new(arg0),
            version                 : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::version::current_version(),
            fee                     : 0x2::balance::zero<0x2::sui::SUI>(),
            listing_fee             : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::listing_fee(),
            decorate_fee            : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::decorate_fee(),
            migrate_fee             : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::migrate_fee(),
            buy_fee_rate            : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::buy_fee_rate(),
            sell_fee_rate           : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::sell_fee_rate(),
            stake_fee_rate          : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::stake_fee_rate(),
            alliance_fee_rate       : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::alliance_fee_rate(),
            target_supply_threshold : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::target_supply_threshold(),
            virtual_sui_amount      : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::virtual_sui_amount(),
            pixel_list              : 0x2::bag::new(arg0),
            pixel_index_list        : 0x2::vec_map::empty<u64, 0x1::string::String>(),
            pixel_balance_list      : 0x2::table::new<0x1::string::String, PixelBalance>(arg0),
        };
        0x2::transfer::share_object<PixelGlobal>(v0);
    }

    fun is_alliance(arg0: &0x2::vec_map::VecMap<u64, 0x1::string::String>, arg1: 0x1::string::String) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<u64, 0x1::string::String>(arg0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u64, 0x1::string::String>(arg0, v1);
            if (arg1 == *v3) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun is_pixel_listed<T0>(arg0: &PixelGlobal, arg1: 0x1::string::String) : bool {
        0x2::bag::contains_with_type<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, arg1)
    }

    fun is_user_staked<T0>(arg0: &Pixel<T0>, arg1: address) : bool {
        0x2::table::contains<address, UserStake<T0>>(&arg0.stake_list, arg1)
    }

    public(friend) fun join_alliance<T0, T1>(arg0: &mut PixelGlobal, arg1: &0x2::tx_context::TxContext) {
        check_leader<T0>(arg0, arg1);
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T1>();
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        assert!(is_pixel_listed<T1>(arg0, v1) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        let v2 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T1>>(&mut arg0.pixel_list, v1);
        let v3 = (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::mul_div((0x2::balance::value<0x2::sui::SUI>(&v2.sui_balance) as u256), (arg0.alliance_fee_rate as u256), (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::rate_size() as u256)) as u64);
        let v4 = 0x2::bag::borrow<0x1::string::String, Pixel<T1>>(&arg0.pixel_list, v1).index;
        let v5 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0);
        assert!(0x2::vec_map::contains<u64, 0x1::string::String>(&v5.alliance_list, &v4) == false, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::have_joined_alliance());
        0x2::vec_map::insert<u64, 0x1::string::String>(&mut v5.alliance_list, v4, v1);
        let v6 = v5.index;
        let v7 = v5.symbol;
        let v6 = v6;
        let v8 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T1>>(&mut arg0.pixel_list, v0);
        assert!(0x2::vec_map::contains<u64, 0x1::string::String>(&v8.alliance_list, &v6) == false, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::have_joined_alliance());
        0x2::vec_map::insert<u64, 0x1::string::String>(&mut v8.alliance_list, v6, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v8.sui_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2.sui_balance, v3));
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::join_alliance_event(0x2::tx_context::sender(arg1), v6, v5.name, v7, v0, v4, v8.name, v8.symbol, v1, v3);
    }

    public(friend) fun leave_alliance<T0, T1>(arg0: &mut PixelGlobal, arg1: &0x2::tx_context::TxContext) {
        check_leader<T0>(arg0, arg1);
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T1>();
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        assert!(is_pixel_listed<T1>(arg0, v1) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        let v2 = 0x2::bag::borrow<0x1::string::String, Pixel<T1>>(&arg0.pixel_list, v1).index;
        let v3 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0);
        if (!0x2::vec_map::contains<u64, 0x1::string::String>(&v3.alliance_list, &v2)) {
            let (_, _) = 0x2::vec_map::remove<u64, 0x1::string::String>(&mut v3.alliance_list, &v2);
        };
        let v6 = v3.symbol;
        let v7 = v3.index;
        let v8 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T1>>(&mut arg0.pixel_list, v1);
        if (!0x2::vec_map::contains<u64, 0x1::string::String>(&v8.alliance_list, &v7)) {
            let (_, _) = 0x2::vec_map::remove<u64, 0x1::string::String>(&mut v8.alliance_list, &v7);
        };
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::leave_alliance_event(0x2::tx_context::sender(arg1), v7, v3.name, v6, v0, v2, v8.name, v8.symbol, v1);
    }

    public(friend) fun list<T0>(arg0: &mut PixelGlobal, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_token_supply());
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_token_decimals());
        assert!(arg4 > 0 && arg4 <= arg5, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_pixel_index());
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = 0x2::coin::get_name<T0>(arg2);
        let v2 = 0x2::coin::get_symbol<T0>(arg2);
        assert!(!0x2::vec_map::contains<u64, 0x1::string::String>(&arg0.pixel_index_list, &arg4), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_index_exist());
        assert!(0x2::vec_map::size<u64, 0x1::string::String>(&arg0.pixel_index_list) <= arg5, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_count_overflow());
        0x2::vec_map::insert<u64, 0x1::string::String>(&mut arg0.pixel_index_list, arg4, v0);
        assert!(!0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v0), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_balance_exist());
        assert!(0x2::table::length<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list) <= arg5, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_count_overflow());
        let v3 = PixelBalance{
            is_destroy   : false,
            sui_amount   : 0,
            token_amount : 0,
            stake_amount : 0,
        };
        0x2::table::add<0x1::string::String, PixelBalance>(&mut arg0.pixel_balance_list, v0, v3);
        let v4 = (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::token_total_supply() as u256);
        let v5 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::mul_div(v4, (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::token_reserve_rate() as u256), (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::rate_size() as u256));
        let v6 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::sub(v4, v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg1);
        let v7 = 0x2::coin::get_icon_url<T0>(arg2);
        let v8 = 0x2::tx_context::sender(arg6);
        let v9 = Pixel<T0>{
            version                 : 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::version::current_version(),
            index                   : arg4,
            name                    : v1,
            symbol                  : v2,
            image_url               : v7,
            creator                 : v8,
            is_active               : true,
            is_destroy              : false,
            token_balance           : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1), (v6 as u64)),
            sui_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            token_reserve           : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1), (v5 as u64)),
            target_supply_threshold : arg0.target_supply_threshold,
            virtual_sui_amount      : arg0.virtual_sui_amount,
            stake_fee               : 0x2::balance::zero<0x2::sui::SUI>(),
            stake_amount            : 0,
            last_fee_index          : 0,
            stake_list              : 0x2::table::new<address, UserStake<T0>>(arg6),
            stake_address_list      : 0x1::vector::empty<address>(),
            leader_address          : 0x1::option::none<address>(),
            leader_stake_amount     : 0,
            alliance_list           : 0x2::vec_map::empty<u64, 0x1::string::String>(),
            decorate_address        : 0x1::option::none<address>(),
        };
        assert!(is_pixel_listed<T0>(arg0, v0) == false, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_has_been_listed());
        assert!(0x2::bag::length(&arg0.pixel_list) <= arg5, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_count_overflow());
        0x2::bag::add<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0, v9);
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::pixel_list_event(v8, arg4, v1, v2, v0, 0x2::coin::get_description<T0>(arg2), v7, (v6 as u64), 0, (v5 as u64), arg0.buy_fee_rate, arg0.sell_fee_rate, arg0.stake_fee_rate, arg0.listing_fee, arg0.target_supply_threshold, arg0.virtual_sui_amount);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.listing_fee, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::insufficient_listing_fee());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.listing_fee, arg6)));
        arg3
    }

    public(friend) fun migrate<T0>(arg0: &mut PixelGlobal, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = arg0.migrate_fee;
        let v1 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        assert!(is_pixel_listed<T0>(arg0, v1) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        assert!(0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v1).is_active == false, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_active());
        if (v0 > 0) {
            let v2 = get_mut_pixel<T0>(arg0);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(&mut v2.sui_balance, v0));
        };
        let v3 = get_mut_pixel<T0>(arg0);
        let (v4, v5) = get_pixel_balance_values<T0>(v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3.sui_balance, v4), arg1), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3.token_balance, v5), arg1))
    }

    public(friend) fun sell<T0>(arg0: &mut PixelGlobal, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = arg0.sell_fee_rate;
        let v2 = arg0.stake_fee_rate;
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        let v3 = 0x2::bag::borrow<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0);
        let (v4, v5) = get_pixel_balance_values<T0>(v3);
        let v6 = v3.symbol;
        assert!(v3.is_active == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_inactive());
        let v7 = 0x2::coin::into_balance<T0>(arg1);
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = get_out_amount(v8, v5, v4 + v3.virtual_sui_amount);
        let v10 = get_swap_fees(v9, v1);
        let v11 = get_swap_fees(v9, v2);
        let v12 = 0x2::balance::split<0x2::sui::SUI>(&mut 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0).sui_balance, v9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(&mut v12, v10));
        let v13 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0);
        0x2::balance::join<T0>(&mut v13.token_balance, v7);
        0x2::balance::join<0x2::sui::SUI>(&mut v13.stake_fee, 0x2::balance::split<0x2::sui::SUI>(&mut v12, v11));
        v13.last_fee_index = get_last_fee_index(v13.last_fee_index, v11, v13.stake_amount);
        let (v14, v15) = get_pixel_balance_values<T0>(v13);
        assert!(v15 > 0 && v14 > 0, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_swap_amount());
        assert!(0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v0), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_balance_not_exist());
        let v16 = 0x2::table::borrow_mut<0x1::string::String, PixelBalance>(&mut arg0.pixel_balance_list, v0);
        v16.sui_amount = v14;
        v16.token_amount = v15;
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::swap_event(false, 0x2::tx_context::sender(arg2), v3.name, v6, v0, v8, v9, v1, v2, v10, v11);
        0x2::coin::from_balance<0x2::sui::SUI>(v12, arg2)
    }

    public(friend) fun stake<T0>(arg0: &mut PixelGlobal, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::balance::value<T0>(&v2);
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        let v4 = 0x2::bag::borrow<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0);
        let v5 = if (0x2::table::contains<address, UserStake<T0>>(&v4.stake_list, v1)) {
            (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::add((v3 as u256), (0x2::balance::value<T0>(&0x2::table::borrow<address, UserStake<T0>>(&v4.stake_list, v1).stake_balance) as u256)) as u64)
        } else {
            v3
        };
        let v6 = v4.symbol;
        let v7 = v4.last_fee_index;
        let v8 = v4.leader_address;
        assert!(v4.is_active == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_inactive());
        let v9 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0);
        v9.stake_amount = (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::add((v9.stake_amount as u256), (v3 as u256)) as u64);
        if (0x1::option::is_none<address>(&v9.leader_address) || v5 > v9.leader_stake_amount) {
            v9.leader_address = 0x1::option::some<address>(v1);
            v9.leader_stake_amount = v5;
        };
        if (v8 != v9.leader_address) {
            0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::new_leader_event(v9.index, v9.name, v9.symbol, v0, v9.leader_address, v9.leader_stake_amount);
        };
        if (!0x1::vector::contains<address>(&v9.stake_address_list, &v1)) {
            0x1::vector::push_back<address>(&mut v9.stake_address_list, v1);
        };
        if (0x2::table::contains<address, UserStake<T0>>(&v9.stake_list, v1)) {
            let v10 = 0x2::table::borrow_mut<address, UserStake<T0>>(&mut v9.stake_list, v1);
            v10.rewards = get_stake_rewards(v10.rewards, 0x2::balance::value<T0>(&v10.stake_balance), v10.fee_index, v7);
            v10.fee_index = v7;
            0x2::balance::join<T0>(&mut v10.stake_balance, v2);
        } else {
            let v11 = UserStake<T0>{
                id            : 0x2::object::new(arg2),
                user          : v1,
                stake_balance : v2,
                fee_index     : v7,
                rewards       : 0,
            };
            0x2::table::add<address, UserStake<T0>>(&mut v9.stake_list, v1, v11);
        };
        assert!(0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v0), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_balance_not_exist());
        0x2::table::borrow_mut<0x1::string::String, PixelBalance>(&mut arg0.pixel_balance_list, v0).stake_amount = v9.stake_amount;
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::stake_event(v4.index, v4.name, v6, v0, v1, v3);
    }

    public(friend) fun unstake<T0>(arg0: &mut PixelGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(is_pixel_listed<T0>(arg0, v0) == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_not_exist());
        let v2 = 0x2::bag::borrow<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0);
        let v3 = v2.symbol;
        let v4 = v2.last_fee_index;
        let v5 = v2.leader_address;
        assert!(v2.is_active == true, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_inactive());
        let v6 = 0x2::bag::borrow_mut<0x1::string::String, Pixel<T0>>(&mut arg0.pixel_list, v0);
        let v7 = 0x1::option::none<address>();
        let v8 = 0;
        let v9 = v8;
        let v10 = 0x1::vector::length<address>(&v6.stake_address_list);
        while (v10 > 0) {
            let v11 = *0x1::vector::borrow<address>(&v6.stake_address_list, v10 - 1);
            if (0x2::table::contains<address, UserStake<T0>>(&v6.stake_list, v11)) {
                let v12 = 0x2::balance::value<T0>(&0x2::table::borrow<address, UserStake<T0>>(&v6.stake_list, v11).stake_balance);
                let v13 = v12;
                if (v11 == v1) {
                    v13 = (0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::math::sub((v12 as u256), (arg1 as u256)) as u64);
                };
                if (v13 > v8) {
                    v7 = 0x1::option::some<address>(v11);
                    v9 = v13;
                };
            };
            v10 = v10 - 1;
        };
        v6.leader_address = v7;
        v6.leader_stake_amount = v9;
        if (v5 != v6.leader_address) {
            0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::new_leader_event(v6.index, v6.name, v6.symbol, v0, v6.leader_address, v6.leader_stake_amount);
        };
        let v14 = get_mut_stake<T0>(v6, v1);
        let v15 = 0x2::balance::value<T0>(&v14.stake_balance);
        assert!(v15 >= arg1, 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_unstake_amount());
        v14.rewards = get_stake_rewards(v14.rewards, v15, v14.fee_index, v4);
        v14.fee_index = v4;
        if (v15 == arg1 && v14.rewards == 0) {
            let UserStake {
                id            : v16,
                user          : _,
                stake_balance : v18,
                fee_index     : _,
                rewards       : _,
            } = 0x2::table::remove<address, UserStake<T0>>(&mut v6.stake_list, v1);
            0x2::balance::destroy_zero<T0>(v18);
            0x2::object::delete(v16);
        };
        assert!(0x2::table::contains<0x1::string::String, PixelBalance>(&arg0.pixel_balance_list, v0), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::pixel_balance_not_exist());
        0x2::table::borrow_mut<0x1::string::String, PixelBalance>(&mut arg0.pixel_balance_list, v0).stake_amount = v6.stake_amount;
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::event::unstake_event(v2.index, v2.name, v3, v0, v1, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v14.stake_balance, arg1), arg2)
    }

    public(friend) fun update_decorate_fee(arg0: &mut PixelGlobal, arg1: u64) {
        arg0.decorate_fee = arg1;
    }

    public(friend) fun update_listing_fee(arg0: &mut PixelGlobal, arg1: u64) {
        arg0.listing_fee = arg1;
    }

    public fun user_stake_amount<T0>(arg0: &PixelGlobal, arg1: address) : u64 {
        let v0 = 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::utils::get_pixel_type<T0>();
        if (!0x2::bag::contains_with_type<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0)) {
            return 0
        };
        let v1 = 0x2::bag::borrow<0x1::string::String, Pixel<T0>>(&arg0.pixel_list, v0);
        if (!0x2::table::contains<address, UserStake<T0>>(&v1.stake_list, arg1)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::table::borrow<address, UserStake<T0>>(&v1.stake_list, arg1).stake_balance)
    }

    // decompiled from Move bytecode v6
}

