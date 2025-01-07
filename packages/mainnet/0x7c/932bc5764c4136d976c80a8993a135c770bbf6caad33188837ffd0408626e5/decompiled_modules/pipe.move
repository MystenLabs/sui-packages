module 0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::pipe {
    struct OutputLiquidity<phantom T0, phantom T1: drop> has copy, drop {
        value: u64,
    }

    struct InputLiquidity<phantom T0, phantom T1: drop> has copy, drop {
        value: u64,
    }

    struct PipeType<phantom T0, phantom T1: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct Pipe<phantom T0, phantom T1: drop> has store {
        debt: 0x2::balance::Balance<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>,
    }

    struct OutputCarrier<phantom T0, phantom T1: drop> {
        content: 0x2::balance::Balance<T0>,
    }

    struct InputCarrier<phantom T0, phantom T1: drop> {
        content: 0x2::balance::Balance<T0>,
    }

    public fun debt_value<T0, T1: drop>(arg0: &Pipe<T0, T1>) : u64 {
        0x2::balance::value<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>(&arg0.debt)
    }

    public(friend) fun destroy<T0, T1: drop>(arg0: Pipe<T0, T1>) {
        let Pipe { debt: v0 } = arg0;
        if (0x2::balance::value<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>(&v0) > 0) {
            err_destroy_non_empty_pipe();
        };
        0x2::balance::destroy_zero<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>(v0);
    }

    public(friend) fun destroy_input_carrier<T0, T1: drop>(arg0: InputCarrier<T0, T1>, arg1: &mut Pipe<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>) {
        let v0 = input_value<T0, T1>(&arg0);
        if (0x2::balance::value<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>(&arg1.debt) < v0) {
            err_input_too_much();
        };
        let InputCarrier { content: v1 } = arg0;
        let v2 = InputLiquidity<T0, T1>{value: 0x2::balance::value<T0>(&v1)};
        0x2::event::emit<InputLiquidity<T0, T1>>(v2);
        (v1, 0x2::balance::split<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>(&mut arg1.debt, v0))
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

    public fun input<T0, T1: drop>(arg0: 0x2::balance::Balance<T0>, arg1: T1) : InputCarrier<T0, T1> {
        InputCarrier<T0, T1>{content: arg0}
    }

    public fun input_value<T0, T1: drop>(arg0: &InputCarrier<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.content)
    }

    public(friend) fun new_pipe<T0, T1: drop>() : Pipe<T0, T1> {
        Pipe<T0, T1>{debt: 0x2::balance::zero<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>()}
    }

    public(friend) fun new_type<T0, T1: drop>() : PipeType<T0, T1> {
        PipeType<T0, T1>{dummy_field: false}
    }

    public(friend) fun output<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>) : OutputCarrier<T0, T1> {
        let v0 = OutputLiquidity<T0, T1>{value: 0x2::balance::value<T0>(&arg1)};
        0x2::event::emit<OutputLiquidity<T0, T1>>(v0);
        0x2::balance::join<0xb81a8531ebcc965130e03f9f8d17a9dcfb3f24982984dfc2fffe055254d1d88f::house::PipeDebt<T0>>(&mut arg0.debt, arg2);
        OutputCarrier<T0, T1>{content: arg1}
    }

    public fun output_value<T0, T1: drop>(arg0: &OutputCarrier<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.content)
    }

    // decompiled from Move bytecode v6
}

