module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::book_fill {
    struct BookFill<phantom T0, phantom T1> {
        input_requested: u64,
        input_consumed: u64,
        output_received: u64,
        fee_paid: u64,
    }

    public fun guard<T0, T1>(arg0: BookFill<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64, u64) {
        let BookFill {
            input_requested : v0,
            input_consumed  : v1,
            output_received : v2,
            fee_paid        : v3,
        } = arg0;
        assert!(v1 >= arg1, 400);
        assert!(v2 >= arg2, 401);
        assert!(v3 <= arg3, 402);
        (v0, v1, v2, v3)
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : BookFill<T0, T1> {
        assert!(arg1 <= arg0, 403);
        BookFill<T0, T1>{
            input_requested : arg0,
            input_consumed  : arg1,
            output_received : arg2,
            fee_paid        : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

