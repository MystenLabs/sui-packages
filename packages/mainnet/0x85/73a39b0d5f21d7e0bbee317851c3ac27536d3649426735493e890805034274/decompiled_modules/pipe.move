module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe {
    struct PipeType<phantom T0, phantom T1: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct Pipe<phantom T0, phantom T1: drop> has store, key {
        id: 0x2::object::UID,
        output_volume: u64,
    }

    struct OutputCarrier<phantom T0, phantom T1: drop> {
        content: 0x2::balance::Balance<T0>,
    }

    struct InputCarrier<phantom T0, phantom T1: drop> {
        content: 0x2::balance::Balance<T0>,
    }

    public(friend) fun destroy_input_carrier<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: InputCarrier<T0, T1>) : 0x2::balance::Balance<T0> {
        let v0 = input_carrier_volume<T0, T1>(&arg1);
        let v1 = output_volume<T0, T1>(arg0);
        if (v1 < v0) {
            err_input_too_much();
        };
        arg0.output_volume = v1 - v0;
        let InputCarrier { content: v2 } = arg1;
        v2
    }

    public fun destroy_output_carrier<T0, T1: drop>(arg0: T1, arg1: OutputCarrier<T0, T1>) : 0x2::balance::Balance<T0> {
        let OutputCarrier { content: v0 } = arg1;
        v0
    }

    public(friend) fun destroy_pipe<T0, T1: drop>(arg0: Pipe<T0, T1>) {
        let Pipe {
            id            : v0,
            output_volume : v1,
        } = arg0;
        if (v1 > 0) {
            err_destroy_non_empty_pipe();
        };
        0x2::object::delete(v0);
    }

    fun err_destroy_non_empty_pipe() {
        abort 1
    }

    fun err_input_too_much() {
        abort 0
    }

    public fun input<T0, T1: drop>(arg0: T1, arg1: 0x2::balance::Balance<T0>) : InputCarrier<T0, T1> {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe_events::emit_input<T0, T1>(&arg1);
        InputCarrier<T0, T1>{content: arg1}
    }

    public fun input_carrier_volume<T0, T1: drop>(arg0: &InputCarrier<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.content)
    }

    public(friend) fun new_pipe<T0, T1: drop>(arg0: &mut 0x2::tx_context::TxContext) : Pipe<T0, T1> {
        Pipe<T0, T1>{
            id            : 0x2::object::new(arg0),
            output_volume : 0,
        }
    }

    public(friend) fun new_type<T0, T1: drop>() : PipeType<T0, T1> {
        PipeType<T0, T1>{dummy_field: false}
    }

    public(friend) fun output<T0, T1: drop>(arg0: &mut Pipe<T0, T1>, arg1: 0x2::balance::Balance<T0>) : OutputCarrier<T0, T1> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe_events::emit_output<T0, T1>(v0);
        arg0.output_volume = output_volume<T0, T1>(arg0) + v0;
        OutputCarrier<T0, T1>{content: arg1}
    }

    public fun output_carrier_volume<T0, T1: drop>(arg0: &OutputCarrier<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.content)
    }

    public fun output_volume<T0, T1: drop>(arg0: &Pipe<T0, T1>) : u64 {
        arg0.output_volume
    }

    // decompiled from Move bytecode v6
}

