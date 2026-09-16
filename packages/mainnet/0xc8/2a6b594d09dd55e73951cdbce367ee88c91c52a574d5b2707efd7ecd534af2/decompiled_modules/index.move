module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        index: 0x2::object::ID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        index: 0x2::object::ID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        index: 0x2::object::ID,
    }

    struct Index<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: 0x2::coin::TreasuryCap<T0>,
        balances: 0x2::bag::Bag,
        held: vector<0x1::type_name::TypeName>,
        targets: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        added_ms: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        raised_ms: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        retiring: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        graveyard: 0x2::bag::Bag,
        quarantine: 0x2::bag::Bag,
        genesis_done: bool,
        busy: bool,
        keeper: 0x2::object::ID,
        mint_window: u64,
        mint_window_ms: u64,
        outflow: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Outflow>,
        open_by_proposer: 0x2::vec_map::VecMap<address, 0x2::object::ID>,
    }

    struct Outflow has copy, drop, store {
        start_ms: u64,
        start_holding: u64,
        out: u64,
    }

    struct PolCoinsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PolShareKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MintTicket {
        index: 0x2::object::ID,
        amount: u64,
        gross: u64,
        supply: u64,
        remaining: vector<0x1::type_name::TypeName>,
        flash: bool,
    }

    struct RedeemTicket {
        index: 0x2::object::ID,
        num: u64,
        den: u64,
        remaining: vector<0x1::type_name::TypeName>,
        debt: u64,
    }

    struct GenesisTicket {
        index: 0x2::object::ID,
        amount: u64,
        total_bps: u64,
    }

    struct SwapTicket {
        index: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        to: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
    }

    struct Minted has copy, drop {
        index: 0x2::object::ID,
        amount: u64,
        premium_bps: u64,
        flash: bool,
        supply: u64,
    }

    struct Redeemed has copy, drop {
        index: 0x2::object::ID,
        amount: u64,
        fee_bps: u64,
        flash: bool,
        supply: u64,
    }

    struct Donated has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Burned has copy, drop {
        index: 0x2::object::ID,
        amount: u64,
    }

    struct KeeperSwapped has copy, drop {
        index: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        to: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct TargetsChanged has copy, drop {
        index: 0x2::object::ID,
        coins: vector<0x1::type_name::TypeName>,
        bps: vector<u64>,
    }

    struct CoinRetired has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        dust: u64,
    }

    struct KeeperRotated has copy, drop {
        index: 0x2::object::ID,
        keeper: 0x2::object::ID,
    }

    struct Quarantined has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        amount: u64,
        released: bool,
    }

    public(friend) fun add_coin<T0, T1>(arg0: &mut Index<T0>, arg1: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0, 0x2::balance::zero<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.held, v0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.added_ms, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.added_ms, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.added_ms, v0, arg1);
    }

    public(friend) fun added_ms<T0>(arg0: &Index<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.added_ms, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.added_ms, arg1)
        } else {
            0
        }
    }

    public(friend) fun assert_guardian<T0>(arg0: &Index<T0>, arg1: &GuardianCap) {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
    }

    fun assert_keeper<T0>(arg0: &Index<T0>, arg1: &KeeperCap) {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(0x2::object::id<KeeperCap>(arg1) == arg0.keeper, 15);
    }

    public(friend) fun assert_live<T0>(arg0: &Index<T0>) {
        assert!(arg0.version == 2, 1);
        assert!(!arg0.busy, 2);
    }

    public fun burn_donation<T0>(arg0: &mut Index<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_live<T0>(arg0);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        let v0 = Burned{
            index  : 0x2::object::id<Index<T0>>(arg0),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Burned>(v0);
    }

    public(friend) fun check_keeper<T0>(arg0: &Index<T0>, arg1: &KeeperCap) {
        assert_keeper<T0>(arg0, arg1);
    }

    public(friend) fun clear_proposer<T0>(arg0: &mut Index<T0>, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::vec_map::contains<address, 0x2::object::ID>(&arg0.open_by_proposer, &arg1) && *0x2::vec_map::get<address, 0x2::object::ID>(&arg0.open_by_proposer, &arg1) == arg2) {
            let (_, _) = 0x2::vec_map::remove<address, 0x2::object::ID>(&mut arg0.open_by_proposer, &arg1);
        };
    }

    public fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (AdminCap, GuardianCap, KeeperCap) {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 5);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = KeeperCap{
            id    : 0x2::object::new(arg1),
            index : v1,
        };
        let v3 = Index<T0>{
            id               : v0,
            version          : 2,
            treasury         : arg0,
            balances         : 0x2::bag::new(arg1),
            held             : 0x1::vector::empty<0x1::type_name::TypeName>(),
            targets          : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            added_ms         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            raised_ms        : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            retiring         : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            graveyard        : 0x2::bag::new(arg1),
            quarantine       : 0x2::bag::new(arg1),
            genesis_done     : false,
            busy             : false,
            keeper           : 0x2::object::id<KeeperCap>(&v2),
            mint_window      : 0,
            mint_window_ms   : 0,
            outflow          : 0x2::vec_map::empty<0x1::type_name::TypeName, Outflow>(),
            open_by_proposer : 0x2::vec_map::empty<address, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<Index<T0>>(v3);
        let v4 = AdminCap{
            id    : 0x2::object::new(arg1),
            index : v1,
        };
        let v5 = GuardianCap{
            id    : 0x2::object::new(arg1),
            index : v1,
        };
        (v4, v5, v2)
    }

    fun decayed_window<T0>(arg0: &Index<T0>, arg1: u64) : u64 {
        if (arg1 >= arg0.mint_window_ms + 86400000) {
            return 0
        };
        let v0 = if (arg1 > arg0.mint_window_ms) {
            arg1 - arg0.mint_window_ms
        } else {
            0
        };
        mul_div(arg0.mint_window, 86400000 - v0, 86400000)
    }

    public fun donate<T0, T1>(arg0: &mut Index<T0>, arg1: 0x2::coin::Coin<T1>) {
        assert_live<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 9);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T1>(arg1));
        let v1 = Donated{
            index  : 0x2::object::id<Index<T0>>(arg0),
            coin   : v0,
            amount : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<Donated>(v1);
    }

    fun drop_target<T0>(arg0: &mut Index<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        assert!(0x2::vec_map::length<0x1::type_name::TypeName, u64>(&arg0.targets) > 1, 25);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.targets, &arg1);
        let (v2, v3) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, u64>(arg0.targets);
        let v4 = v2;
        let (v5, v6) = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::absorb(v3, highs<T0>(arg0, &v4, arg2), 10000);
        let v7 = if (v5) {
            v6
        } else {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::scale_unbounded(v3, 10000)
        };
        arg0.targets = 0x2::vec_map::from_keys_values<0x1::type_name::TypeName, u64>(v4, v7);
    }

    public fun emergency_remove<T0, T1>(arg0: &mut Index<T0>, arg1: &GuardianCap, arg2: &0x2::clock::Clock) {
        assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.targets, &v0), 10);
        drop_target<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
        mark_retiring<T0, T1>(arg0);
        emit_targets<T0>(arg0);
    }

    fun emit_targets<T0>(arg0: &Index<T0>) {
        let (v0, v1) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, u64>(arg0.targets);
        let v2 = TargetsChanged{
            index : 0x2::object::id<Index<T0>>(arg0),
            coins : v0,
            bps   : v1,
        };
        0x2::event::emit<TargetsChanged>(v2);
    }

    public fun flash_mint_begin<T0>(arg0: &mut Index<T0>, arg1: &KeeperCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MintTicket) {
        assert_live<T0>(arg0);
        assert_keeper<T0>(arg0, arg1);
        assert!(arg2 > 0, 4);
        let v0 = supply<T0>(arg0);
        assert!(v0 > 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg0.mint_window = decayed_window<T0>(arg0, v1) + arg2;
        arg0.mint_window_ms = v1;
        arg0.busy = true;
        let v2 = MintTicket{
            index     : 0x2::object::id<Index<T0>>(arg0),
            amount    : arg2,
            gross     : arg2,
            supply    : v0,
            remaining : arg0.held,
            flash     : true,
        };
        (0x2::coin::mint<T0>(&mut arg0.treasury, arg2, arg4), v2)
    }

    public fun flash_mint_finish<T0>(arg0: &mut Index<T0>, arg1: MintTicket) {
        let MintTicket {
            index     : v0,
            amount    : v1,
            gross     : _,
            supply    : _,
            remaining : v4,
            flash     : v5,
        } = arg1;
        let v6 = v4;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(v5, 23);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v6), 8);
        arg0.busy = false;
        let v7 = Minted{
            index       : v0,
            amount      : v1,
            premium_bps : 0,
            flash       : true,
            supply      : supply<T0>(arg0),
        };
        0x2::event::emit<Minted>(v7);
    }

    public fun flash_redeem_begin<T0>(arg0: &mut Index<T0>, arg1: &KeeperCap, arg2: u64) : RedeemTicket {
        assert_live<T0>(arg0);
        assert_keeper<T0>(arg0, arg1);
        assert!(arg2 > 0, 4);
        let v0 = supply<T0>(arg0);
        assert!(arg2 <= v0, 6);
        arg0.busy = true;
        RedeemTicket{
            index     : 0x2::object::id<Index<T0>>(arg0),
            num       : arg2,
            den       : v0,
            remaining : arg0.held,
            debt      : arg2,
        }
    }

    public fun flash_redeem_finish<T0>(arg0: &mut Index<T0>, arg1: RedeemTicket, arg2: 0x2::coin::Coin<T0>) {
        let RedeemTicket {
            index     : v0,
            num       : _,
            den       : _,
            remaining : v3,
            debt      : v4,
        } = arg1;
        let v5 = v3;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(v4 > 0, 23);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v5), 8);
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 >= v4, 22);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg2);
        arg0.busy = false;
        let v7 = Redeemed{
            index   : v0,
            amount  : v4,
            fee_bps : 0,
            flash   : true,
            supply  : supply<T0>(arg0),
        };
        0x2::event::emit<Redeemed>(v7);
        if (v6 > v4) {
            let v8 = Burned{
                index  : v0,
                amount : v6 - v4,
            };
            0x2::event::emit<Burned>(v8);
        };
    }

    public fun genesis_begin<T0>(arg0: &mut Index<T0>, arg1: &AdminCap, arg2: u64) : GenesisTicket {
        assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(!arg0.genesis_done, 11);
        assert!(arg2 > 0, 4);
        arg0.busy = true;
        GenesisTicket{
            index     : 0x2::object::id<Index<T0>>(arg0),
            amount    : arg2,
            total_bps : 0,
        }
    }

    public fun genesis_finish<T0>(arg0: &mut Index<T0>, arg1: GenesisTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let GenesisTicket {
            index     : v0,
            amount    : v1,
            total_bps : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(v2 == 10000, 13);
        arg0.genesis_done = true;
        arg0.busy = false;
        emit_targets<T0>(arg0);
        let v3 = Minted{
            index       : v0,
            amount      : v1,
            premium_bps : 0,
            flash       : false,
            supply      : supply<T0>(arg0),
        };
        0x2::event::emit<Minted>(v3);
        0x2::coin::mint<T0>(&mut arg0.treasury, v1, arg2)
    }

    public fun genesis_put<T0, T1>(arg0: &mut Index<T0>, arg1: &mut GenesisTicket, arg2: 0x2::coin::Coin<T1>, arg3: u64) {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 12);
        assert!(0x2::coin::value<T1>(&arg2) > 0, 4);
        assert!(arg3 >= 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::min_bps() && arg3 <= 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::max_bps(), 13);
        assert!(0x2::vec_map::length<0x1::type_name::TypeName, u64>(&arg0.targets) < 12, 14);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T1>(arg2));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.held, v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.targets, v0, arg3);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.added_ms, v0, 0);
        arg1.total_bps = arg1.total_bps + arg3;
    }

    public fun held<T0>(arg0: &Index<T0>) : vector<0x1::type_name::TypeName> {
        arg0.held
    }

    public(friend) fun held_contains<T0>(arg0: &Index<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, *arg1)
    }

    public(friend) fun high_for<T0>(arg0: &Index<T0>, arg1: &0x1::type_name::TypeName, arg2: u64) : u64 {
        let v0 = added_ms<T0>(arg0, arg1);
        if (v0 > 0 && arg2 < v0 + 30 * 86400000) {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::young_max_bps()
        } else {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::weights::max_bps()
        }
    }

    public(friend) fun highs<T0>(arg0: &Index<T0>, arg1: &vector<0x1::type_name::TypeName>, arg2: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(arg1)) {
            0x1::vector::push_back<u64>(&mut v0, high_for<T0>(arg0, 0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun holding<T0, T1>(arg0: &Index<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0))
    }

    public fun is_busy<T0>(arg0: &Index<T0>) : bool {
        arg0.busy
    }

    public(friend) fun is_retiring<T0>(arg0: &Index<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.retiring, arg1)
    }

    public fun issue_keeper_cap<T0>(arg0: &mut Index<T0>, arg1: &GuardianCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = KeeperCap{
            id    : 0x2::object::new(arg2),
            index : 0x2::object::id<Index<T0>>(arg0),
        };
        arg0.keeper = 0x2::object::id<KeeperCap>(&v0);
        let v1 = KeeperRotated{
            index  : 0x2::object::id<Index<T0>>(arg0),
            keeper : arg0.keeper,
        };
        0x2::event::emit<KeeperRotated>(v1);
        v0
    }

    public fun keeper_swap_begin<T0, T1, T2>(arg0: &mut Index<T0>, arg1: &KeeperCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapTicket) {
        assert_live<T0>(arg0);
        assert_keeper<T0>(arg0, arg1);
        assert!(arg2 > 0, 4);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        assert!(v0 != v1, 16);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 9);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.targets, &v1), 10);
        let v2 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0));
        assert!(arg2 <= v2, 6);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.retiring, &v0)) {
            let v3 = 0x2::clock::timestamp_ms(arg4);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, Outflow>(&arg0.outflow, &v0)) {
                let v4 = Outflow{
                    start_ms      : v3,
                    start_holding : v2,
                    out           : 0,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, Outflow>(&mut arg0.outflow, v0, v4);
            };
            let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Outflow>(&mut arg0.outflow, &v0);
            if (v3 >= v5.start_ms + 86400000) {
                let v6 = Outflow{
                    start_ms      : v3,
                    start_holding : v2,
                    out           : 0,
                };
                *v5 = v6;
            };
            assert!(v5.out + arg2 <= mul_div(v5.start_holding, 2500, 10000), 17);
            v5.out = v5.out + arg2;
        };
        arg0.busy = true;
        let v7 = SwapTicket{
            index     : 0x2::object::id<Index<T0>>(arg0),
            from      : v0,
            to        : v1,
            amount_in : arg2,
            min_out   : arg3,
        };
        (0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg2), arg5), v7)
    }

    public fun keeper_swap_end<T0, T1>(arg0: &mut Index<T0>, arg1: SwapTicket, arg2: 0x2::coin::Coin<T1>) {
        let SwapTicket {
            index     : v0,
            from      : v1,
            to        : v2,
            amount_in : v3,
            min_out   : v4,
        } = arg1;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(0x1::type_name::with_defining_ids<T1>() == v2, 19);
        let v5 = 0x2::coin::value<T1>(&arg2);
        assert!(v5 >= v4, 18);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v2), 0x2::coin::into_balance<T1>(arg2));
        arg0.busy = false;
        let v6 = KeeperSwapped{
            index      : v0,
            from       : v1,
            to         : v2,
            amount_in  : v3,
            amount_out : v5,
        };
        0x2::event::emit<KeeperSwapped>(v6);
    }

    public(friend) fun mark_retiring<T0, T1>(arg0: &mut Index<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.retiring, v0, 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0)));
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.added_ms, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.added_ms, &v0);
        };
    }

    public fun max_coins() : u64 {
        12
    }

    public fun migrate<T0>(arg0: &mut Index<T0>, arg1: &AdminCap) {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(arg0.version < 2, 1);
        arg0.version = 2;
    }

    public fun mint_begin<T0>(arg0: &mut Index<T0>, arg1: u64, arg2: &0x2::clock::Clock) : MintTicket {
        assert_live<T0>(arg0);
        assert!(arg1 > 0, 4);
        let v0 = supply<T0>(arg0);
        assert!(v0 > 0, 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = decayed_window<T0>(arg0, v1) + arg1;
        arg0.mint_window = v2;
        arg0.mint_window_ms = v1;
        arg0.busy = true;
        MintTicket{
            index     : 0x2::object::id<Index<T0>>(arg0),
            amount    : arg1,
            gross     : arg1 + mul_div(arg1, premium_for(v0, v2), 10000),
            supply    : v0,
            remaining : arg0.held,
            flash     : false,
        }
    }

    public fun mint_finish<T0>(arg0: &mut Index<T0>, arg1: MintTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MintTicket {
            index     : v0,
            amount    : v1,
            gross     : v2,
            supply    : _,
            remaining : v4,
            flash     : v5,
        } = arg1;
        let v6 = v4;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(!v5, 24);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v6), 8);
        arg0.busy = false;
        let v7 = Minted{
            index       : v0,
            amount      : v1,
            premium_bps : mul_div(v2 - v1, 10000, v1),
            flash       : false,
            supply      : supply<T0>(arg0),
        };
        0x2::event::emit<Minted>(v7);
        0x2::coin::mint<T0>(&mut arg0.treasury, v1, arg2)
    }

    public fun mint_put<T0, T1>(arg0: &mut Index<T0>, arg1: &mut MintTicket, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &mut arg1.remaining;
        take_key(v1, v0);
        let v2 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0));
        let v3 = mul_div_up(v2, arg1.gross, arg1.supply);
        assert!(0x2::coin::value<T1>(&arg2) >= v3, 6);
        let v4 = 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg3));
        if (!arg1.flash && arg1.gross > arg1.amount) {
            let v5 = mul_div_up(v2, arg1.amount, arg1.supply);
            if (v3 > v5) {
                let v6 = mul_div(v3 - v5, pol_share_bps<T0>(arg0), 10000);
                if (v6 > 0) {
                    pol_join<T0, T1>(arg0, 0x2::balance::split<T1>(&mut v4, v6), arg3);
                };
            };
        };
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), v4);
        arg2
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public(friend) fun pol_balance<T0, T1>(arg0: &Index<T0>) : u64 {
        let v0 = PolCoinsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PolCoinsKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = PolCoinsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<PolCoinsKey, 0x2::bag::Bag>(&arg0.id, v1);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(v2, v3)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v2, v3))
        } else {
            0
        }
    }

    public(friend) fun pol_join<T0, T1>(arg0: &mut Index<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PolCoinsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PolCoinsKey>(&arg0.id, v0)) {
            let v1 = PolCoinsKey{dummy_field: false};
            0x2::dynamic_field::add<PolCoinsKey, 0x2::bag::Bag>(&mut arg0.id, v1, 0x2::bag::new(arg2));
        };
        let v2 = PolCoinsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<PolCoinsKey, 0x2::bag::Bag>(&mut arg0.id, v2);
        let v4 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(v3, v4)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v3, v4), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v3, v4, arg1);
        };
    }

    public(friend) fun pol_share_bps<T0>(arg0: &Index<T0>) : u64 {
        let v0 = PolShareKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PolShareKey>(&arg0.id, v0)) {
            let v2 = PolShareKey{dummy_field: false};
            *0x2::dynamic_field::borrow<PolShareKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public(friend) fun pol_take<T0, T1>(arg0: &mut Index<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T1>()
        };
        let v0 = PolCoinsKey{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(0x2::dynamic_field::borrow_mut<PolCoinsKey, 0x2::bag::Bag>(&mut arg0.id, v0), 0x1::type_name::with_defining_ids<T1>());
        assert!(0x2::balance::value<T1>(v1) >= arg1, 6);
        0x2::balance::split<T1>(v1, arg1)
    }

    fun premium_for(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 2000
        };
        let v0 = (200 as u128) + (1000 as u128) * (arg1 as u128) / (arg0 as u128);
        if (v0 > (2000 as u128)) {
            2000
        } else {
            (v0 as u64)
        }
    }

    public(friend) fun proposer_open<T0>(arg0: &Index<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, 0x2::object::ID>(&arg0.open_by_proposer, &arg1)
    }

    public fun quarantine<T0, T1>(arg0: &mut Index<T0>, arg1: &GuardianCap, arg2: &0x2::clock::Clock) {
        assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 9);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.held) > 1, 25);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.targets, &v0)) {
            drop_target<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
            emit_targets<T0>(arg0);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.retiring, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.retiring, &v0);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.added_ms, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.added_ms, &v0);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Outflow>(&arg0.outflow, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Outflow>(&mut arg0.outflow, &v0);
        };
        let (_, v8) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.held, &v0);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.held, v8);
        let v9 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.quarantine, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.quarantine, v0), v9);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.quarantine, v0, v9);
        };
        let v10 = Quarantined{
            index    : 0x2::object::id<Index<T0>>(arg0),
            coin     : v0,
            amount   : 0x2::balance::value<T1>(&v9),
            released : false,
        };
        0x2::event::emit<Quarantined>(v10);
    }

    public fun quarantined<T0, T1>(arg0: &Index<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.quarantine, v0)) {
            return 0
        };
        0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.quarantine, v0))
    }

    public fun quote_premium_bps<T0>(arg0: &Index<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        premium_for(supply<T0>(arg0), decayed_window<T0>(arg0, 0x2::clock::timestamp_ms(arg2)) + arg1)
    }

    public(friend) fun raised_ms<T0>(arg0: &Index<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.raised_ms, arg1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.raised_ms, arg1)
        } else {
            0
        }
    }

    public fun redeem_begin<T0>(arg0: &mut Index<T0>, arg1: 0x2::coin::Coin<T0>) : RedeemTicket {
        assert_live<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        arg0.busy = true;
        RedeemTicket{
            index     : 0x2::object::id<Index<T0>>(arg0),
            num       : v0 - mul_div_up(v0, 100, 10000),
            den       : supply<T0>(arg0),
            remaining : arg0.held,
            debt      : 0,
        }
    }

    public fun redeem_claim<T0, T1>(arg0: &mut Index<T0>, arg1: &mut RedeemTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &mut arg1.remaining;
        take_key(v1, v0);
        let v2 = 0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0));
        let v3 = mul_div(v2, arg1.num, arg1.den);
        if (arg1.debt == 0) {
            let v4 = mul_div(mul_div(v3, 100, 10000 - 100), pol_share_bps<T0>(arg0), 10000);
            if (v4 > 0 && v3 + v4 <= v2) {
                let v5 = 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), v4);
                pol_join<T0, T1>(arg0, v5, arg2);
            };
        };
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), v3), arg2)
    }

    public fun redeem_fee_bps() : u64 {
        100
    }

    public fun redeem_finish<T0>(arg0: &mut Index<T0>, arg1: RedeemTicket) {
        let RedeemTicket {
            index     : v0,
            num       : v1,
            den       : _,
            remaining : v3,
            debt      : v4,
        } = arg1;
        let v5 = v3;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 3);
        assert!(v4 == 0, 24);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v5), 8);
        arg0.busy = false;
        let v6 = Redeemed{
            index   : v0,
            amount  : v1,
            fee_bps : 100,
            flash   : false,
            supply  : supply<T0>(arg0),
        };
        0x2::event::emit<Redeemed>(v6);
    }

    public fun release<T0, T1>(arg0: &mut Index<T0>, arg1: &GuardianCap) {
        assert_live<T0>(arg0);
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.quarantine, v0), 26);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.quarantine, v0);
        let v2 = 0x2::balance::value<T1>(&v1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), v1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0, v1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.held, v0);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.retiring, v0, v2);
        };
        let v3 = Quarantined{
            index    : 0x2::object::id<Index<T0>>(arg0),
            coin     : v0,
            amount   : v2,
            released : true,
        };
        0x2::event::emit<Quarantined>(v3);
    }

    public fun retire<T0, T1>(arg0: &mut Index<T0>) {
        assert_live<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.retiring, &v0), 20);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.retiring, &v0);
        let v3 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0);
        let v4 = 0x2::balance::value<T1>(&v3);
        assert!((v4 as u128) * (10000 as u128) <= (v2 as u128) * (10 as u128), 21);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.graveyard, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.graveyard, v0), v3);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.graveyard, v0, v3);
        };
        let (v5, v6) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.held, &v0);
        assert!(v5, 9);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.held, v6);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Outflow>(&arg0.outflow, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Outflow>(&mut arg0.outflow, &v0);
        };
        let v9 = CoinRetired{
            index : 0x2::object::id<Index<T0>>(arg0),
            coin  : v0,
            dust  : v4,
        };
        0x2::event::emit<CoinRetired>(v9);
    }

    public fun retiring<T0>(arg0: &Index<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        arg0.retiring
    }

    public(friend) fun set_busy<T0>(arg0: &mut Index<T0>, arg1: bool) {
        arg0.busy = arg1;
    }

    public(friend) fun set_pol_share_bps<T0>(arg0: &mut Index<T0>, arg1: u64) {
        let v0 = PolShareKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PolShareKey>(&arg0.id, v0)) {
            let v1 = PolShareKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<PolShareKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = PolShareKey{dummy_field: false};
            0x2::dynamic_field::add<PolShareKey, u64>(&mut arg0.id, v2, arg1);
        };
    }

    public(friend) fun set_proposer_open<T0>(arg0: &mut Index<T0>, arg1: address, arg2: 0x2::object::ID) {
        0x2::vec_map::insert<address, 0x2::object::ID>(&mut arg0.open_by_proposer, arg1, arg2);
    }

    public(friend) fun set_raised<T0>(arg0: &mut Index<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.raised_ms, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.raised_ms, &arg1);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.raised_ms, arg1, arg2);
    }

    public(friend) fun set_targets<T0>(arg0: &mut Index<T0>, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        arg0.targets = arg1;
        emit_targets<T0>(arg0);
    }

    public fun supply<T0>(arg0: &Index<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    fun take_key(arg0: &mut vector<0x1::type_name::TypeName>, arg1: 0x1::type_name::TypeName) {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(arg0, &arg1);
        assert!(v0, 7);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(arg0, v1);
    }

    public fun targets<T0>(arg0: &Index<T0>) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        arg0.targets
    }

    public(friend) fun uid<T0>(arg0: &Index<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0>(arg0: &mut Index<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun update_metadata<T0>(arg0: &Index<T0>, arg1: &AdminCap, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        assert!(arg1.index == 0x2::object::id<Index<T0>>(arg0), 3);
        0x2::coin::update_name<T0>(&arg0.treasury, arg2, arg3);
        0x2::coin::update_description<T0>(&arg0.treasury, arg2, arg4);
        0x2::coin::update_icon_url<T0>(&arg0.treasury, arg2, arg5);
    }

    public(friend) fun vault_burn<T0>(arg0: &mut Index<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury), arg1);
    }

    public(friend) fun vault_join<T0, T1>(arg0: &mut Index<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 9);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1);
    }

    public(friend) fun vault_mint<T0>(arg0: &mut Index<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::coin::mint_balance<T0>(&mut arg0.treasury, arg1)
    }

    public(friend) fun version_ok<T0>(arg0: &Index<T0>) {
        assert!(arg0.version == 2, 1);
    }

    // decompiled from Move bytecode v7
}

