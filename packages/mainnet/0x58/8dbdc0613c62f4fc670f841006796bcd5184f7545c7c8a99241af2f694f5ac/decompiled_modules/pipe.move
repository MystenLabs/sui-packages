module 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe {
    struct Create<phantom T0, phantom T1, phantom T2> has copy, drop {
        pipe_id: 0x2::object::ID,
    }

    struct Destroy<phantom T0, phantom T1, phantom T2> has copy, drop {
        pipe_id: 0x2::object::ID,
    }

    struct Output<phantom T0, phantom T1, phantom T2> has copy, drop {
        pipe_id: 0x2::object::ID,
        amount: u64,
    }

    struct Input<phantom T0, phantom T1, phantom T2> has copy, drop {
        pipe_id: 0x2::object::ID,
        amount: u64,
    }

    struct Pipe<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        volume: u64,
    }

    struct Carrier<phantom T0, phantom T1> {
        content: 0x2::balance::Balance<T0>,
    }

    struct PIPE has drop {
        dummy_field: bool,
    }

    public fun new<T0, T1: drop, T2: drop>(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) : Pipe<T0, T1, T2> {
        let v0 = Pipe<T0, T1, T2>{
            id     : 0x2::object::new(arg1),
            volume : 0,
        };
        let v1 = Create<T0, T1, T2>{pipe_id: 0x2::object::id<Pipe<T0, T1, T2>>(&v0)};
        0x2::event::emit<Create<T0, T1, T2>>(v1);
        v0
    }

    public fun content<T0, T1>(arg0: &Carrier<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.content
    }

    public fun create<T0, T1: drop, T2: drop>(arg0: T1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pipe<T0, T1, T2>>(new<T0, T1, T2>(arg0, arg1));
    }

    public fun destroy<T0, T1: drop, T2: drop>(arg0: Pipe<T0, T1, T2>, arg1: T1) {
        let Pipe {
            id     : v0,
            volume : v1,
        } = arg0;
        let v2 = v0;
        if (v1 > 0) {
            err_destroy_non_empty_pipe();
        };
        let v3 = Destroy<T0, T1, T2>{pipe_id: 0x2::object::uid_to_inner(&v2)};
        0x2::event::emit<Destroy<T0, T1, T2>>(v3);
        0x2::object::delete(v2);
    }

    fun err_destroy_non_empty_pipe() {
        abort 0
    }

    fun err_input_too_much() {
        abort 1
    }

    fun init(arg0: PIPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PIPE>(arg0, arg1);
    }

    public fun input<T0, T1: drop, T2: drop>(arg0: &mut Pipe<T0, T1, T2>, arg1: T2, arg2: 0x2::balance::Balance<T0>) : Carrier<T0, T1> {
        if (volume<T0, T1, T2>(arg0) < 0x2::balance::value<T0>(&arg2)) {
            err_input_too_much();
        };
        arg0.volume = volume<T0, T1, T2>(arg0) - 0x2::balance::value<T0>(&arg2);
        let v0 = Input<T0, T1, T2>{
            pipe_id : 0x2::object::id<Pipe<T0, T1, T2>>(arg0),
            amount  : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<Input<T0, T1, T2>>(v0);
        Carrier<T0, T1>{content: arg2}
    }

    public fun output<T0, T1: drop, T2: drop>(arg0: &mut Pipe<T0, T1, T2>, arg1: T1, arg2: 0x2::balance::Balance<T0>) : Carrier<T0, T2> {
        arg0.volume = volume<T0, T1, T2>(arg0) + 0x2::balance::value<T0>(&arg2);
        let v0 = Output<T0, T1, T2>{
            pipe_id : 0x2::object::id<Pipe<T0, T1, T2>>(arg0),
            amount  : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<Output<T0, T1, T2>>(v0);
        Carrier<T0, T2>{content: arg2}
    }

    public fun unwrap<T0, T1: drop>(arg0: Carrier<T0, T1>, arg1: T1) : 0x2::balance::Balance<T0> {
        let Carrier { content: v0 } = arg0;
        v0
    }

    public fun volume<T0, T1, T2>(arg0: &Pipe<T0, T1, T2>) : u64 {
        arg0.volume
    }

    // decompiled from Move bytecode v6
}

