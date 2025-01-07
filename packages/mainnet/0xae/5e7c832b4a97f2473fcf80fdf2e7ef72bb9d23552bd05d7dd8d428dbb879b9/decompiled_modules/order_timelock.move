module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_timelock {
    struct TimelockOrderBook has store {
        next_id: u64,
        pendings: 0x2::table::Table<u64, TimelockOrder>,
        executes: 0x2::table::Table<u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::TimeLockData<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>>,
    }

    struct TimelockOrder has drop, store {
        lock_duration: u64,
        exec_duration: u64,
        order: 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order,
    }

    fun ensure_timelock_operations(arg0: &vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(arg0)) {
            let v1 = 0x1::vector::borrow<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>(arg0, v0);
            v0 = v0 + 1;
            assert!(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::can_be_timelock_operation(v1), 1000);
        };
    }

    public fun get_last_id(arg0: &TimelockOrderBook) : u64 {
        arg0.next_id - 1
    }

    public fun get_order(arg0: &TimelockOrderBook, arg1: u64) : &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Order {
        &0x2::table::borrow<u64, TimelockOrder>(&arg0.pendings, arg1).order
    }

    public(friend) fun init_timelock_order(arg0: &mut TimelockOrderBook, arg1: vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>, arg2: address, arg3: u64, arg4: u64) : u64 {
        ensure_timelock_operations(&arg1);
        let v0 = arg0.next_id;
        arg0.next_id = arg0.next_id + 1;
        let v1 = TimelockOrder{
            lock_duration : arg3,
            exec_duration : arg4,
            order         : 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::new_order(arg1, arg2),
        };
        0x2::table::add<u64, TimelockOrder>(&mut arg0.pendings, v0, v1);
        v0
    }

    public fun new_timelock_order_book(arg0: &mut 0x2::tx_context::TxContext) : TimelockOrderBook {
        TimelockOrderBook{
            next_id  : 0,
            pendings : 0x2::table::new<u64, TimelockOrder>(arg0),
            executes : 0x2::table::new<u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::TimeLockData<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>>(arg0),
        }
    }

    public(friend) fun pop_executable_order(arg0: &mut TimelockOrderBook, arg1: u64, arg2: &0x2::clock::Clock) : vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation> {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::destroy_unlocked<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>(0x2::table::remove<u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::TimeLockData<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>>(&mut arg0.executes, arg1), arg2)
    }

    public(friend) fun pop_expired_order(arg0: &mut TimelockOrderBook, arg1: u64, arg2: &0x2::clock::Clock) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::destroy_expired<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>(0x2::table::remove<u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::TimeLockData<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>>(&mut arg0.executes, arg1), arg2);
    }

    public(friend) fun remove_timelock_order(arg0: &mut TimelockOrderBook, arg1: u64) {
        0x2::table::remove<u64, TimelockOrder>(&mut arg0.pendings, arg1);
    }

    public(friend) fun start_timelock_order(arg0: &mut TimelockOrderBook, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::table::remove<u64, TimelockOrder>(&mut arg0.pendings, arg1);
        0x2::table::add<u64, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::TimeLockData<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>>(&mut arg0.executes, arg1, 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::time_lock::new<vector<0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::Operation>>(0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::get_operations(&v0.order), v0.lock_duration, v0.exec_duration, arg2));
    }

    public(friend) fun vote_timelock_order(arg0: &mut TimelockOrderBook, arg1: u64, arg2: address, arg3: bool) {
        0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order::vote(&mut 0x2::table::borrow_mut<u64, TimelockOrder>(&mut arg0.pendings, arg1).order, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

