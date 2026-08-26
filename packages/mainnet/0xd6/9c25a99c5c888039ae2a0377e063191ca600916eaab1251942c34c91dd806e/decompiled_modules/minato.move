module 0xd69c25a99c5c888039ae2a0377e063191ca600916eaab1251942c34c91dd806e::minato {
    public fun disperse_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: vector<u64>, arg2: vector<address>) {
        disperse_balance_impl<T0>(arg0, arg1, arg2);
    }

    fun disperse_balance_impl<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: vector<u64>, arg2: vector<address>) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<address>(&arg2), 0);
        0x1::vector::reverse<address>(&mut arg2);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<address>(&arg2), 13906834328962203647);
        0x1::vector::reverse<u64>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(arg0, 0x1::vector::pop_back<u64>(&mut arg1)), 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun disperse_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>) {
        let v0 = 0x2::coin::balance_mut<T0>(arg0);
        disperse_balance_impl<T0>(v0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

