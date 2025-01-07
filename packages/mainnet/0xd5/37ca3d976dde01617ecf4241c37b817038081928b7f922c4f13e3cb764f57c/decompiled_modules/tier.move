module 0xd537ca3d976dde01617ecf4241c37b817038081928b7f922c4f13e3cb764f57c::tier {
    struct TIER has drop {
        dummy_field: bool,
    }

    struct TAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakePosititon has store {
        value: u64,
        timestamp: u64,
        expire: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        emergency: bool,
        fund: 0x2::coin::Coin<T0>,
        min_lock: u64,
        lock_period_ms: u64,
        funds: 0x2::table::Table<address, StakePosititon>,
    }

    struct UpdateMinLockEvent has copy, drop {
        pool_tier: address,
        min_lock: u64,
        lock_period_ms: u64,
    }

    struct LockEvent has copy, drop {
        pool_tier: address,
        sender: address,
        value: u64,
        timestamp: u64,
        expire: u64,
        lock_amount: u64,
    }

    struct UnlockEvent has copy, drop {
        pool_tier: address,
        sender: address,
        value: u64,
        timestamp: u64,
        emergency: bool,
        lock_amount: u64,
    }

    public entry fun change_admin(arg0: TAdminCap, arg1: address) {
        0x2::transfer::public_transfer<TAdminCap>(arg0, arg1);
    }

    public entry fun createPool<T0>(arg0: &TAdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1001);
        let v0 = Pool<T0>{
            id             : 0x2::object::new(arg3),
            emergency      : false,
            fund           : 0x2::coin::zero<T0>(arg3),
            min_lock       : arg1,
            lock_period_ms : arg2,
            funds          : 0x2::table::new<address, StakePosititon>(arg3),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    fun init(arg0: TIER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.emergency, 1004);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + arg1.lock_period_ms;
        let v3 = 0x2::tx_context::sender(arg3);
        assert!(v0 >= arg1.min_lock, 1002);
        let v4 = v0;
        if (!0x2::table::contains<address, StakePosititon>(&arg1.funds, v3)) {
            let v5 = StakePosititon{
                value     : v0,
                timestamp : v1,
                expire    : v2,
            };
            0x2::table::add<address, StakePosititon>(&mut arg1.funds, v3, v5);
        } else {
            let v6 = 0x2::table::borrow_mut<address, StakePosititon>(&mut arg1.funds, v3);
            v6.value = v6.value + v0;
            v6.timestamp = v1;
            v6.expire = v2;
            v4 = v6.value;
        };
        0x2::coin::join<T0>(&mut arg1.fund, arg0);
        let v7 = LockEvent{
            pool_tier   : 0x2::object::id_address<Pool<T0>>(arg1),
            sender      : v3,
            value       : v0,
            timestamp   : v1,
            expire      : v2,
            lock_amount : v4,
        };
        0x2::event::emit<LockEvent>(v7);
    }

    public entry fun set_emergency<T0>(arg0: &TAdminCap, arg1: &mut Pool<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.emergency != arg2, 1001);
        arg1.emergency = arg2;
    }

    public entry fun unlock<T0>(arg0: u64, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.emergency, 1004);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, StakePosititon>(&mut arg1.funds, v1) && 0x2::table::borrow<address, StakePosititon>(&arg1.funds, v1).expire <= v0, 1001);
        let v2 = 0x2::table::borrow_mut<address, StakePosititon>(&mut arg1.funds, v1);
        assert!(arg0 <= v2.value, 1005);
        let v3 = 0;
        if (arg0 < 0x2::coin::value<T0>(&arg1.fund)) {
            v2.value = v2.value - arg0;
            v3 = v2.value;
        } else {
            let StakePosititon {
                value     : _,
                timestamp : _,
                expire    : _,
            } = 0x2::table::remove<address, StakePosititon>(&mut arg1.funds, v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.fund, arg0, arg3), v1);
        let v7 = UnlockEvent{
            pool_tier   : 0x2::object::id_address<Pool<T0>>(arg1),
            sender      : v1,
            value       : arg0,
            timestamp   : v0,
            emergency   : false,
            lock_amount : v3,
        };
        0x2::event::emit<UnlockEvent>(v7);
    }

    public entry fun unlock_emergency<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.emergency, 1003);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, StakePosititon>(&mut arg0.funds, v0), 1001);
        let StakePosititon {
            value     : v1,
            timestamp : _,
            expire    : _,
        } = 0x2::table::remove<address, StakePosititon>(&mut arg0.funds, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.fund, v1, arg2), v0);
        let v4 = UnlockEvent{
            pool_tier   : 0x2::object::id_address<Pool<T0>>(arg0),
            sender      : v0,
            value       : v1,
            timestamp   : 0x2::clock::timestamp_ms(arg1),
            emergency   : true,
            lock_amount : 0,
        };
        0x2::event::emit<UnlockEvent>(v4);
    }

    public entry fun update_min_lock<T0>(arg0: &TAdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64) {
        arg1.min_lock = arg2;
        arg1.lock_period_ms = arg3;
        let v0 = UpdateMinLockEvent{
            pool_tier      : 0x2::object::id_address<Pool<T0>>(arg1),
            min_lock       : arg2,
            lock_period_ms : arg3,
        };
        0x2::event::emit<UpdateMinLockEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

