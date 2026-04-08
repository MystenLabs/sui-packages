module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::pipe {
    struct OutputLiquidity<phantom T0, phantom T1: drop> has copy, drop {
        pipe_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        value: u64,
    }

    struct InputLiquidity<phantom T0, phantom T1: drop> has copy, drop {
        pipe_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        value: u64,
    }

    struct Pipe<phantom T0, phantom T1: drop> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        debt: 0x2::balance::Balance<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>,
    }

    public(friend) fun destroy<T0, T1: drop>(arg0: Pipe<T0, T1>) {
        let Pipe {
            id      : v0,
            pool_id : _,
            debt    : v2,
        } = arg0;
        let v3 = v2;
        if (0x2::balance::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&v3) > 0) {
            abort 13835339805136846850
        };
        0x2::balance::destroy_zero<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(v3);
        0x2::object::delete(v0);
    }

    public fun get_balance_value<T0, T1: drop>(arg0: &Pipe<T0, T1>) : u64 {
        0x2::balance::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&arg0.debt)
    }

    public(friend) fun new_pipe<T0, T1: drop>(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : Pipe<T0, T1> {
        Pipe<T0, T1>{
            id      : 0x2::object::new(arg1),
            pool_id : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::get_id<T0>(arg0),
            debt    : 0x2::balance::zero<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(),
        }
    }

    public(friend) fun pool_id<T0, T1: drop>(arg0: &Pipe<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun put_debt<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: 0x2::balance::Balance<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>) {
        let v0 = 0x2::balance::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&arg1);
        assert!((0x2::balance::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&arg0.debt) as u128) + (v0 as u128) <= (18446744073709551615 as u128), 13835902815220072454);
        0x2::balance::join<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&mut arg0.debt, arg1);
        let v1 = OutputLiquidity<T0, T1>{
            pipe_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id : arg0.pool_id,
            value   : v0,
        };
        0x2::event::emit<OutputLiquidity<T0, T1>>(v1);
    }

    public(friend) fun take_debt<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: u64) : 0x2::balance::Balance<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>> {
        assert!(0x2::balance::value<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&arg0.debt) >= arg1, 13835621404667740164);
        let v0 = InputLiquidity<T0, T1>{
            pipe_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id : arg0.pool_id,
            value   : arg1,
        };
        0x2::event::emit<InputLiquidity<T0, T1>>(v0);
        0x2::balance::split<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::house::PoolDebt<T0>>(&mut arg0.debt, arg1)
    }

    // decompiled from Move bytecode v6
}

