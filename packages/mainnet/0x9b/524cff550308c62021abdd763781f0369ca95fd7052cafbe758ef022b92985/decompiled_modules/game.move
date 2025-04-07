module 0x9b524cff550308c62021abdd763781f0369ca95fd7052cafbe758ef022b92985::game {
    struct Category has drop, store {
        id: u64,
        name: vector<u8>,
        token_type: u64,
        amount: u64,
    }

    struct Game has key {
        id: 0x2::object::UID,
        categories: vector<Category>,
        odds: 0x2::vec_map::VecMap<u64, u64>,
        spin_cost: u64,
        spin_enabled: bool,
        prize_pool: 0x2::vec_map::VecMap<u64, 0x2::coin::Coin<0x2::sui::SUI>>,
        sui_balance: 0x2::coin::Coin<0x2::sui::SUI>,
        owner: address,
    }

    struct SpinResult has copy, drop {
        spinner: address,
        category_id: u64,
        prize_name: vector<u8>,
    }

    struct PrizeAdded has copy, drop {
        category_id: u64,
        name: vector<u8>,
    }

    struct PrizeRemoved has copy, drop {
        category_id: u64,
    }

    struct SpinCostUpdated has copy, drop {
        new_cost: u64,
    }

    public entry fun add_prize(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 3);
        let v0 = 0x1::vector::length<Category>(&arg0.categories);
        let v1 = Category{
            id         : v0,
            name       : arg2,
            token_type : 1,
            amount     : arg3,
        };
        0x1::vector::push_back<Category>(&mut arg0.categories, v1);
        0x2::vec_map::insert<u64, u64>(&mut arg0.odds, v0, arg4);
        let v2 = 1;
        if (0x2::vec_map::contains<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.prize_pool, &v2)) {
            let v3 = 1;
            0x2::coin::join<0x2::sui::SUI>(0x2::vec_map::get_mut<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.prize_pool, &v3), arg1);
        } else {
            0x2::vec_map::insert<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.prize_pool, 1, arg1);
        };
        let v4 = PrizeAdded{
            category_id : v0,
            name        : arg2,
        };
        0x2::event::emit<PrizeAdded>(v4);
    }

    fun calculate_total_weight(arg0: &0x2::vec_map::VecMap<u64, u64>) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<u64, u64>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = *0x1::vector::borrow<u64>(&v1, v2);
            v0 = v0 + *0x2::vec_map::get<u64, u64>(arg0, &v3);
            v2 = v2 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id           : 0x2::object::new(arg0),
            categories   : 0x1::vector::empty<Category>(),
            odds         : 0x2::vec_map::empty<u64, u64>(),
            spin_cost    : 10000000,
            spin_enabled : false,
            prize_pool   : 0x2::vec_map::empty<u64, 0x2::coin::Coin<0x2::sui::SUI>>(),
            sui_balance  : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            owner        : 0x2::tx_context::sender(arg0),
        };
        let v1 = Category{
            id         : 0,
            name       : b"lost",
            token_type : 0,
            amount     : 0,
        };
        0x1::vector::push_back<Category>(&mut v0.categories, v1);
        0x2::vec_map::insert<u64, u64>(&mut v0.odds, 0, 70);
        0x2::transfer::share_object<Game>(v0);
    }

    fun pick_category(arg0: &0x2::vec_map::VecMap<u64, u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<u64, u64>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = *0x1::vector::borrow<u64>(&v1, v2);
            let v4 = v0 + *0x2::vec_map::get<u64, u64>(arg0, &v3);
            v0 = v4;
            if (arg1 < v4) {
                return v3
            };
            v2 = v2 + 1;
        };
        0
    }

    public entry fun remove_prize(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        assert!(arg1 < 0x1::vector::length<Category>(&arg0.categories), 4);
        assert!(arg1 != 0, 5);
        0x1::vector::remove<Category>(&mut arg0.categories, arg1);
        let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.odds, &arg1);
        let v2 = PrizeRemoved{category_id: arg1};
        0x2::event::emit<PrizeRemoved>(v2);
    }

    public entry fun set_spin_cost(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        arg0.spin_cost = arg1;
        let v0 = SpinCostUpdated{new_cost: arg1};
        0x2::event::emit<SpinCostUpdated>(v0);
    }

    public entry fun set_spin_enabled(arg0: &mut Game, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        arg0.spin_enabled = arg1;
    }

    public entry fun spin_wheel(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.spin_enabled, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.spin_cost, 2);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.spin_cost, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = pick_category(&arg0.odds, 0x2::random::generate_u64_in_range(&mut v0, 0, calculate_total_weight(&arg0.odds) - 1));
        let v2 = 0x1::vector::borrow<Category>(&arg0.categories, v1);
        if (v2.token_type > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(0x2::vec_map::get_mut<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.prize_pool, &v2.token_type), v2.amount, arg3), 0x2::tx_context::sender(arg3));
        };
        let v3 = SpinResult{
            spinner     : 0x2::tx_context::sender(arg3),
            category_id : v1,
            prize_name  : v2.name,
        };
        0x2::event::emit<SpinResult>(v3);
    }

    public entry fun withdraw_prize(arg0: &mut Game, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(0x2::vec_map::contains<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.prize_pool, &arg1), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(0x2::vec_map::get_mut<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.prize_pool, &arg1), arg2, arg3), arg0.owner);
    }

    public entry fun withdraw_sui(arg0: &mut Game, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

