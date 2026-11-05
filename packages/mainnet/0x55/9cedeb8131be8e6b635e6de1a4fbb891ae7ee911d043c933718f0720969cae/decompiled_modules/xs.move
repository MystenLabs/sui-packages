module 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::xs {
    public fun sa<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vs::sa<T0, T1>(arg1, arg2, arg3, arg4);
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vs::sb<T0, T1>(arg1, arg2, arg3, arg4);
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::hp<T0>(arg0, &v0);
        v0
    }

    public fun qs<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: bool) {
        if (!0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::live(arg0)) {
            return
        };
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::fd(arg0, 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vs::qo<T0, T1>(arg1, arg2, 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::cy(arg0)));
    }

    // decompiled from Move bytecode v7
}

