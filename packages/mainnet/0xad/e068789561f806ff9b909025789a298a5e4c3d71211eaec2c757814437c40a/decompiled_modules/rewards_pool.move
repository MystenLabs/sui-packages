module 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::rewards_pool {
    struct RewardsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        rewards: 0x2::coin::Coin<T0>,
        pubkey: vector<u8>,
        users: 0x2::table::Table<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>,
    }

    struct UserClaim has store {
        claimed: u64,
    }

    public(friend) fun new<T0>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : RewardsPool<T0> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 4);
        RewardsPool<T0>{
            id      : 0x2::object::new(arg1),
            rewards : 0x2::coin::zero<T0>(arg1),
            pubkey  : arg0,
            users   : 0x2::table::new<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>(arg1),
        }
    }

    public(friend) fun add_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.rewards, arg1);
    }

    public(friend) fun query_claimed<T0>(arg0: &RewardsPool<T0>, arg1: address, arg2: u64) : u64 {
        let v0 = 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::signature::get_bytes41_key_direct(arg1, arg2);
        let v1 = 0;
        if (0x2::table::contains<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>(&arg0.users, v0)) {
            v1 = 0x2::table::borrow<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>(&arg0.users, v0).claimed;
        };
        v1
    }

    public(friend) fun redeem_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg6) / 1000, 2);
        let v0 = 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::signature::new(10, 0x2::object::id<RewardsPool<T0>>(arg0), arg1, arg2, arg3, arg4, arg5);
        assert!(0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::signature::verify_signature_ed25519(&v0, arg0.pubkey), 1);
        let v1 = 0xade068789561f806ff9b909025789a298a5e4c3d71211eaec2c757814437c40a::signature::get_bytes41_key(&v0);
        let v2 = if (0x2::table::contains<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>(&arg0.users, v1)) {
            let v3 = 0x2::table::borrow_mut<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>(&mut arg0.users, v1);
            assert!(arg3 > v3.claimed, 3);
            v3.claimed = arg3;
            arg3 - v3.claimed
        } else {
            let v4 = UserClaim{claimed: arg3};
            0x2::table::add<0x9a4bcdf5ecf025749a16878d9baaf991b334e7b44895503529c66c6a405d6244::bytes41::Bytes41, UserClaim>(&mut arg0.users, v1, v4);
            arg3
        };
        withdraw_rewards<T0>(arg0, v2, arg7)
    }

    public(friend) fun update_signer_pk<T0>(arg0: &mut RewardsPool<T0>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        arg0.pubkey = arg1;
    }

    public(friend) fun withdraw_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(&mut arg0.rewards, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

