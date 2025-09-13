module 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_assign_job {
    struct AssignJobParam has copy, drop, store {
        base: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam,
    }

    public fun base(arg0: &AssignJobParam) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam {
        &arg0.base
    }

    public(friend) fun create_param(arg0: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::dvn_get_fee::GetFeeParam) : AssignJobParam {
        AssignJobParam{base: arg0}
    }

    // decompiled from Move bytecode v6
}

