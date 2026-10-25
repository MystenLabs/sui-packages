module 0x6e510bd8e8846ab9fd735bc1175ffba813cc13d39cab5108033ff69ed4f0557c::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Pair has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    struct Feed has copy, drop, store {
        obj: 0x2::object::ID,
        feed: vector<u8>,
        decimals: u8,
    }

    struct Limits has copy, drop, store {
        tx_loss: u64,
        daily_loss: u64,
        max_debt: u64,
        max_ltv_bps: u64,
        max_age_s: u64,
        max_conf_bps: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        operator: 0x2::object::ID,
        open: bool,
        coins: 0x2::bag::Bag,
        objects: 0x2::object_bag::ObjectBag,
        pools: 0x2::vec_map::VecMap<0x2::object::ID, Pair>,
        feeds: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Feed>,
        navi: 0x2::vec_map::VecMap<u8, 0x1::type_name::TypeName>,
        navi_storage: 0x2::object::ID,
        suilend_market: 0x2::object::ID,
        limits: Limits,
        last_ms: u64,
        lost: u64,
    }

    struct Pos has copy, drop {
        pair: Pair,
        sa: u256,
        sb: u256,
        l: u128,
    }

    struct Px has copy, drop, store {
        lo: u256,
        mid: u256,
        hi: u256,
    }

    struct Acct has drop {
        t: vector<0x1::type_name::TypeName>,
        s: vector<u256>,
        b: vector<u256>,
    }

    struct Receipt {
        vault: 0x2::object::ID,
        px: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Px>,
        inn: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        out: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        pos_in: vector<Pos>,
        pos_out: vector<Pos>,
        owed: vector<0x2::object::ID>,
        debts: vector<Acct>,
    }

    struct Finished has copy, drop {
        vault: 0x2::object::ID,
        gain_usd6: u64,
        loss_usd6: u64,
        lost_today_usd6: u64,
    }

    fun add(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg1: 0x1::type_name::TypeName, arg2: u256) {
        if (arg2 == 0) {
            return
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(arg0, &arg1) = *0x2::vec_map::get<0x1::type_name::TypeName, u256>(arg0, &arg1) + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(arg0, arg1, arg2);
        };
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (Vault, AdminCap) {
        let v0 = Limits{
            tx_loss      : 0,
            daily_loss   : 0,
            max_debt     : 0,
            max_ltv_bps  : 0,
            max_age_s    : 0,
            max_conf_bps : 0,
        };
        let v1 = Vault{
            id             : 0x2::object::new(arg0),
            operator       : 0x2::object::id_from_address(@0x0),
            open           : false,
            coins          : 0x2::bag::new(arg0),
            objects        : 0x2::object_bag::new(arg0),
            pools          : 0x2::vec_map::empty<0x2::object::ID, Pair>(),
            feeds          : 0x2::vec_map::empty<0x1::type_name::TypeName, Feed>(),
            navi           : 0x2::vec_map::empty<u8, 0x1::type_name::TypeName>(),
            navi_storage   : 0x2::object::id_from_address(@0x0),
            suilend_market : 0x2::object::id_from_address(@0x0),
            limits         : v0,
            last_ms        : 0,
            lost           : 0,
        };
        let v2 = AdminCap{
            id    : 0x2::object::new(arg0),
            vault : 0x2::object::id<Vault>(&v1),
        };
        (v1, v2)
    }

    fun join<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.coins, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0, arg1);
        };
    }

    public fun price<T0>(arg0: &Vault, arg1: &mut Receipt, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        check(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, Feed>(&arg0.feeds, &v0), 5);
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, Px>(&arg1.px, &v0), 9);
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, Feed>(&arg0.feeds, &v0);
        assert!(0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2) == v1.obj, 6);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg2);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v2));
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v3);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v3);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5), 6);
        let v6 = (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5) as u256);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 <= 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v3) + arg0.limits.max_age_s, 7);
        assert!((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v3) as u256) * 10000 <= v6 * (arg0.limits.max_conf_bps as u256), 8);
        let (v7, v8) = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4)) {
            (30, (v1.decimals as u64) + 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v4))
        } else {
            (30 + 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4), (v1.decimals as u64))
        };
        let v9 = (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v3) as u256);
        let v10 = scale(v6 - v9, v7, v8);
        assert!(v10 > 0, 6);
        let v11 = Px{
            lo  : v10,
            mid : scale(v6, v7, v8),
            hi  : scale(v6 + v9, v7, v8),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Px>(&mut arg1.px, v0, v11);
    }

    fun admin(arg0: &AdminCap, arg1: &Vault) {
        assert!(arg0.vault == 0x2::object::id<Vault>(arg1), 0);
    }

    public fun allow_pool<T0, T1>(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        admin(arg0, arg1);
        let v0 = &mut arg1.pools;
        let v1 = Pair{
            a : 0x1::type_name::with_defining_ids<T0>(),
            b : 0x1::type_name::with_defining_ids<T1>(),
        };
        upsert<0x2::object::ID, Pair>(v0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), v1);
    }

    public fun begin(arg0: &mut Vault, arg1: &OperatorCap) : Receipt {
        assert!(0x2::object::id<OperatorCap>(arg1) == arg0.operator, 1);
        assert!(!arg0.open, 2);
        arg0.open = true;
        Receipt{
            vault   : 0x2::object::id<Vault>(arg0),
            px      : 0x2::vec_map::empty<0x1::type_name::TypeName, Px>(),
            inn     : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            out     : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            pos_in  : 0x1::vector::empty<Pos>(),
            pos_out : 0x1::vector::empty<Pos>(),
            owed    : 0x1::vector::empty<0x2::object::ID>(),
            debts   : 0x1::vector::empty<Acct>(),
        }
    }

    fun book(arg0: &mut Receipt, arg1: Acct, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1.t)) {
            let (v1, v2) = if (arg2) {
                (&mut arg0.inn, &mut arg0.out)
            } else {
                (&mut arg0.out, &mut arg0.inn)
            };
            add(v1, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.t, v0), *0x1::vector::borrow<u256>(&arg1.s, v0));
            add(v2, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.t, v0), *0x1::vector::borrow<u256>(&arg1.b, v0));
            v0 = v0 + 1;
        };
        if (arg2) {
            0x1::vector::push_back<Acct>(&mut arg0.debts, arg1);
        };
    }

    fun check(arg0: &Vault, arg1: &Receipt) {
        assert!(arg1.vault == 0x2::object::id<Vault>(arg0), 3);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let (v0, v1) = new(arg0);
        0x2::transfer::share_object<Vault>(v0);
        v1
    }

    public fun deposit_balance<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::balance::Balance<T0>) {
        admin(arg0, arg1);
        join<T0>(arg1, arg2);
    }

    public fun deposit_object<T0: store + key>(arg0: &AdminCap, arg1: &mut Vault, arg2: T0) {
        admin(arg0, arg1);
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg1.objects, 0x2::object::id<T0>(&arg2), arg2);
    }

    public fun disallow_pool(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID) {
        admin(arg0, arg1);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, Pair>(&mut arg1.pools, &arg2);
    }

    public fun finish(arg0: &mut Vault, arg1: Receipt, arg2: &0x2::clock::Clock) {
        check(arg0, &arg1);
        let Receipt {
            vault   : v0,
            px      : v1,
            inn     : v2,
            out     : v3,
            pos_in  : v4,
            pos_out : v5,
            owed    : v6,
            debts   : v7,
        } = arg1;
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = v1;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v9), 11);
        let v13 = v3;
        let v14 = v2;
        let v15 = &mut v13;
        positions(&v12, &v10, v15, true);
        let v16 = &mut v14;
        positions(&v12, &v11, v16, false);
        let v17 = &v8;
        let v18 = 0;
        while (v18 < 0x1::vector::length<Acct>(v17)) {
            let v19 = 0x1::vector::borrow<Acct>(v17, v18);
            let v20 = 0;
            let v21 = 0;
            let v22 = 0;
            while (v22 < 0x1::vector::length<0x1::type_name::TypeName>(&v19.t)) {
                if (*0x1::vector::borrow<u256>(&v19.b, v22) > 0) {
                    let v23 = mark(&v12, 0x1::vector::borrow<0x1::type_name::TypeName>(&v19.t, v22));
                    v21 = v21 + *0x1::vector::borrow<u256>(&v19.b, v22) * v23.hi;
                };
                if (*0x1::vector::borrow<u256>(&v19.s, v22) > 0 && 0x2::vec_map::contains<0x1::type_name::TypeName, Px>(&v12, 0x1::vector::borrow<0x1::type_name::TypeName>(&v19.t, v22))) {
                    v20 = v20 + *0x1::vector::borrow<u256>(&v19.s, v22) * 0x2::vec_map::get<0x1::type_name::TypeName, Px>(&v12, 0x1::vector::borrow<0x1::type_name::TypeName>(&v19.t, v22)).lo;
                };
                v22 = v22 + 1;
            };
            assert!(v21 <= (arg0.limits.max_debt as u256) * 1000000000000000000000000, 14);
            assert!(v21 * 10000 <= v20 * (arg0.limits.max_ltv_bps as u256), 17);
            v18 = v18 + 1;
        };
        let v24 = 0;
        let v25 = 0;
        let v26 = 0;
        while (v26 < 0x2::vec_map::length<0x1::type_name::TypeName, u256>(&v13)) {
            let (v27, v28) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&v13, v26);
            let v29 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&v14, v27)) {
                let (_, v31) = 0x2::vec_map::remove<0x1::type_name::TypeName, u256>(&mut v14, v27);
                v31
            } else {
                0
            };
            let v32 = mark(&v12, v27);
            if (v29 >= *v28) {
                v25 = v25 + (v29 - *v28) * v32.lo;
            } else {
                v24 = v24 + (*v28 - v29) * v32.hi;
            };
            v26 = v26 + 1;
        };
        let v33 = 0;
        while (v33 < 0x2::vec_map::length<0x1::type_name::TypeName, u256>(&v14)) {
            let (v34, v35) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u256>(&v14, v33);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, Px>(&v12, v34)) {
                v25 = v25 + *v35 * 0x2::vec_map::get<0x1::type_name::TypeName, Px>(&v12, v34).lo;
            };
            v33 = v33 + 1;
        };
        let v36 = if (v24 > v25) {
            (((v24 - v25 + 1000000000000000000000000 - 1) / 1000000000000000000000000) as u64)
        } else {
            0
        };
        assert!(v36 <= arg0.limits.tx_loss, 12);
        let v37 = 0x2::clock::timestamp_ms(arg2);
        let v38 = ((v37 - arg0.last_ms) as u256) * (arg0.limits.daily_loss as u256) / (86400000 as u256);
        let v39 = if (v38 >= (arg0.lost as u256)) {
            0
        } else {
            arg0.lost - (v38 as u64)
        };
        arg0.lost = v39;
        arg0.last_ms = v37;
        arg0.lost = arg0.lost + v36;
        assert!(arg0.lost <= arg0.limits.daily_loss, 13);
        arg0.open = false;
        let v40 = Finished{
            vault           : v0,
            gain_usd6       : ((v25 / 1000000000000000000000000) as u64),
            loss_usd6       : v36,
            lost_today_usd6 : arg0.lost,
        };
        0x2::event::emit<Finished>(v40);
    }

    fun mark(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, Px>, arg1: &0x1::type_name::TypeName) : Px {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, Px>(arg0, arg1), 10);
        *0x2::vec_map::get<0x1::type_name::TypeName, Px>(arg0, arg1)
    }

    fun mint_operator(arg0: &AdminCap, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) : OperatorCap {
        admin(arg0, arg1);
        let v0 = OperatorCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<Vault>(arg1),
        };
        arg1.operator = 0x2::object::id<OperatorCap>(&v0);
        v0
    }

    fun navi(arg0: &Vault, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: address) : Acct {
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1) == arg0.navi_storage, 16);
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg1, arg2);
        let v2 = v1;
        0x1::vector::reverse<u8>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v2);
            assert!(0x2::vec_map::contains<u8, 0x1::type_name::TypeName>(&arg0.navi, &v4), 15);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u8>(v2);
        let v5 = Acct{
            t : 0x1::vector::empty<0x1::type_name::TypeName>(),
            s : vector[],
            b : vector[],
        };
        let v6 = 0;
        while (v6 < 0x2::vec_map::length<u8, 0x1::type_name::TypeName>(&arg0.navi)) {
            let (v7, v8) = 0x2::vec_map::get_entry_by_idx<u8, 0x1::type_name::TypeName>(&arg0.navi, v6);
            let (v9, v10) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, *v7, arg2);
            let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, *v7);
            let v13 = 0x1::u256::pow(10, 0x2::vec_map::get<0x1::type_name::TypeName, Feed>(&arg0.feeds, v8).decimals);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5.t, *v8);
            0x1::vector::push_back<u256>(&mut v5.s, v9 * v11 / 1000000000000000000000000000 * v13 / 1000000000);
            0x1::vector::push_back<u256>(&mut v5.b, (v10 * v12 / 1000000000000000000000000000 * v13 + 999999999) / 1000000000);
            v6 = v6 + 1;
        };
        v5
    }

    public fun new_operator(arg0: &AdminCap, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OperatorCap>(mint_operator(arg0, arg1, arg3), arg2);
    }

    fun owed(arg0: &mut Receipt, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.owed, &arg1);
        assert!(v0, 11);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.owed, v1);
    }

    fun pos(arg0: &Vault, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : Pos {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, Pair>(&arg0.pools, &v0), 4);
        Pos{
            pair : *0x2::vec_map::get<0x2::object::ID, Pair>(&arg0.pools, &v0),
            sa   : sqrt_at(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1)),
            sb   : sqrt_at(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1)),
            l    : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg1),
        }
    }

    fun positions(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, Px>, arg1: &vector<Pos>, arg2: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg3: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Pos>(arg1)) {
            let v1 = 0x1::vector::borrow<Pos>(arg1, v0);
            let v2 = 0x2::vec_map::contains<0x1::type_name::TypeName, Px>(arg0, &v1.pair.a) && 0x2::vec_map::contains<0x1::type_name::TypeName, Px>(arg0, &v1.pair.b);
            let v3 = if (v2) {
                true
            } else if (!arg3) {
                true
            } else {
                v1.l == 0
            };
            assert!(v3, 10);
            if (v2 && v1.l > 0) {
                let v4 = (v1.l as u256);
                let v5 = 0x1::u256::min(0x1::u256::max(sqrt((0x2::vec_map::get<0x1::type_name::TypeName, Px>(arg0, &v1.pair.a).mid << 128) / 0x2::vec_map::get<0x1::type_name::TypeName, Px>(arg0, &v1.pair.b).mid), v1.sa), v1.sb);
                add(arg2, v1.pair.a, (v4 << 64) / v5 - (v4 << 64) / v1.sb);
                add(arg2, v1.pair.b, v4 * (v5 - v1.sa) >> 64);
            };
            v0 = v0 + 1;
        };
    }

    public fun put_balance<T0>(arg0: &mut Vault, arg1: &mut Receipt, arg2: 0x2::balance::Balance<T0>) {
        check(arg0, arg1);
        let v0 = &mut arg1.inn;
        add(v0, 0x1::type_name::with_defining_ids<T0>(), (0x2::balance::value<T0>(&arg2) as u256));
        join<T0>(arg0, arg2);
    }

    public fun put_navi(arg0: &mut Vault, arg1: &mut Receipt, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        check(arg0, arg1);
        let v0 = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg2);
        owed(arg1, v0);
        book(arg1, navi(arg0, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg2)), true);
        0x2::object_bag::add<0x2::object::ID, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.objects, v0, arg2);
    }

    public fun put_position(arg0: &mut Vault, arg1: &mut Receipt, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        check(arg0, arg1);
        0x1::vector::push_back<Pos>(&mut arg1.pos_in, pos(arg0, &arg2));
        0x2::object_bag::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.objects, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2), arg2);
    }

    public fun put_suilend<T0>(arg0: &mut Vault, arg1: &mut Receipt, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        check(arg0, arg1);
        let v0 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&arg2);
        owed(arg1, v0);
        book(arg1, suilend<T0>(arg0, arg3, &arg2), true);
        0x2::object_bag::add<0x2::object::ID, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&mut arg0.objects, v0, arg2);
    }

    public fun revoke(arg0: &AdminCap, arg1: &mut Vault) {
        admin(arg0, arg1);
        arg1.operator = 0x2::object::id_from_address(@0x0);
    }

    fun scale(arg0: u256, arg1: u64, arg2: u64) : u256 {
        if (arg1 >= arg2) {
            arg0 * 0x1::u256::pow(10, ((arg1 - arg2) as u8))
        } else {
            arg0 / 0x1::u256::pow(10, ((arg2 - arg1) as u8))
        }
    }

    public fun set_feed<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: vector<u8>, arg4: u8) {
        admin(arg0, arg1);
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price_identifier(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0));
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1) == arg3, 6);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg2);
        let v4 = 0;
        while (v4 < 0x2::vec_map::length<0x1::type_name::TypeName, Feed>(&arg1.feeds)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, Feed>(&arg1.feeds, v4);
            assert!(*v5 == v2 || v6.obj != v3 && v6.feed != arg3, 18);
            v4 = v4 + 1;
        };
        let v7 = &mut arg1.feeds;
        let v8 = Feed{
            obj      : v3,
            feed     : arg3,
            decimals : arg4,
        };
        upsert<0x1::type_name::TypeName, Feed>(v7, v2, v8);
    }

    public fun set_limits(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        admin(arg0, arg1);
        let v0 = Limits{
            tx_loss      : arg2,
            daily_loss   : arg3,
            max_debt     : arg4,
            max_ltv_bps  : arg5,
            max_age_s    : arg6,
            max_conf_bps : arg7,
        };
        arg1.limits = v0;
    }

    public fun set_navi_asset<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8) {
        admin(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, Feed>(&arg1.feeds, &v0), 5);
        assert!(0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2) == arg1.navi_storage, 16);
        let (_, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg2, arg3);
        let v3 = &mut arg1.navi;
        upsert<u8, 0x1::type_name::TypeName>(v3, arg3, v0);
    }

    public fun set_navi_storage(arg0: &AdminCap, arg1: &mut Vault, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        admin(arg0, arg1);
        arg1.navi_storage = 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2);
    }

    public fun set_suilend_market<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        admin(arg0, arg1);
        arg1.suilend_market = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2);
    }

    fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 >> 1) + (arg0 & 1);
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 >> 1;
        };
        arg0
    }

    fun sqrt_at(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u256 {
        let v0 = 340265354078544963557816517032075149313;
        let v1 = 340282366920938463463374607431768211456;
        let v2 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) as u64);
        while (v2 > 0) {
            if (v2 & 1 == 1) {
                let v3 = v1 * v0;
                v1 = v3 >> 128;
            };
            let v4 = v0 * v0;
            v0 = v4 >> 128;
            v2 = v2 >> 1;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0)) {
            v1 >> 64
        } else {
            6277101735386680763835789423207666416102355444464034512896 / v1
        }
    }

    fun suilend<T0>(arg0: &Vault, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>) : Acct {
        assert!(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1) == arg0.suilend_market, 16);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(arg2));
        let v1 = Acct{
            t : 0x1::vector::empty<0x1::type_name::TypeName>(),
            s : vector[],
            b : vector[],
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v2)) {
            let v4 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v2, v3);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.t, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_coin_type(v4));
            0x1::vector::push_back<u256>(&mut v1.s, (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v4) as u256) * 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v4)))) / 1000000000000000000);
            0x1::vector::push_back<u256>(&mut v1.b, 0);
            v3 = v3 + 1;
        };
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v5)) {
            let v7 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v5, v6);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.t, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_coin_type(v7));
            0x1::vector::push_back<u256>(&mut v1.s, 0);
            0x1::vector::push_back<u256>(&mut v1.b, (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v7)) + 1000000000000000000 - 1) / 1000000000000000000);
            v6 = v6 + 1;
        };
        v1
    }

    public fun take_balance<T0>(arg0: &mut Vault, arg1: &mut Receipt) : 0x2::balance::Balance<T0> {
        check(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.coins, v0);
        let v2 = &mut arg1.out;
        add(v2, v0, (0x2::balance::value<T0>(&v1) as u256));
        v1
    }

    public fun take_navi(arg0: &mut Vault, arg1: &mut Receipt, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: 0x2::object::ID) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        check(arg0, arg1);
        let v0 = 0x2::object_bag::remove<0x2::object::ID, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.objects, arg3);
        book(arg1, navi(arg0, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v0)), false);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.owed, arg3);
        v0
    }

    public fun take_position(arg0: &mut Vault, arg1: &mut Receipt, arg2: 0x2::object::ID) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        check(arg0, arg1);
        let v0 = 0x2::object_bag::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.objects, arg2);
        0x1::vector::push_back<Pos>(&mut arg1.pos_out, pos(arg0, &v0));
        v0
    }

    public fun take_suilend<T0>(arg0: &mut Vault, arg1: &mut Receipt, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x2::object::ID) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        check(arg0, arg1);
        let v0 = 0x2::object_bag::remove<0x2::object::ID, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(&mut arg0.objects, arg3);
        book(arg1, suilend<T0>(arg0, arg2, &v0), false);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.owed, arg3);
        v0
    }

    fun upsert<T0: copy + drop, T1: drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: T0, arg2: T1) {
        if (0x2::vec_map::contains<T0, T1>(arg0, &arg1)) {
            *0x2::vec_map::get_mut<T0, T1>(arg0, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<T0, T1>(arg0, arg1, arg2);
        };
    }

    public fun withdraw_balance<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64) : 0x2::balance::Balance<T0> {
        admin(arg0, arg1);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.coins, 0x1::type_name::with_defining_ids<T0>()), arg2)
    }

    public fun withdraw_object<T0: store + key>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID) : T0 {
        admin(arg0, arg1);
        0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg1.objects, arg2)
    }

    // decompiled from Move bytecode v7
}

