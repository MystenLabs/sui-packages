module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::payment {
    public(friend) fun sui_exact(arg0: &0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::OUTR, arg1: u64, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1, 1);
        let v0 = arg1 * (0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::fee(arg0) as u64) / 10000;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg4), 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::outrun::treasury(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg2);
    }

    // decompiled from Move bytecode v6
}

