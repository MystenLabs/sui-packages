module 0xc80ce0de4f996cd94295e11725f061a96329a341f0a059ff06b0f3a2682e924c::c {
    public fun c(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 0x2::balance::split<0x2::sui::SUI>(&mut arg1, arg2));
        arg1
    }

    public fun a(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0))
    }

    public fun b(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(v0, arg1);
        0x2::balance::withdraw_all<0x2::sui::SUI>(v0)
    }

    public fun d(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), arg1);
    }

    public fun w<T0>(arg0: &mut 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(0x2::coin::balance_mut<T0>(arg0))
    }

    public fun x<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        0x2::balance::join<T0>(v0, arg1);
        0x2::balance::withdraw_all<T0>(v0)
    }

    public fun y<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg0), 0x2::balance::split<T0>(&mut arg1, arg2));
        arg1
    }

    public fun z<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg0), arg1);
    }

    // decompiled from Move bytecode v6
}

