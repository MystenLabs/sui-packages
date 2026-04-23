module 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery {
    struct Lottery<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
        active: bool,
        price_per_chance: u64,
        user_chances: 0x2::table::Table<address, u64>,
        reward_vault: 0x2::balance::Balance<T0>,
        prize_amounts: vector<u64>,
        prize_weights_bps: vector<u64>,
        total_draws: u64,
        total_chances_issued: u64,
        total_reward_out: u64,
    }

    struct AdminTopupRewardEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct AddChancesEvent has copy, drop {
        user: address,
        paid_amount: u64,
        chances_added: u64,
        total_user_chances: u64,
    }

    struct DrawEvent has copy, drop {
        user: address,
        random_bps: u64,
        prize_index: u64,
        prize_amount: u64,
        chances_left: u64,
    }

    fun add_chances(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        };
    }

    public(friend) fun add_chances_by_amount<T0>(arg0: &mut Lottery<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg1 / arg0.price_per_chance;
        if (v1 == 0) {
            return
        };
        let v2 = &mut arg0.user_chances;
        add_chances(v2, v0, v1);
        arg0.total_chances_issued = arg0.total_chances_issued + v1;
        let v3 = AddChancesEvent{
            user               : v0,
            paid_amount        : arg1,
            chances_added      : v1,
            total_user_chances : borrow_chances(&arg0.user_chances, v0),
        };
        0x2::event::emit<AddChancesEvent>(v3);
    }

    public(friend) fun admin_set_active<T0>(arg0: &mut Lottery<T0>, arg1: bool) {
        assert_version(arg0.version);
        arg0.active = arg1;
    }

    public fun admin_topup_reward<T0>(arg0: &mut Lottery<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::balance::join<T0>(&mut arg0.reward_vault, 0x2::coin::into_balance<T0>(arg1));
        let v0 = AdminTopupRewardEvent{
            admin  : arg0.admin,
            amount : 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1)),
        };
        0x2::event::emit<AdminTopupRewardEvent>(v0);
    }

    public fun admin_withdraw_reward<T0>(arg0: &mut Lottery<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert_version(arg0.version);
        0x2::coin::send_funds<T0>(0x2::coin::take<T0>(&mut arg0.reward_vault, arg1, arg2), arg0.admin);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 100);
    }

    fun borrow_chances(arg0: &0x2::table::Table<address, u64>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        } else {
            0
        }
    }

    fun borrow_user_chances_mut(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) : &mut u64 {
        assert!(0x2::table::contains<address, u64>(arg0, arg1), 6);
        0x2::table::borrow_mut<address, u64>(arg0, arg1)
    }

    public(friend) fun create_default<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 5);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 288 * arg1);
        0x1::vector::push_back<u64>(v1, 588 * arg1);
        0x1::vector::push_back<u64>(v1, 688 * arg1);
        0x1::vector::push_back<u64>(v1, 888 * arg1);
        0x1::vector::push_back<u64>(v1, 1088 * arg1);
        0x1::vector::push_back<u64>(v1, 1688 * arg1);
        0x1::vector::push_back<u64>(v1, 1888 * arg1);
        0x1::vector::push_back<u64>(v1, 5000 * arg1);
        0x1::vector::push_back<u64>(v1, 10000 * arg1);
        let v2 = vector[500, 1000, 1500, 3000, 2650, 1000, 200, 100, 50];
        assert!(0x1::vector::length<u64>(&v0) == 0x1::vector::length<u64>(&v2), 7);
        assert!(sum_u64(&v2) == 10000, 7);
        let v3 = Lottery<T0>{
            id                   : 0x2::object::new(arg2),
            admin                : 0x2::tx_context::sender(arg2),
            version              : 1,
            active               : true,
            price_per_chance     : arg0,
            user_chances         : 0x2::table::new<address, u64>(arg2),
            reward_vault         : 0x2::balance::zero<T0>(),
            prize_amounts        : v0,
            prize_weights_bps    : v2,
            total_draws          : 0,
            total_chances_issued : 0,
            total_reward_out     : 0,
        };
        0x2::transfer::share_object<Lottery<T0>>(v3);
    }

    public fun draw_once<T0>(arg0: &mut Lottery<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.user_chances;
        let v2 = borrow_user_chances_mut(v1, v0);
        assert!(*v2 > 0, 6);
        let v3 = 0x2::random::new_generator(arg1, arg2);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, 0, 10000);
        let v5 = pick_weighted_index(&arg0.prize_weights_bps, v4);
        let v6 = *0x1::vector::borrow<u64>(&arg0.prize_amounts, v5);
        assert!(0x2::balance::value<T0>(&arg0.reward_vault) >= v6, 8);
        0x2::coin::send_funds<T0>(0x2::coin::take<T0>(&mut arg0.reward_vault, v6, arg2), v0);
        *v2 = *v2 - 1;
        arg0.total_draws = arg0.total_draws + 1;
        arg0.total_reward_out = arg0.total_reward_out + v6;
        let v7 = DrawEvent{
            user         : v0,
            random_bps   : v4,
            prize_index  : v5,
            prize_amount : v6,
            chances_left : *v2,
        };
        0x2::event::emit<DrawEvent>(v7);
    }

    fun pick_weighted_index(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u64>(arg0);
        while (v0 < v2) {
            let v3 = v1 + *0x1::vector::borrow<u64>(arg0, v0);
            v1 = v3;
            if (arg1 < v3) {
                return v0
            };
            v0 = v0 + 1;
        };
        v2 - 1
    }

    public(friend) fun set_admin<T0>(arg0: &mut Lottery<T0>, arg1: address) {
        assert_version(arg0.version);
        arg0.admin = arg1;
    }

    fun sum_u64(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun upgrade_version<T0>(arg0: &mut Lottery<T0>) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun user_remaining_chances<T0>(arg0: &Lottery<T0>, arg1: address) : u64 {
        borrow_chances(&arg0.user_chances, arg1)
    }

    // decompiled from Move bytecode v7
}

