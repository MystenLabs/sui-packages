module 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_holder_rewards {
    struct Round<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        number: u64,
        claim_deadline_at_ms: u64,
        root: vector<u8>,
        leaf_count: u64,
        claimed: vector<u256>,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        treasury: address,
        gas_reserve: 0x1::option::Option<0x2::balance::Balance<T1>>,
    }

    public fun claim<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        assert!(0x2::clock::timestamp_ms(arg7) < arg0.claim_deadline_at_ms, 13838436343414784025);
        assert!(arg2 < arg0.leaf_count, 13836466022871859211);
        let (v0, v1) = claim_bit(arg2);
        assert!(*0x1::vector::borrow<u256>(&arg0.claimed, v0) & v1 == 0, 13836747506438635533);
        assert!(arg3 != @0x0, 13837028985710444559);
        assert!(arg4 > 0 || arg5 > 0, 13836184565074886665);
        assert!(0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::merkle::verify(arg0.root, 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::merkle::leaf(arg0.vault, arg0.number, arg2, arg3, arg4, arg5), arg2, arg0.leaf_count, &arg6), 13837310482162122769);
        *0x1::vector::borrow_mut<u256>(&mut arg0.claimed, v0) = *0x1::vector::borrow<u256>(&arg0.claimed, v0) | v1;
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::pay<T0>(&mut arg0.meme, arg4, arg3, arg8);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::pay<T1>(&mut arg0.quote, arg5, arg3, arg8);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::reward_paid(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote));
    }

    fun claim_bit(arg0: u64) : (u64, u256) {
        (arg0 / 256, 1 << ((arg0 % 256) as u8))
    }

    public fun close_round<T0, T1>(arg0: Round<T0, T1>, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &mut 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::LpVault<T0, T1>, arg3: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        assert!(arg0.vault == 0x2::object::id<0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::LpVault<T0, T1>>(arg2), 13838718114744369179);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.claim_deadline_at_ms, 13839562543969861665);
        let Round {
            id                   : v0,
            vault                : v1,
            number               : v2,
            claim_deadline_at_ms : _,
            root                 : _,
            leaf_count           : _,
            claimed              : _,
            meme                 : v7,
            quote                : v8,
            treasury             : _,
            gas_reserve          : v10,
        } = arg0;
        let v11 = v8;
        let v12 = v7;
        let v13 = v0;
        let v14 = v10;
        let v15 = if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v14)) {
            0x1::option::destroy_some<0x2::balance::Balance<T1>>(v14)
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v14);
            0x2::balance::zero<T1>()
        };
        let v16 = v15;
        0x2::balance::join<T1>(&mut v11, v16);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::restore_rewards<T0, T1>(arg2, v12, v11);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::round_closed(v1, 0x2::object::uid_to_inner(&v13), v2, 0x2::balance::value<T0>(&v12), 0x2::balance::value<T1>(&v11), 0x2::balance::value<T1>(&v16));
        0x2::object::delete(v13);
    }

    public fun publish_round<T0, T1>(arg0: &mut 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::LpVault<T0, T1>, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::RewardsAdmin>, arg3: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::lp_fee_policy::LpFeePolicy, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::lp_fee_policy::protocol_destination(arg3);
        assert!(v0 == arg4, 13837591562001973267);
        assert!(arg5 == 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::next_round<T0, T1>(arg0), 13835058291505364993);
        let v1 = if (arg6 < arg7) {
            let v2 = 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::last_checkpoint<T0, T1>(arg0);
            let v3 = &v2;
            0x1::option::is_none<u64>(v3) || *0x1::option::borrow<u64>(v3) <= arg6
        } else {
            false
        };
        assert!(v1, 13835339783662075907);
        assert!(0x1::vector::length<u8>(&arg8) == 32 && 0x1::vector::length<u8>(&arg9) == 32, 13835621280113754117);
        assert!(arg10 > 0 && arg10 <= 65536, 13835902763680530439);
        assert!(arg11 > 0 || arg12 > 0, 13836184242952339465);
        assert!(arg14 > 0x2::clock::timestamp_ms(arg15), 13837873101403324437);
        let (v4, v5) = 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::rewards_balances<T0, T1>(arg0);
        let v6 = if (arg11 <= v4) {
            if (arg12 <= v5) {
                arg13 <= v5 - arg12
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13838154602149969943);
        let v7 = 0x2::object::id<0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::LpVault<T0, T1>>(arg0);
        let (v8, v9) = 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::fund_round<T0, T1>(arg0, arg7, arg11, arg12 + arg13);
        let v10 = v9;
        let v11 = if (arg13 > 0) {
            0x1::option::some<0x2::balance::Balance<T1>>(0x2::balance::split<T1>(&mut v10, arg13))
        } else {
            0x1::option::none<0x2::balance::Balance<T1>>()
        };
        let v12 = Round<T0, T1>{
            id                   : 0x2::object::new(arg16),
            vault                : v7,
            number               : arg5,
            claim_deadline_at_ms : arg14,
            root                 : arg8,
            leaf_count           : arg10,
            claimed              : unclaimed(arg10),
            meme                 : v8,
            quote                : v10,
            treasury             : v0,
            gas_reserve          : v11,
        };
        let (v13, v14) = 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::rewards_balances<T0, T1>(arg0);
        0x2::transfer::share_object<Round<T0, T1>>(v12);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::round_published(v7, 0x2::object::uid_to_inner(&v12.id), arg5, arg6, arg7, arg14, arg8, arg9, arg10, arg11, arg12, v13, v14, v0, arg13);
    }

    public fun settle_gas_reserve<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::RewardsAdmin>, arg3: &mut 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::LpVault<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        assert!(arg0.vault == 0x2::object::id<0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::LpVault<T0, T1>>(arg3), 13838717981600383003);
        assert!(0x1::option::is_some<0x2::balance::Balance<T1>>(&arg0.gas_reserve), 13838999460872192029);
        assert!(arg4 <= 0x2::balance::value<T1>(0x1::option::borrow<0x2::balance::Balance<T1>>(&arg0.gas_reserve)), 13839280940144001055);
        let v0 = 0x1::option::extract<0x2::balance::Balance<T1>>(&mut arg0.gas_reserve);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::pay<T1>(&mut v0, arg4, arg0.treasury, arg5);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::restore_rewards<T0, T1>(arg3, 0x2::balance::zero<T0>(), v0);
        let (_, v2) = 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::vault::rewards_balances<T0, T1>(arg3);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::gas_reserve_settled(arg0.vault, 0x2::object::uid_to_inner(&arg0.id), arg0.number, arg0.treasury, arg4, 0x2::balance::value<T1>(&v0) - arg4, v2);
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

