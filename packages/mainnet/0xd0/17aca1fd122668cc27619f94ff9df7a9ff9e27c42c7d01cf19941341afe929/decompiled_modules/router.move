module 0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::router {
    public entry fun allocate<T0>(arg0: &0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::AdminCap, arg1: &mut 0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::Pool<T0>, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::allocate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::create_pool<T0>(arg0);
    }

    public entry fun deposit<T0>(arg0: &mut 0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::Pool<T0>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg1)) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
            0x2::coin::zero<T0>(arg3)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
            0x2::pay::join_vec<T0>(&mut v1, arg1);
            v1
        };
        let v2 = v0;
        0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::deposit<T0>(arg0, &mut v2, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun redeem<T0>(arg0: &mut 0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::Pool<T0>, arg1: &mut 0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::VestingNFT, arg2: u16, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd017aca1fd122668cc27619f94ff9df7a9ff9e27c42c7d01cf19941341afe929::token_vesting::redeem<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

