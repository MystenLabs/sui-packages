module 0x89fb01ae35615d28f20e37fb54487c179c405ff96fc7c3cb78921bb189ef4902::market {
    struct Position has copy, drop, store {
        yes: u64,
        no: u64,
        claimed: bool,
    }

    struct Market<T0: store> has store, key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        close_time_ms: u64,
        fee_bps: u64,
        resolved: bool,
        outcome_yes: bool,
        total_yes: u64,
        total_no: u64,
        yes_pool: 0x2::balance::Balance<T0>,
        no_pool: 0x2::balance::Balance<T0>,
        payout_pool: 0x2::balance::Balance<T0>,
        fee_pool: 0x2::balance::Balance<T0>,
        positions: 0x2::vec_map::VecMap<address, Position>,
    }

    fun assert_admin<T0: store>(arg0: &Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun assert_open<T0: store>(arg0: &Market<T0>, arg1: &0x2::clock::Clock) {
        assert!(!arg0.resolved, 2);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.close_time_ms, 1);
    }

    public entry fun bet_no<T0: store>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_open<T0>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.no_pool, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_no = arg0.total_no + v0;
        let v1 = &mut arg0.positions;
        let v2 = borrow_position_mut(v1, 0x2::tx_context::sender(arg3));
        v2.no = v2.no + v0;
    }

    public entry fun bet_yes<T0: store>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_open<T0>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.yes_pool, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_yes = arg0.total_yes + v0;
        let v1 = &mut arg0.positions;
        let v2 = borrow_position_mut(v1, 0x2::tx_context::sender(arg3));
        v2.yes = v2.yes + v0;
    }

    fun borrow_position_mut(arg0: &mut 0x2::vec_map::VecMap<address, Position>, arg1: address) : &mut Position {
        if (!0x2::vec_map::contains<address, Position>(arg0, &arg1)) {
            let v0 = Position{
                yes     : 0,
                no      : 0,
                claimed : false,
            };
            0x2::vec_map::insert<address, Position>(arg0, arg1, v0);
        };
        0x2::vec_map::get_mut<address, Position>(arg0, &arg1)
    }

    fun borrow_position_mut_if_exists(arg0: &mut 0x2::vec_map::VecMap<address, Position>, arg1: address) : &mut Position {
        assert!(0x2::vec_map::contains<address, Position>(arg0, &arg1), 6);
        0x2::vec_map::get_mut<address, Position>(arg0, &arg1)
    }

    public entry fun claim<T0: store>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 3);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.positions;
        let v2 = borrow_position_mut_if_exists(v1, v0);
        assert!(!v2.claimed, 5);
        let v3 = if (arg0.outcome_yes) {
            v2.yes
        } else {
            v2.no
        };
        assert!(v3 > 0, 7);
        let v4 = if (arg0.outcome_yes) {
            arg0.total_yes
        } else {
            arg0.total_no
        };
        assert!(v4 > 0, 7);
        let v5 = 0x2::balance::value<T0>(&arg0.payout_pool) * v3 / v4;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_pool, v5), arg1), v0);
        };
        v2.claimed = true;
    }

    public entry fun create_market<T0: store>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 10000, 8);
        let v0 = Market<T0>{
            id            : 0x2::object::new(arg4),
            admin         : arg0,
            treasury      : arg1,
            close_time_ms : arg2,
            fee_bps       : arg3,
            resolved      : false,
            outcome_yes   : false,
            total_yes     : 0,
            total_no      : 0,
            yes_pool      : 0x2::balance::zero<T0>(),
            no_pool       : 0x2::balance::zero<T0>(),
            payout_pool   : 0x2::balance::zero<T0>(),
            fee_pool      : 0x2::balance::zero<T0>(),
            positions     : 0x2::vec_map::empty<address, Position>(),
        };
        0x2::transfer::share_object<Market<T0>>(v0);
    }

    public entry fun create_market_fixed<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xc946d2e0e751fe7252bc35ad7d7ea2aea6e2fd9b02786b50d142b0139d93f0ed, 0);
        create_market<T0>(@0xc946d2e0e751fe7252bc35ad7d7ea2aea6e2fd9b02786b50d142b0139d93f0ed, @0xc946d2e0e751fe7252bc35ad7d7ea2aea6e2fd9b02786b50d142b0139d93f0ed, arg0, 150, arg1);
    }

    public entry fun resolve<T0: store>(arg0: &mut Market<T0>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg3);
        assert!(!arg0.resolved, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.close_time_ms, 9);
        0x2::balance::join<T0>(&mut arg0.payout_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.yes_pool));
        0x2::balance::join<T0>(&mut arg0.payout_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.no_pool));
        let v0 = 0x2::balance::value<T0>(&arg0.payout_pool);
        if (v0 > 0) {
            let v1 = v0 * arg0.fee_bps / 10000;
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_pool, v1), arg3), arg0.treasury);
            };
        };
        arg0.resolved = true;
        arg0.outcome_yes = arg1;
    }

    public entry fun sweep_if_no_winners<T0: store>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg0.resolved, 3);
        let v0 = if (arg0.outcome_yes) {
            arg0.total_yes
        } else {
            arg0.total_no
        };
        assert!(v0 == 0, 7);
        if (0x2::balance::value<T0>(&arg0.payout_pool) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.payout_pool), arg1), arg0.treasury);
        };
    }

    public entry fun withdraw_fee<T0: store>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        if (0x2::balance::value<T0>(&arg0.fee_pool) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fee_pool), arg1), arg0.treasury);
        };
    }

    // decompiled from Move bytecode v6
}

