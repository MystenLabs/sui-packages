module 0xf9eef7717fba12af5e179db5a226ebefab9e05380e44bcda597fdb5c8e921a06::ps {
    public fun ps(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(arg0));
        if (v0 < 30000000000) {
            let v1 = 0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg1));
            let v2 = 0x1::u64::min(40000000000 - v0, v1);
            if (v1 > v2) {
                0x2::coin::join<0x2::sui::SUI>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg2));
            } else {
                0x2::coin::join<0x2::sui::SUI>(arg0, arg1);
                return
            };
        };
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg1, (((0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg1)) as u128) * 375000 / 1000000) as u64), @0x7f8b101304fd38268da58ff3f68eee3b026a4cf5c8de73caaed6cd6a0a284256, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xb1dfb5c2d0246a4be189a761203f46e6358128860e036b5adea3046017f0618);
    }

    // decompiled from Move bytecode v6
}

