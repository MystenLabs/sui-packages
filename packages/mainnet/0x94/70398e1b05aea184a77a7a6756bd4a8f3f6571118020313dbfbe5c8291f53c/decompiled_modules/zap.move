module 0x9470398e1b05aea184a77a7a6756bd4a8f3f6571118020313dbfbe5c8291f53c::zap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        keepers: 0x2::vec_set::VecSet<address>,
        max_wait_ms: u64,
    }

    struct Zap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
        user: address,
        market: 0x2::object::ID,
        order: u64,
        meme: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
        min_meme: u64,
        deadline_ms: u64,
        created_ms: u64,
        state: u8,
        meme_out: u64,
        shares_out: u64,
        usdc_out: u64,
    }

    struct Delivery<phantom T0, phantom T1> {
        zap: 0x2::object::ID,
        user: address,
        min_meme: u64,
        taken: u64,
    }

    struct ZapStarted has copy, drop {
        zap: 0x2::object::ID,
        user: address,
        market: 0x2::object::ID,
        order: u64,
        meme: 0x1::type_name::TypeName,
        pool: 0x2::object::ID,
        paid: u64,
        min_raw: u64,
        min_meme: u64,
        deadline_ms: u64,
    }

    struct ZapDelivered has copy, drop {
        zap: 0x2::object::ID,
        user: address,
        keeper: address,
        shares_in: u64,
        meme_out: u64,
        shares_left: u64,
    }

    struct ZapShares has copy, drop {
        zap: 0x2::object::ID,
        user: address,
        shares: u64,
        by_user: bool,
    }

    struct ZapRefunded has copy, drop {
        zap: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct KeepersChanged has copy, drop {
        keepers: vector<address>,
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public fun deliver<T0, T1, T2>(arg0: Delivery<T0, T1>, arg1: &mut Zap<T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::tx_context::TxContext) {
        let Delivery {
            zap      : v0,
            user     : v1,
            min_meme : v2,
            taken    : v3,
        } = arg0;
        assert!(v0 == 0x2::object::id<Zap<T1, T2>>(arg1), 8);
        assert!(0x2::coin::value<T0>(&arg2) >= v2, 5);
        arg1.meme_out = 0x2::coin::value<T0>(&arg2);
        arg1.shares_out = 0x2::coin::value<T1>(&arg3);
        let v4 = ZapDelivered{
            zap         : v0,
            user        : v1,
            keeper      : 0x2::tx_context::sender(arg4),
            shares_in   : v3,
            meme_out    : 0x2::coin::value<T0>(&arg2),
            shares_left : 0x2::coin::value<T1>(&arg3),
        };
        0x2::event::emit<ZapDelivered>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        if (0x2::coin::value<T1>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, v1);
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
    }

    public fun expire<T0, T1>(arg0: &mut Zap<T0, T1>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3) == arg0.user;
        let v1 = if (v0) {
            true
        } else if (0x2::clock::timestamp_ms(arg2) > arg0.deadline_ms) {
            true
        } else {
            arg0.state != 0
        };
        assert!(v1, 4);
        let v2 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v3 = 0x2::coin::value<T0>(&v2);
        if (arg0.state == 0) {
            arg0.state = 2;
        };
        arg0.shares_out = arg0.shares_out + v3;
        let v4 = ZapShares{
            zap     : 0x2::object::id<Zap<T0, T1>>(arg0),
            user    : arg0.user,
            shares  : v3,
            by_user : v0,
        };
        0x2::event::emit<ZapShares>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.user);
    }

    public fun info<T0, T1>(arg0: &Zap<T0, T1>) : (address, 0x2::object::ID, u64, 0x2::object::ID, u64, u64, u8) {
        (arg0.user, arg0.market, arg0.order, arg0.pool, arg0.min_meme, arg0.deadline_ms, arg0.state)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id          : 0x2::object::new(arg0),
            version     : 1,
            keepers     : 0x2::vec_set::empty<address>(),
            max_wait_ms : 3600000,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_keeper(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    fun launch<T0, T1>(arg0: Zap<T0, T1>, arg1: u64, arg2: u64) : 0x2::object::ID {
        let v0 = 0x2::object::id<Zap<T0, T1>>(&arg0);
        let v1 = ZapStarted{
            zap         : v0,
            user        : arg0.user,
            market      : arg0.market,
            order       : arg0.order,
            meme        : arg0.meme,
            pool        : arg0.pool,
            paid        : arg1,
            min_raw     : arg2,
            min_meme    : arg0.min_meme,
            deadline_ms : arg0.deadline_ms,
        };
        0x2::event::emit<ZapStarted>(v1);
        0x2::transfer::share_object<Zap<T0, T1>>(arg0);
        v0
    }

    public fun max_wait_ms(arg0: &Config) : u64 {
        arg0.max_wait_ms
    }

    public fun meme_type<T0, T1>(arg0: &Zap<T0, T1>) : 0x1::type_name::TypeName {
        arg0.meme
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    fun open<T0, T1, T2>(arg0: &Config, arg1: &0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Zap<T0, T1> {
        assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg3 > 0, 5);
        assert!(arg4 > arg5 && arg4 <= v0 + arg0.max_wait_ms, 4);
        Zap<T0, T1>{
            id          : 0x2::object::new(arg7),
            config      : 0x2::object::id<Config>(arg0),
            user        : 0x2::tx_context::sender(arg7),
            market      : 0x2::object::id<0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>>(arg1),
            order       : 0,
            meme        : 0x1::type_name::with_defining_ids<T2>(),
            pool        : arg2,
            min_meme    : arg3,
            deadline_ms : arg4,
            created_ms  : v0,
            state       : 0,
            meme_out    : 0,
            shares_out  : 0,
            usdc_out    : 0,
        }
    }

    public fun outcome<T0, T1>(arg0: &Zap<T0, T1>) : (u64, u64, u64) {
        (arg0.meme_out, arg0.shares_out, arg0.usdc_out)
    }

    public fun refund<T0, T1>(arg0: &mut Zap<T0, T1>, arg1: &0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>) {
        assert!(arg0.market == 0x2::object::id<0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>>(arg1), 8);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg2);
        let v1 = 0x2::coin::value<T1>(&v0);
        let (_, _, _, _, _, v7, _) = 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::buy_info<T0, T1>(arg1, arg0.order);
        if (v7 == 2 && arg0.state == 0) {
            arg0.state = 3;
        };
        arg0.usdc_out = arg0.usdc_out + v1;
        let v9 = ZapRefunded{
            zap    : 0x2::object::id<Zap<T0, T1>>(arg0),
            user   : arg0.user,
            amount : v1,
        };
        0x2::event::emit<ZapRefunded>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg0.user);
    }

    public fun set_keeper(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: bool) {
        assert_version(arg1);
        if (arg3 && !0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.keepers, arg2);
        };
        if (!arg3 && 0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.keepers, &arg2);
        };
        let v0 = KeepersChanged{keepers: 0x2::vec_set::into_keys<address>(arg1.keepers)};
        0x2::event::emit<KeepersChanged>(v0);
    }

    public fun set_max_wait(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 >= 60000 && arg2 <= 86400000, 9);
        arg1.max_wait_ms = arg2;
    }

    public fun start<T0, T1: drop, T2>(arg0: &Config, arg1: &mut 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>, arg2: &0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::config::Config, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::deposit_for_burn::DepositForBurnWithPackageAuthTicket<T1, 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::XAuth>, 0x2::object::ID) {
        let v0 = open<T0, T1, T2>(arg0, arg1, arg6, arg7, arg8, arg5, arg9, arg10);
        let (v1, v2) = 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::buy_order_to<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x2::object::uid_to_address(&v0.id), arg9, arg10);
        v0.order = v2;
        (v1, launch<T0, T1>(v0, 0x2::coin::value<T1>(&arg3), arg4))
    }

    public fun take<T0, T1, T2>(arg0: &mut Zap<T0, T1>, arg1: &Config, arg2: &0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Delivery<T2, T0>) {
        assert_version(arg1);
        assert!(arg0.config == 0x2::object::id<Config>(arg1) && arg0.market == 0x2::object::id<0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::Market<T0, T1>>(arg2), 8);
        let v0 = if (0x2::tx_context::sender(arg5) == arg0.user) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg5);
            0x2::vec_set::contains<address>(&arg1.keepers, &v1)
        };
        assert!(v0, 2);
        assert!(arg0.state == 0, 3);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.deadline_ms, 4);
        assert!(0x1::type_name::with_defining_ids<T2>() == arg0.meme, 6);
        let (_, _, _, _, _, v7, v8) = 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::market::buy_info<T0, T1>(arg2, arg0.order);
        assert!(v7 == 1, 7);
        let v9 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg3);
        assert!(0x2::coin::value<T0>(&v9) == v8, 7);
        arg0.state = 1;
        let v10 = Delivery<T2, T0>{
            zap      : 0x2::object::id<Zap<T0, T1>>(arg0),
            user     : arg0.user,
            min_meme : arg0.min_meme,
            taken    : 0x2::coin::value<T0>(&v9),
        };
        (v9, v10)
    }

    // decompiled from Move bytecode v7
}

