module 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidityPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        max_total_assets: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        total_assets: 0x2::balance::Balance<T1>,
        histories: 0x2::table::Table<address, vector<vector<u8>>>,
    }

    struct Deposited has copy, drop {
        assets: u64,
        shares: u64,
        before_total_assets: u64,
        after_total_assets: u64,
        before_total_shares: u64,
        after_total_shares: u64,
    }

    struct Redeemed has copy, drop {
        assets: u64,
        shares: u64,
        before_total_assets: u64,
        after_total_assets: u64,
        before_total_shares: u64,
        after_total_shares: u64,
    }

    struct Put has copy, drop {
        assets: u64,
        before_total_assets: u64,
        after_total_assets: u64,
    }

    struct Taken has copy, drop {
        assets: u64,
        before_total_assets: u64,
        after_total_assets: u64,
    }

    fun add_lp_history<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, vector<vector<u8>>>(&arg0.histories, 0x2::tx_context::sender(arg1))) {
            0x2::table::add<address, vector<vector<u8>>>(&mut arg0.histories, 0x2::tx_context::sender(arg1), vector[]);
        };
        let v0 = 0x2::table::borrow_mut<address, vector<vector<u8>>>(&mut arg0.histories, 0x2::tx_context::sender(arg1));
        if (0x1::vector::length<vector<u8>>(v0) >= 1000) {
            0x1::vector::remove<vector<u8>>(v0, 0);
        };
        0x1::vector::push_back<vector<u8>>(v0, *0x2::tx_context::digest(arg1));
    }

    fun assets_to_shares<T0, T1>(arg0: &LiquidityPool<T0, T1>, arg1: u64) : u64 {
        let v0 = (get_total_shares<T0, T1>(arg0) as u256);
        if (v0 == 0) {
            arg1
        } else {
            let v2 = 0x1::u256::try_as_u64((arg1 as u256) * v0 / (get_total_assets<T0, T1>(arg0) as u256));
            0x1::option::extract<u64>(&mut v2)
        }
    }

    entry fun create_liquidity_pool<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidityPool<T0, T1>{
            id               : 0x2::object::new(arg3),
            max_total_assets : arg2,
            treasury_cap     : arg1,
            total_assets     : 0x2::balance::zero<T1>(),
            histories        : 0x2::table::new<address, vector<vector<u8>>>(arg3),
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1>>(v0);
    }

    entry fun deposit<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg3: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg2, 1);
        let v0 = get_total_assets<T0, T1>(arg0);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 13906834530826125320);
        assert!(v0 + 0x2::coin::value<T1>(&arg1) <= arg0.max_total_assets, 13906834535120961542);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = assets_to_shares<T0, T1>(arg0, v1);
        let v3 = get_total_shares<T0, T1>(arg0);
        0x2::coin::mint_and_transfer<T0>(&mut arg0.treasury_cap, v2, 0x2::tx_context::sender(arg3), arg3);
        0x2::balance::join<T1>(&mut arg0.total_assets, 0x2::coin::into_balance<T1>(arg1));
        add_lp_history<T0, T1>(arg0, arg3);
        let v4 = Deposited{
            assets              : v1,
            shares              : v2,
            before_total_assets : v0,
            after_total_assets  : get_total_assets<T0, T1>(arg0),
            before_total_shares : v3,
            after_total_shares  : get_total_shares<T0, T1>(arg0),
        };
        0x2::event::emit<Deposited>(v4);
    }

    public fun get_total_assets<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.total_assets)
    }

    public fun get_total_shares<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public fun get_user_histories<T0, T1>(arg0: &LiquidityPool<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : vector<vector<u8>> {
        if (!0x2::table::contains<address, vector<vector<u8>>>(&arg0.histories, 0x2::tx_context::sender(arg4))) {
            return vector[]
        };
        let v0 = 0x2::table::borrow<address, vector<vector<u8>>>(&arg0.histories, 0x2::tx_context::sender(arg4));
        let v1 = 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::pagination::get_limit(arg2, 100);
        let v2 = 0xf6b668302a8d006e599bf2c9bf7377e631db1a04d30158fd5478b079e92bced8::pagination::get_page_based_index<vector<u8>>(v0, arg1, v1, arg3);
        if (0x1::option::is_none<u64>(&v2)) {
            return vector[]
        };
        let v3 = 0x1::option::destroy_some<u64>(v2);
        let v4 = vector[];
        loop {
            let v5 = if (0x1::vector::length<vector<u8>>(&v4) < v1) {
                if (v3 >= 0) {
                    v3 < 0x1::vector::length<vector<u8>>(v0)
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                0x1::vector::push_back<vector<u8>>(&mut v4, *0x1::vector::borrow<vector<u8>>(v0, v3));
                if (arg3 && v3 == 0) {
                    break
                };
                if (arg3) {
                    v3 = v3 - 1;
                    continue
                };
                v3 = v3 + 1;
            } else {
                break
            };
        };
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun put<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg3: &ManagerCap) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg2, 1);
        assert!(0x2::balance::value<T1>(&arg1) > 0, 13906834956027887624);
        0x2::balance::join<T1>(&mut arg0.total_assets, arg1);
        let v0 = Put{
            assets              : 0x2::balance::value<T1>(&arg1),
            before_total_assets : get_total_assets<T0, T1>(arg0),
            after_total_assets  : get_total_assets<T0, T1>(arg0),
        };
        0x2::event::emit<Put>(v0);
    }

    entry fun redeem<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg3: &mut 0x2::tx_context::TxContext) {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg2, 1);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 13906834672560046088);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = shares_to_assets<T0, T1>(arg0, v0);
        let v2 = get_total_assets<T0, T1>(arg0);
        let v3 = get_total_shares<T0, T1>(arg0);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.total_assets, v1), arg3), 0x2::tx_context::sender(arg3));
        add_lp_history<T0, T1>(arg0, arg3);
        let v4 = Redeemed{
            assets              : v1,
            shares              : v0,
            before_total_assets : v2,
            after_total_assets  : get_total_assets<T0, T1>(arg0),
            before_total_shares : v3,
            after_total_shares  : get_total_shares<T0, T1>(arg0),
        };
        0x2::event::emit<Redeemed>(v4);
    }

    fun shares_to_assets<T0, T1>(arg0: &LiquidityPool<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x1::u256::try_as_u64((arg1 as u256) * (get_total_assets<T0, T1>(arg0) as u256) / (get_total_shares<T0, T1>(arg0) as u256));
        0x1::option::extract<u64>(&mut v0)
    }

    public fun take<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: u64, arg2: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg3: &ManagerCap) : 0x2::balance::Balance<T1> {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg2, 1);
        assert!(arg1 > 0, 13906835041927233544);
        assert!(0x2::balance::value<T1>(&arg0.total_assets) >= arg1, 13906835046221938692);
        let v0 = Taken{
            assets              : arg1,
            before_total_assets : get_total_assets<T0, T1>(arg0),
            after_total_assets  : get_total_assets<T0, T1>(arg0),
        };
        0x2::event::emit<Taken>(v0);
        0x2::balance::split<T1>(&mut arg0.total_assets, arg1)
    }

    entry fun update_liquidity_pool<T0, T1>(arg0: &AdminCap, arg1: &mut LiquidityPool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.max_total_assets = arg2;
    }

    // decompiled from Move bytecode v6
}

