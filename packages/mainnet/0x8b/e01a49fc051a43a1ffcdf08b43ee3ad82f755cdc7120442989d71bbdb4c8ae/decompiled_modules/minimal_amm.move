module 0x8be01a49fc051a43a1ffcdf08b43ee3ad82f755cdc7120442989d71bbdb4c8ae::minimal_amm {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        target_x: u64,
        mult_x: u64,
        mult_y: u64,
        target_y_based_lock: bool,
        target_y_reference: u64,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xdb8426f6207d23dc75352be968894e986d156d017ba1a217fcb521effcde94f, 0);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg2));
        arg0.target_x = arg0.target_x + 0x2::coin::value<T0>(&arg1);
    }

    fun calculate_x_to_y<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = (arg0.target_x as u128);
        let v1 = v0 * 600;
        let v2 = v1 * v1 * (arg0.mult_x as u128) / (arg0.mult_y as u128);
        let v3 = v1 + (0x2::balance::value<T0>(&arg0.reserve_x) as u128) - v0;
        let v4 = v2 / v3 - v2 / (v3 + (arg1 as u128));
        assert!(v4 < (0x2::balance::value<T1>(&arg0.reserve_y) as u128), 1);
        let v5 = (v4 as u64);
        v5 - v5 * 300 / 1000000
    }

    fun calculate_y_to_x<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = (arg0.target_x as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.reserve_x) as u128);
        let v2 = v0 * 600;
        let v3 = v2 * v2 * (arg0.mult_x as u128) / (arg0.mult_y as u128);
        let v4 = v2 + v1 - v0;
        let v5 = v4 - v3 / (v3 / v4 + (arg1 as u128));
        assert!(v5 < v1, 2);
        let v6 = (v5 as u64);
        v6 - v6 * 300 / 1000000
    }

    public entry fun create_pool<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xdb8426f6207d23dc75352be968894e986d156d017ba1a217fcb521effcde94f, 0);
        let v0 = Pool<T0, T1>{
            id                  : 0x2::object::new(arg2),
            reserve_x           : 0x2::balance::zero<T0>(),
            reserve_y           : 0x2::balance::zero<T1>(),
            target_x            : 0,
            mult_x              : arg0,
            mult_y              : arg1,
            target_y_based_lock : false,
            target_y_reference  : 0,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    fun get_target_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        (0x2::balance::value<T0>(&arg0.reserve_x) * arg0.mult_x + 0x2::balance::value<T1>(&arg0.reserve_y) * arg0.mult_y - arg0.target_x * arg0.mult_x) / arg0.mult_y
    }

    fun is_pool_locked<T0, T1>(arg0: &mut Pool<T0, T1>) : bool {
        let v0 = get_target_y<T0, T1>(arg0);
        if (v0 > arg0.target_y_reference) {
            arg0.target_y_reference = v0;
        };
        if (arg0.target_y_reference > v0) {
            if ((arg0.target_y_reference - v0) * 10000 / arg0.target_y_reference > 500) {
                arg0.target_y_based_lock = true;
            };
        };
        arg0.target_y_based_lock
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xdb8426f6207d23dc75352be968894e986d156d017ba1a217fcb521effcde94f, 0);
        arg0.target_x = arg0.target_x - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, arg1), arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = is_pool_locked<T0, T1>(arg0);
        assert!(!v0, 3);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, calculate_x_to_y<T0, T1>(arg0, 0x2::coin::value<T0>(&arg1))), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = is_pool_locked<T0, T1>(arg0);
        assert!(!v0, 3);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, calculate_y_to_x<T0, T1>(arg0, 0x2::coin::value<T1>(&arg1))), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun unlock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xdb8426f6207d23dc75352be968894e986d156d017ba1a217fcb521effcde94f, 0);
        arg0.target_y_based_lock = false;
        arg0.target_y_reference = 0;
    }

    public entry fun update_price<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xdb8426f6207d23dc75352be968894e986d156d017ba1a217fcb521effcde94f, 0);
        arg0.mult_x = arg1;
        arg0.mult_y = arg2;
    }

    // decompiled from Move bytecode v6
}

