module 0xc5db2d26d6070aed753616e160a92dcbc1b9fa49c5badc8b08883f13b2954622::blazeleon_swap {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        x: 0x2::balance::Balance<T0>,
        y: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        deposit_from: address,
        deposit_amt: u64,
    }

    struct WithdrawEvent has copy, drop {
        withdraw_to: address,
        withdraw_amt: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        swap_pair: 0x1::string::String,
        swap_in_amt: u64,
        swap_out_amt: u64,
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id : 0x2::object::new(arg0),
            x  : 0x2::balance::zero<T0>(),
            y  : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    fun deposit_into_pool<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        let v0 = DepositEvent{
            deposit_from : arg2,
            deposit_amt  : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun deposit_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.x;
        deposit_into_pool<T0>(v0, 0x2::coin::split<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.y;
        deposit_into_pool<T1>(v0, 0x2::coin::split<T1>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 10000);
        let v0 = arg2 * 72 / 10;
        let v1 = SwapEvent{
            user         : 0x2::tx_context::sender(arg3),
            swap_pair    : 0x1::string::utf8(b"x -> y"),
            swap_in_amt  : arg2,
            swap_out_amt : v0,
        };
        0x2::event::emit<SwapEvent>(v1);
        let v2 = &mut arg0.x;
        deposit_into_pool<T0>(v2, 0x2::coin::split<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v3 = &mut arg0.y;
        let v4 = take_coin_from_pool<T1>(v3, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(arg1) >= arg2, 10000);
        let v0 = arg2 * 10 / 72;
        let v1 = SwapEvent{
            user         : 0x2::tx_context::sender(arg3),
            swap_pair    : 0x1::string::utf8(b"y -> x"),
            swap_in_amt  : arg2,
            swap_out_amt : v0,
        };
        0x2::event::emit<SwapEvent>(v1);
        let v2 = &mut arg0.y;
        deposit_into_pool<T1>(v2, 0x2::coin::split<T1>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v3 = &mut arg0.x;
        let v4 = take_coin_from_pool<T0>(v3, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg3));
    }

    fun take_coin_from_pool<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = WithdrawEvent{
            withdraw_to  : 0x2::tx_context::sender(arg2),
            withdraw_amt : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::take<T0>(arg0, arg1, arg2)
    }

    public entry fun withdraw_x<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.x;
        let v1 = take_coin_from_pool<T0>(v0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_y<T0, T1>(arg0: &AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.y;
        let v1 = take_coin_from_pool<T1>(v0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

