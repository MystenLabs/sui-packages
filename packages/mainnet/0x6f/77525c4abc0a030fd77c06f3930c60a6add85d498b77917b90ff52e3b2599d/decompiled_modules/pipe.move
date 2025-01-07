module 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe {
    struct OutputLiquidity<phantom T0, phantom T1: drop> has copy, drop {
        value: u64,
        from_house: bool,
    }

    struct InputLiquidity<phantom T0, phantom T1: drop> has copy, drop {
        value: u64,
        to_house: bool,
    }

    struct PipeType<phantom T0, phantom T1: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct Pipe<phantom T0, phantom T1: drop> has store {
        pool_debt: 0x2::balance::Balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>,
        house_debt: 0x2::balance::Balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>,
    }

    struct OutputCarrier<phantom T0, phantom T1: drop> {
        content: 0x2::balance::Balance<T0>,
    }

    struct InputCarrier<phantom T0, phantom T1: drop> {
        content: 0x2::balance::Balance<T0>,
    }

    public(friend) fun destroy<T0, T1: drop>(arg0: Pipe<T0, T1>) {
        let Pipe {
            pool_debt  : v0,
            house_debt : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(&v3) > 0) {
            err_destroy_non_empty_pipe();
        };
        if (0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(&v2) > 0) {
            err_destroy_non_empty_pipe();
        };
        0x2::balance::destroy_zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(v3);
        0x2::balance::destroy_zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(v2);
    }

    public(friend) fun destroy_input_carrier<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: InputCarrier<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>) {
        let v0 = input_value<T0, T1>(&arg1);
        if (0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(&arg0.pool_debt) < v0) {
            err_input_too_much();
        };
        let InputCarrier { content: v1 } = arg1;
        let v2 = InputLiquidity<T0, T1>{
            value    : 0x2::balance::value<T0>(&v1),
            to_house : false,
        };
        0x2::event::emit<InputLiquidity<T0, T1>>(v2);
        (v1, 0x2::balance::split<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(&mut arg0.pool_debt, v0))
    }

    public(friend) fun destroy_input_carrier_for_house<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: InputCarrier<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>) {
        let v0 = input_value<T0, T1>(&arg1);
        if (0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(&arg0.house_debt) < v0) {
            err_input_too_much();
        };
        let InputCarrier { content: v1 } = arg1;
        let v2 = InputLiquidity<T0, T1>{
            value    : 0x2::balance::value<T0>(&v1),
            to_house : true,
        };
        0x2::event::emit<InputLiquidity<T0, T1>>(v2);
        (v1, 0x2::balance::split<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(&mut arg0.house_debt, v0))
    }

    public fun destroy_output_carrier<T0, T1: drop>(arg0: OutputCarrier<T0, T1>, arg1: T1) : 0x2::balance::Balance<T0> {
        let OutputCarrier { content: v0 } = arg0;
        v0
    }

    fun err_destroy_non_empty_pipe() {
        abort 1
    }

    fun err_input_too_much() {
        abort 0
    }

    public fun house_debt_value<T0, T1: drop>(arg0: &Pipe<T0, T1>) : u64 {
        0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(&arg0.house_debt)
    }

    public fun input<T0, T1: drop>(arg0: 0x2::balance::Balance<T0>, arg1: T1) : InputCarrier<T0, T1> {
        InputCarrier<T0, T1>{content: arg0}
    }

    public fun input_value<T0, T1: drop>(arg0: &InputCarrier<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.content)
    }

    public(friend) fun new_pipe<T0, T1: drop>() : Pipe<T0, T1> {
        Pipe<T0, T1>{
            pool_debt  : 0x2::balance::zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(),
            house_debt : 0x2::balance::zero<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(),
        }
    }

    public(friend) fun new_type<T0, T1: drop>() : PipeType<T0, T1> {
        PipeType<T0, T1>{dummy_field: false}
    }

    public(friend) fun output<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>) : OutputCarrier<T0, T1> {
        let v0 = OutputLiquidity<T0, T1>{
            value      : 0x2::balance::value<T0>(&arg1),
            from_house : false,
        };
        0x2::event::emit<OutputLiquidity<T0, T1>>(v0);
        0x2::balance::join<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(&mut arg0.pool_debt, arg2);
        OutputCarrier<T0, T1>{content: arg1}
    }

    public(friend) fun output_from_house<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>) : OutputCarrier<T0, T1> {
        let v0 = OutputLiquidity<T0, T1>{
            value      : 0x2::balance::value<T0>(&arg1),
            from_house : true,
        };
        0x2::event::emit<OutputLiquidity<T0, T1>>(v0);
        0x2::balance::join<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(&mut arg0.house_debt, arg2);
        OutputCarrier<T0, T1>{content: arg1}
    }

    public fun output_value<T0, T1: drop>(arg0: &OutputCarrier<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.content)
    }

    public fun pool_debt_value<T0, T1: drop>(arg0: &Pipe<T0, T1>) : u64 {
        0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(&arg0.pool_debt)
    }

    public fun total_debt_value<T0, T1: drop>(arg0: &Pipe<T0, T1>) : u64 {
        0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::PoolDebt<T0>>(&arg0.pool_debt) + 0x2::balance::value<0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::HouseDebt<T0>>(&arg0.house_debt)
    }

    // decompiled from Move bytecode v6
}

