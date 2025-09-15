module 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_assign_job {
    struct AssignJobParam has copy, drop, store {
        base: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam,
    }

    public fun base(arg0: &AssignJobParam) : &0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam {
        &arg0.base
    }

    public(friend) fun create_param(arg0: 0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::executor_get_fee::GetFeeParam) : AssignJobParam {
        AssignJobParam{base: arg0}
    }

    // decompiled from Move bytecode v6
}

