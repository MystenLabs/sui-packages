module 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_holder_rewards {
    struct Round<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        number: u64,
        root: vector<u8>,
        leaf_count: u64,
        claimed: vector<u256>,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
    }

    public fun claim<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        assert!(arg2 < arg0.leaf_count, 13836465868253036555);
        let (v0, v1) = claim_bit(arg2);
        assert!(*0x1::vector::borrow<u256>(&arg0.claimed, v0) & v1 == 0, 13836747351819812877);
        assert!(arg3 != @0x0, 13837028831091621903);
        assert!(arg4 > 0 || arg5 > 0, 13836184410456064009);
        assert!(0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::merkle::verify(arg0.root, 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::merkle::leaf(arg0.vault, arg0.number, arg2, arg3, arg4, arg5), arg2, arg0.leaf_count, &arg6), 13837310327543300113);
        *0x1::vector::borrow_mut<u256>(&mut arg0.claimed, v0) = *0x1::vector::borrow<u256>(&arg0.claimed, v0) | v1;
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::pay<T0>(&mut arg0.meme, arg4, arg3, arg7);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::pay<T1>(&mut arg0.quote, arg5, arg3, arg7);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_events::reward_paid(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote));
    }

    fun claim_bit(arg0: u64) : (u64, u256) {
        (arg0 / 256, 1 << ((arg0 % 256) as u8))
    }

    public fun publish_round<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun_domain::RewardsAdmin>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        assert!(arg3 == 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::next_round<T0, T1>(arg0), 13835058239965757441);
        let v0 = if (arg4 < arg5) {
            let v1 = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::last_checkpoint<T0, T1>(arg0);
            let v2 = &v1;
            0x1::option::is_none<u64>(v2) || *0x1::option::borrow<u64>(v2) == arg4
        } else {
            false
        };
        assert!(v0, 13835339732122468355);
        assert!(0x1::vector::length<u8>(&arg6) == 32 && 0x1::vector::length<u8>(&arg7) == 32, 13835621228574146565);
        assert!(arg8 > 0 && arg8 <= 65536, 13835902712140922887);
        assert!(arg9 > 0 || arg10 > 0, 13836184191412731913);
        let v3 = 0x2::object::id<0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>>(arg0);
        let (v4, v5) = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::fund_round<T0, T1>(arg0, arg5, arg9, arg10);
        let v6 = Round<T0, T1>{
            id         : 0x2::object::new(arg11),
            vault      : v3,
            number     : arg3,
            root       : arg6,
            leaf_count : arg8,
            claimed    : unclaimed(arg8),
            meme       : v4,
            quote      : v5,
        };
        let (v7, v8) = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::rewards_balances<T0, T1>(arg0);
        0x2::transfer::share_object<Round<T0, T1>>(v6);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_events::round_published(v3, 0x2::object::uid_to_inner(&v6.id), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v7, v8);
    }

    fun unclaimed(arg0: u64) : vector<u256> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::u64::div_ceil(arg0, 256)) {
            0x1::vector::push_back<u256>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

