module 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap {
    struct BatchSwap<phantom T0, phantom T1> {
        id: 0x2::object::ID,
        in: 0x2::balance::Balance<T0>,
        out: 0x2::balance::Balance<T1>,
        total_in: u64,
        total_out: u64,
        num_claims: u64,
        total_claimed: u64,
        in_swap: bool,
        swap_completed: bool,
    }

    struct BatchSwapClaim {
        batch_swap_id: 0x2::object::ID,
        amount: u64,
    }

    public fun destroy_zero<T0, T1>(arg0: BatchSwap<T0, T1>) {
        assert!(arg0.in_swap == false, 0);
        assert!(arg0.num_claims == arg0.total_claimed, 5);
        let BatchSwap {
            id             : _,
            in             : v1,
            out            : v2,
            total_in       : _,
            total_out      : _,
            num_claims     : _,
            total_claimed  : _,
            in_swap        : _,
            swap_completed : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v2);
    }

    public fun claim<T0, T1>(arg0: &mut BatchSwap<T0, T1>, arg1: BatchSwapClaim) : 0x2::balance::Balance<T1> {
        assert!(arg1.batch_swap_id == arg0.id, 4);
        assert!(arg0.swap_completed == true, 3);
        let BatchSwapClaim {
            batch_swap_id : _,
            amount        : v1,
        } = arg1;
        if (v1 == 0) {
            return 0x2::balance::zero<T1>()
        };
        arg0.total_claimed = arg0.total_claimed + 1;
        if (arg0.total_claimed == arg0.num_claims) {
            return 0x2::balance::withdraw_all<T1>(&mut arg0.out)
        };
        0x2::balance::split<T1>(&mut arg0.out, 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::muldiv(v1, arg0.total_out, arg0.total_in))
    }

    public fun claim_if_matches<T0, T1>(arg0: &mut BatchSwap<T0, T1>, arg1: BatchSwapClaim) : (0x2::balance::Balance<T1>, 0x1::option::Option<BatchSwapClaim>) {
        assert!(arg0.swap_completed == true, 3);
        if (arg1.batch_swap_id == arg0.id) {
            (claim<T0, T1>(arg0, arg1), 0x1::option::none<BatchSwapClaim>())
        } else {
            (0x2::balance::zero<T1>(), 0x1::option::some<BatchSwapClaim>(arg1))
        }
    }

    public fun complete_swap<T0, T1>(arg0: &mut BatchSwap<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        assert!(arg0.in_swap == true, 2);
        0x2::balance::join<T1>(&mut arg0.out, arg1);
        arg0.total_out = 0x2::balance::value<T1>(&arg0.out);
        arg0.swap_completed = true;
        arg0.in_swap = false;
    }

    public fun deposit<T0, T1>(arg0: &mut BatchSwap<T0, T1>, arg1: 0x2::balance::Balance<T0>) : BatchSwapClaim {
        assert!(arg0.in_swap == false, 0);
        arg0.total_in = 0x2::balance::join<T0>(&mut arg0.in, arg1);
        arg0.num_claims = arg0.num_claims + 1;
        BatchSwapClaim{
            batch_swap_id : arg0.id,
            amount        : 0x2::balance::value<T0>(&arg1),
        }
    }

    public fun new_batch_swap<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : BatchSwap<T0, T1> {
        BatchSwap<T0, T1>{
            id             : 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg0)),
            in             : 0x2::balance::zero<T0>(),
            out            : 0x2::balance::zero<T1>(),
            total_in       : 0,
            total_out      : 0,
            num_claims     : 0,
            total_claimed  : 0,
            in_swap        : false,
            swap_completed : false,
        }
    }

    public fun start_swap<T0, T1>(arg0: &mut BatchSwap<T0, T1>) : 0x2::balance::Balance<T0> {
        assert!(arg0.in_swap == false, 0);
        assert!(arg0.swap_completed == false, 1);
        arg0.in_swap = true;
        0x2::balance::withdraw_all<T0>(&mut arg0.in)
    }

    // decompiled from Move bytecode v6
}

