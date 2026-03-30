module 0xca0126a4acf52388d63f1ef53347121bdce34da2e90851b581b463a0d5e99f68::satellite {
    struct SatelliteAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SatellitePool<phantom T0> has key {
        id: 0x2::object::UID,
        reserves: 0x2::balance::Balance<T0>,
        cache: address,
        launched: u64,
        surplus_earned: u64,
    }

    struct Satellite {
        pool_id: address,
        amount: u64,
    }

    struct SatelliteLaunched has copy, drop {
        pool_id: address,
        amount: u64,
    }

    struct SatelliteLanded has copy, drop {
        pool_id: address,
        repaid: u64,
        surplus: u64,
    }

    public fun available<T0>(arg0: &SatellitePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserves)
    }

    public fun create_pool<T0>(arg0: &SatelliteAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SatellitePool<T0>{
            id             : 0x2::object::new(arg2),
            reserves       : 0x2::balance::zero<T0>(),
            cache          : arg1,
            launched       : 0,
            surplus_earned : 0,
        };
        0x2::transfer::share_object<SatellitePool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut SatellitePool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserves, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SatelliteAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SatelliteAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun land_satellite<T0>(arg0: &mut SatellitePool<T0>, arg1: Satellite, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let Satellite {
            pool_id : v0,
            amount  : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id_address<SatellitePool<T0>>(arg0), 103);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= v1, 100);
        let v3 = v2 - v1;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg3), arg0.cache);
            0x2::balance::join<T0>(&mut arg0.reserves, 0x2::coin::into_balance<T0>(arg2));
            arg0.surplus_earned = arg0.surplus_earned + v3;
        } else {
            0x2::balance::join<T0>(&mut arg0.reserves, 0x2::coin::into_balance<T0>(arg2));
        };
        let v4 = SatelliteLanded{
            pool_id : v0,
            repaid  : v2,
            surplus : v3,
        };
        0x2::event::emit<SatelliteLanded>(v4);
    }

    public fun launch_satellite<T0>(arg0: &mut SatellitePool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Satellite) {
        assert!(0x2::balance::value<T0>(&arg0.reserves) >= arg1, 101);
        arg0.launched = arg0.launched + 1;
        let v0 = Satellite{
            pool_id : 0x2::object::id_address<SatellitePool<T0>>(arg0),
            amount  : arg1,
        };
        let v1 = SatelliteLaunched{
            pool_id : 0x2::object::id_address<SatellitePool<T0>>(arg0),
            amount  : arg1,
        };
        0x2::event::emit<SatelliteLaunched>(v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserves, arg1), arg2), v0)
    }

    public fun set_cache<T0>(arg0: &SatelliteAdminCap, arg1: &mut SatellitePool<T0>, arg2: address) {
        arg1.cache = arg2;
    }

    public fun total_launched<T0>(arg0: &SatellitePool<T0>) : u64 {
        arg0.launched
    }

    public fun total_surplus<T0>(arg0: &SatellitePool<T0>) : u64 {
        arg0.surplus_earned
    }

    // decompiled from Move bytecode v6
}

