module 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::vq {
    public fun k<T0, T1>(arg0: &mut 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::Ht, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::cn(arg0)) {
            let v1 = 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::ra(arg0, v0);
            if (v1 > 0) {
                let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, v1);
                let v3 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v2)) {
                    0
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2)
                };
                0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::sr(arg0, v0, v3);
            };
            v0 = v0 + 1;
        };
        0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::np(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), arg2);
    }

    public fun p<T0, T1>(arg0: &mut 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::Ht, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0;
        while (v1 < 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::cn(arg0)) {
            let v2 = 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::ra(arg0, v1);
            if (v2 > 0) {
                let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, v2, v0);
                let v4 = if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v3)) {
                    0
                } else {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3)
                };
                0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::sr(arg0, v1, v4);
            };
            v1 = v1 + 1;
        };
        0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::np(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), arg2);
    }

    public fun t<T0, T1>(arg0: &mut 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::Ht, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0;
        while (v1 < 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::cn(arg0)) {
            let v2 = 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::ra(arg0, v1);
            if (v2 > 0) {
                let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v0, v2);
                0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::sr(arg0, v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v3));
            };
            v1 = v1 + 1;
        };
        0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::np(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

