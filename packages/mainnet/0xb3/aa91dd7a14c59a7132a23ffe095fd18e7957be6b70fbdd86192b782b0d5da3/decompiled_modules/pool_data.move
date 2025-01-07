module 0xb3aa91dd7a14c59a7132a23ffe095fd18e7957be6b70fbdd86192b782b0d5da3::pool_data {
    struct GamePool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        pool: address,
        public_key: vector<u8>,
        min_betting: u64,
        max_betting: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct POOL_DATA has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0>(arg0: &GamePool<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut<T0>(arg0: &mut GamePool<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun balance<T0>(arg0: &GamePool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut GamePool<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    fun init(arg0: POOL_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL_DATA>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_pool_data<T0>(arg0: AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        let v0 = GamePool<T0>{
            id          : 0x2::object::new(arg3),
            balance     : 0x2::coin::into_balance<T0>(arg1),
            pool        : 0x2::tx_context::sender(arg3),
            public_key  : arg2,
            min_betting : 1000000000,
            max_betting : 50000000000,
        };
        0x2::transfer::share_object<GamePool<T0>>(v0);
        arg0
    }

    public fun max_betting<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.max_betting
    }

    public fun min_betting<T0>(arg0: &GamePool<T0>) : u64 {
        arg0.min_betting
    }

    public fun pool<T0>(arg0: &GamePool<T0>) : address {
        arg0.pool
    }

    public fun public_key<T0>(arg0: &GamePool<T0>) : vector<u8> {
        arg0.public_key
    }

    public fun remove_admin(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun top_up<T0>(arg0: &mut GamePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public fun update_max_betting<T0>(arg0: &mut GamePool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == pool<T0>(arg0), 0);
        arg0.max_betting = arg1;
    }

    public fun update_min_betting<T0>(arg0: &mut GamePool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == pool<T0>(arg0), 0);
        arg0.min_betting = arg1;
    }

    public fun withdraw<T0>(arg0: &mut GamePool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == pool<T0>(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, balance<T0>(arg0), arg1), pool<T0>(arg0));
    }

    // decompiled from Move bytecode v6
}

