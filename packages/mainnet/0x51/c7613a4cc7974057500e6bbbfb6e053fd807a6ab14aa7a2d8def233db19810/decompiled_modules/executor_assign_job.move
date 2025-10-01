module 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_assign_job {
    struct AssignJobParam has copy, drop, store {
        base: 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam,
    }

    public fun base(arg0: &AssignJobParam) : &0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam {
        &arg0.base
    }

    public fun create_param(arg0: 0x51c7613a4cc7974057500e6bbbfb6e053fd807a6ab14aa7a2d8def233db19810::executor_get_fee::GetFeeParam) : AssignJobParam {
        AssignJobParam{base: arg0}
    }

    // decompiled from Move bytecode v6
}

