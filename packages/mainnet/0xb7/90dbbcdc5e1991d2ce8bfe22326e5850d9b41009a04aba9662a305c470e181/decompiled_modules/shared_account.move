module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account {
    struct SharedAccount has store {
        shares: vector<Share>,
        total_shares: u64,
    }

    struct Share has store {
        account: address,
        share: u64,
    }

    public(friend) fun create_shared_account(arg0: vector<address>, arg1: vector<u64>) : SharedAccount {
        let v0 = 0;
        let v1 = 0x1::vector::empty<Share>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut arg1);
            let v4 = Share{
                account : 0x1::vector::pop_back<address>(&mut arg0),
                share   : v3,
            };
            0x1::vector::push_back<Share>(&mut v1, v4);
            v0 = v0 + v3;
            v2 = v2 + 1;
        };
        SharedAccount{
            shares       : v1,
            total_shares : v0,
        }
    }

    public fun disperse<T0>(arg0: &SharedAccount, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Share>(&arg0.shares) - 1) {
            let v2 = 0x1::vector::borrow<Share>(&arg0.shares, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v0, 0x2::coin::value<T0>(&arg1) * v2.share / arg0.total_shares, arg2), v2.account);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), 0x1::vector::borrow<Share>(&arg0.shares, v1).account);
    }

    // decompiled from Move bytecode v6
}

