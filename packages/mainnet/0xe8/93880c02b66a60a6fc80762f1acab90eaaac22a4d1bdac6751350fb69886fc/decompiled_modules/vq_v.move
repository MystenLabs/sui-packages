module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::vq_v {
    public fun v<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0;
        while (v1 < 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::cn(arg0)) {
            let v2 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ra(arg0, v1);
            if (v2 > 0) {
                let v3 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v0, v2);
                0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::sr(arg0, v1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v3));
            };
            v1 = v1 + 1;
        };
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::np(arg0, 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

