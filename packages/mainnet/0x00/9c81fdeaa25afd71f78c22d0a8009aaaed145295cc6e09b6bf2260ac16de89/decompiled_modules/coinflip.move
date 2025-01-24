module 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::coinflip {
    struct CoinFlip has store, key {
        id: 0x2::object::UID,
        version: u64,
        house_bag: 0x2::bag::Bag,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        coinflip_id: 0x2::object::ID,
    }

    struct InitHouseEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BetResultEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        bet_size: u64,
        bet_returned: u64,
        bet_type: u64,
        outcome: u64,
    }

    public fun balance<T0>(arg0: &CoinFlip) : u64 {
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::balance<T0>(get_house<T0>(arg0))
    }

    entry fun bet<T0>(arg0: &mut CoinFlip, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(contains_house<T0>(arg0), 0);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        let v0 = get_house_mut<T0>(arg0);
        assert!(arg3 <= 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::balance<T0>(v0), 3);
        assert!(arg3 >= 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::min_stake<T0>(v0), 5);
        assert!(arg3 <= 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::max_stake<T0>(v0), 4);
        assert!(arg4 == 0 || arg4 == 1, 6);
        let v1 = 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::ranges::from_single_range(arg4 * 500, arg4 * 500 + 485);
        let v2 = 0x2::random::new_generator(arg1, arg5);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 1, 1000);
        let v4 = if (0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::ranges::contains(&v1, v3)) {
            arg3 * 2
        } else {
            0
        };
        if (v4 > 0) {
            0x2::coin::join<T0>(&mut arg2, 0x2::coin::take<T0>(0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::borrow_balance_mut<T0>(v0), arg3, arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            let v5 = 0x2::coin::into_balance<T0>(arg2);
            if (0x2::balance::value<T0>(&v5) > arg3) {
                0x2::balance::join<T0>(0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::borrow_balance_mut<T0>(v0), 0x2::balance::split<T0>(&mut v5, arg3));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), 0x2::tx_context::sender(arg5));
            } else {
                0x2::balance::join<T0>(0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::borrow_balance_mut<T0>(v0), v5);
            };
        };
        let v6 = BetResultEvent{
            coin_type    : 0x1::type_name::get<T0>(),
            bet_size     : arg3,
            bet_returned : v4,
            bet_type     : arg4,
            outcome      : v3,
        };
        0x2::event::emit<BetResultEvent>(v6);
    }

    public fun contains_house<T0>(arg0: &CoinFlip) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.house_bag, 0x1::type_name::get<T0>())
    }

    public fun get_house<T0>(arg0: &CoinFlip) : &0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::House<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::House<T0>>(&arg0.house_bag, 0x1::type_name::get<T0>())
    }

    public(friend) fun get_house_mut<T0>(arg0: &mut CoinFlip) : &mut 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::House<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::House<T0>>(&mut arg0.house_bag, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::new(arg0);
        0x2::transfer::public_transfer<0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CoinFlip{
            id        : 0x2::object::new(arg0),
            version   : 1,
            house_bag : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<CoinFlip>(v1);
        let v2 = InitEvent{
            admin_cap_id : 0x2::object::id<0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap>(&v0),
            coinflip_id  : 0x2::object::id<CoinFlip>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public fun init_hosuse<T0>(arg0: &0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap, arg1: &mut CoinFlip, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!contains_house<T0>(arg1), 1);
        let v0 = 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::initialize_house<T0>(arg3, arg4, arg5);
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::top_up<T0>(&mut v0, arg2, arg5);
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::House<T0>>(&mut arg1.house_bag, v1, v0);
        let v2 = InitHouseEvent{
            coin_type : v1,
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<InitHouseEvent>(v2);
    }

    public fun max_risk<T0>(arg0: &CoinFlip) : u64 {
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::balance<T0>(get_house<T0>(arg0)) / 10
    }

    public fun max_stake<T0>(arg0: &CoinFlip) : u64 {
        let v0 = get_house<T0>(arg0);
        let v1 = 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::max_stake<T0>(v0);
        let v2 = 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::balance<T0>(v0);
        if (v1 > v2) {
            v2
        } else {
            v1
        }
    }

    public fun min_stake<T0>(arg0: &CoinFlip) : u64 {
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::min_stake<T0>(get_house<T0>(arg0))
    }

    public fun top_up<T0>(arg0: &0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap, arg1: &mut CoinFlip, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::top_up<T0>(get_house_mut<T0>(arg1), arg2, arg3);
    }

    public fun update_max_stake<T0>(arg0: &0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap, arg1: &mut CoinFlip, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::update_max_stake<T0>(get_house_mut<T0>(arg1), arg2);
    }

    public fun update_min_stake<T0>(arg0: &0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap, arg1: &mut CoinFlip, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::update_min_stake<T0>(get_house_mut<T0>(arg1), arg2);
    }

    public entry fun withdraw<T0>(arg0: &0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::admin::AdminCap, arg1: &mut CoinFlip, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9c81fdeaa25afd71f78c22d0a8009aaaed145295cc6e09b6bf2260ac16de89::house::withdraw<T0>(get_house_mut<T0>(arg1), arg2);
        let v1 = WithdrawEvent{
            sender    : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

