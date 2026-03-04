module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::batch_transfer {
    public fun batch_transfer(arg0: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>, 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v2);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg0) >= v1, 1);
        let v3 = 0;
        while (v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(0x2::coin::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v3), arg3), *0x1::vector::borrow<address>(&arg1, v3));
            v3 = v3 + 1;
        };
        (0x1::vector::empty<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(), arg0)
    }

    // decompiled from Move bytecode v6
}

