module 0xe0a9ea09e739359f05d823d3249c581b6a738b3cd629c6fce36e67abb1d59404::rewards {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositCap has store, key {
        id: 0x2::object::UID,
    }

    struct SetupCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardsPool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        leaderboard: 0x2::table::Table<address, u64>,
        claims_enabled: bool,
        required_funds: u64,
        setup_hashes: vector<address>,
    }

    public fun admin_withdraw_funds(arg0: &AdminCap, arg1: &mut RewardsPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(!arg1.claims_enabled, 6);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance)), arg2)
    }

    public fun claim(arg0: &mut RewardsPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(arg0.claims_enabled, 4);
        assert!(0x2::table::contains<address, u64>(&arg0.leaderboard, 0x2::tx_context::sender(arg1)), 1);
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.leaderboard, 0x2::tx_context::sender(arg1));
        arg0.required_funds = arg0.required_funds - v0;
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, v0), arg1)
    }

    public fun deposit(arg0: &DepositCap, arg1: &mut RewardsPool, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        assert!(0x2::table::length<address, u64>(&arg1.leaderboard) > 0 || 0x1::vector::length<address>(&arg1.setup_hashes) > 0, 9);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    public fun disable_claims(arg0: &AdminCap, arg1: &mut RewardsPool) {
        arg1.claims_enabled = false;
    }

    public fun enable_claims(arg0: &AdminCap, arg1: &mut RewardsPool) {
        assert!(0x2::table::length<address, u64>(&arg1.leaderboard) > 0 && 0x1::vector::length<address>(&arg1.setup_hashes) == 0, 8);
        assert!(arg1.required_funds <= 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance), 2);
        arg1.claims_enabled = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DepositCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DepositCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = RewardsPool{
            id             : 0x2::object::new(arg0),
            balance        : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            leaderboard    : 0x2::table::new<address, u64>(arg0),
            claims_enabled : false,
            required_funds : 0,
            setup_hashes   : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<RewardsPool>(v3);
    }

    public fun leaderboard(arg0: &RewardsPool) : &0x2::table::Table<address, u64> {
        &arg0.leaderboard
    }

    public fun new_deposit_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : DepositCap {
        DepositCap{id: 0x2::object::new(arg1)}
    }

    public fun setup_hashes(arg0: SetupCap, arg1: &mut RewardsPool, arg2: vector<address>) {
        let SetupCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x1::vector::push_back<address>(&mut arg1.setup_hashes, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun setup_leaderboard(arg0: &mut RewardsPool, arg1: vector<address>, arg2: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 3);
        assert!(!arg0.claims_enabled, 6);
        let v0 = 0x2::bcs::to_bytes<vector<address>>(&arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg2));
        let v1 = 0x2::address::from_bytes(0x2::hash::blake2b256(&v0));
        let (v2, v3) = 0x1::vector::index_of<address>(&arg0.setup_hashes, &v1);
        assert!(v2, 7);
        0x1::vector::remove<address>(&mut arg0.setup_hashes, v3);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v4 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.required_funds = arg0.required_funds + v4;
            0x2::table::add<address, u64>(&mut arg0.leaderboard, 0x1::vector::pop_back<address>(&mut arg1), v4);
        };
    }

    // decompiled from Move bytecode v6
}

