module 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::holder_rewards {
    struct Round<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        number: u64,
        claim_deadline_ms: u64,
        root: vector<u8>,
        leaf_count: u64,
        claimed_bitmap: vector<u256>,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        treasury: address,
        gas_reserve: 0x1::option::Option<0x2::balance::Balance<T1>>,
    }

    struct RoundPublished<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        start_checkpoint: u64,
        end_checkpoint: u64,
        claim_deadline_ms: u64,
        root: vector<u8>,
        manifest_digest: vector<u8>,
        leaf_count: u64,
        meme_amount: u64,
        quote_amount: u64,
        meme_unallocated: u64,
        quote_unallocated: u64,
        treasury: address,
        gas_reserve_amount: u64,
    }

    struct RewardClaimed<phantom T0, phantom T1> has copy, drop {
        round_id: 0x2::object::ID,
        index: u64,
        beneficiary: address,
        meme_amount: u64,
        quote_amount: u64,
        meme_remaining: u64,
        quote_remaining: u64,
    }

    struct GasReserveSettled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        treasury: address,
        reimbursement_amount: u64,
        reserve_returned: u64,
        quote_unallocated: u64,
    }

    struct RoundClosed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        meme_returned: u64,
        quote_returned: u64,
        gas_reserve_returned: u64,
    }

    public fun claim<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::PackageVersion, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::assert_current(arg1);
        assert!(arg2 < arg0.leaf_count, 13836465997102120972);
        let (v0, v1) = claim_bit(arg2);
        assert!(*0x1::vector::borrow<u256>(&arg0.claimed_bitmap, v0) & v1 == 0, 13836747480668897294);
        assert!(arg3 != @0x0, 13837028959940706320);
        assert!(arg4 > 0 || arg5 > 0, 13838436339119882266);
        assert!(0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::merkle_tree::verify(arg0.root, leaf(arg0.vault_id, arg0.number, arg2, arg3, arg4, arg5), arg2, arg0.leaf_count, &arg6), 13837310447802449938);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.claimed_bitmap, v0);
        *v2 = *v2 | v1;
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale::pay<T0>(&mut arg0.meme, arg4, arg3, arg7);
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale::pay<T1>(&mut arg0.quote, arg5, arg3, arg7);
        let v3 = RewardClaimed<T0, T1>{
            round_id        : 0x2::object::uid_to_inner(&arg0.id),
            index           : arg2,
            beneficiary     : arg3,
            meme_amount     : arg4,
            quote_amount    : arg5,
            meme_remaining  : 0x2::balance::value<T0>(&arg0.meme),
            quote_remaining : 0x2::balance::value<T1>(&arg0.quote),
        };
        0x2::event::emit<RewardClaimed<T0, T1>>(v3);
    }

    fun claim_bit(arg0: u64) : (u64, u256) {
        (arg0 / 256, 1 << ((arg0 % 256) as u8))
    }

    public fun close_round<T0, T1>(arg0: Round<T0, T1>, arg1: &0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::PackageVersion, arg2: &mut 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::Vault<T0, T1>, arg3: &0x2::clock::Clock) {
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::assert_current(arg1);
        assert!(arg0.vault_id == 0x2::object::id<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::Vault<T0, T1>>(arg2), 13837873651159203862);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.claim_deadline_ms, 13838155130431012888);
        let Round {
            id                : v0,
            vault_id          : v1,
            number            : v2,
            claim_deadline_ms : _,
            root              : _,
            leaf_count        : _,
            claimed_bitmap    : _,
            meme              : v7,
            quote             : v8,
            treasury          : _,
            gas_reserve       : v10,
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
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::restore_holder_rewards<T0, T1>(arg2, v12, v11);
        let v17 = RoundClosed<T0, T1>{
            vault_id             : v1,
            round_id             : 0x2::object::uid_to_inner(&v13),
            number               : v2,
            meme_returned        : 0x2::balance::value<T0>(&v12),
            quote_returned       : 0x2::balance::value<T1>(&v11),
            gas_reserve_returned : 0x2::balance::value<T1>(&v16),
        };
        0x2::event::emit<RoundClosed<T0, T1>>(v17);
        0x2::object::delete(v13);
    }

    fun leaf(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = x"00626c6173742d70726573616c652d686f6c6465722d726577617264732d7631";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x2::hash::blake2b256(&v0)
    }

    public fun publish_round<T0, T1>(arg0: &mut 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::Vault<T0, T1>, arg1: &0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::PackageVersion, arg2: &0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::blast_acl::AdminWitness<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_domain::RewardsAdmin>, arg3: &0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::fee_policy::FeePolicy, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::assert_current(arg1);
        let v0 = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::fee_policy::destination(arg3);
        assert!(v0 == arg4, 13839561886839930914);
        assert!(arg5 == 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::next_round<T0, T1>(arg0), 13835058291505430530);
        let v1 = if (arg6 < arg7) {
            let v2 = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::last_checkpoint<T0, T1>(arg0);
            let v3 = &v2;
            0x1::option::is_none<u64>(v3) || *0x1::option::borrow<u64>(v3) <= arg6
        } else {
            false
        };
        assert!(v1, 13835339783662141444);
        assert!(0x1::vector::length<u8>(&arg8) == 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::merkle_tree::digest_length() && 0x1::vector::length<u8>(&arg9) == 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::merkle_tree::digest_length(), 13835621280113819654);
        assert!(arg10 > 0 && arg10 <= 65536, 13835902763680595976);
        assert!(arg11 > 0 || arg12 > 0, 13836184242952405002);
        assert!(arg14 > 0x2::clock::timestamp_ms(arg15), 13837591622131580948);
        let (v4, v5) = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::holder_rewards_balances<T0, T1>(arg0);
        let v6 = if (arg11 <= v4) {
            if (arg12 <= v5) {
                arg13 <= v5 - arg12
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13838717543513784348);
        let v7 = 0x2::object::id<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::Vault<T0, T1>>(arg0);
        let (v8, v9) = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::fund_round<T0, T1>(arg0, arg7, arg11, arg12 + arg13);
        let v10 = v9;
        let v11 = if (arg13 > 0) {
            0x1::option::some<0x2::balance::Balance<T1>>(0x2::balance::split<T1>(&mut v10, arg13))
        } else {
            0x1::option::none<0x2::balance::Balance<T1>>()
        };
        let v12 = Round<T0, T1>{
            id                : 0x2::object::new(arg16),
            vault_id          : v7,
            number            : arg5,
            claim_deadline_ms : arg14,
            root              : arg8,
            leaf_count        : arg10,
            claimed_bitmap    : unclaimed(arg10),
            meme              : v8,
            quote             : v10,
            treasury          : v0,
            gas_reserve       : v11,
        };
        let (v13, v14) = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::holder_rewards_balances<T0, T1>(arg0);
        let v15 = RoundPublished<T0, T1>{
            vault_id           : v7,
            round_id           : 0x2::object::uid_to_inner(&v12.id),
            number             : arg5,
            start_checkpoint   : arg6,
            end_checkpoint     : arg7,
            claim_deadline_ms  : arg14,
            root               : arg8,
            manifest_digest    : arg9,
            leaf_count         : arg10,
            meme_amount        : arg11,
            quote_amount       : arg12,
            meme_unallocated   : v13,
            quote_unallocated  : v14,
            treasury           : v0,
            gas_reserve_amount : arg13,
        };
        0x2::event::emit<RoundPublished<T0, T1>>(v15);
        0x2::transfer::share_object<Round<T0, T1>>(v12);
    }

    public fun settle_gas_reserve<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::PackageVersion, arg2: &0x65bffe80e883cc8b7bbb5049657e171b7f73502528d5b486d678eab6227d58bc::blast_acl::AdminWitness<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_domain::RewardsAdmin>, arg3: &mut 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::Vault<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale_package::assert_current(arg1);
        assert!(arg0.vault_id == 0x2::object::id<0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::Vault<T0, T1>>(arg3), 13837873522310184982);
        assert!(0x1::option::is_some<0x2::balance::Balance<T1>>(&arg0.gas_reserve), 13838999426512519198);
        assert!(arg4 <= 0x2::balance::value<T1>(0x1::option::borrow<0x2::balance::Balance<T1>>(&arg0.gas_reserve)), 13839280905784328224);
        let v0 = 0x1::option::extract<0x2::balance::Balance<T1>>(&mut arg0.gas_reserve);
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::blast_presale::pay<T1>(&mut v0, arg4, arg0.treasury, arg5);
        0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::restore_holder_rewards<T0, T1>(arg3, 0x2::balance::zero<T0>(), v0);
        let (_, v2) = 0xb40e077e5c7568294313897a42720c9b5ad4e497ed364adc9e220df5a7bcb3ce::presale_vault::holder_rewards_balances<T0, T1>(arg3);
        let v3 = GasReserveSettled<T0, T1>{
            vault_id             : arg0.vault_id,
            round_id             : 0x2::object::uid_to_inner(&arg0.id),
            number               : arg0.number,
            treasury             : arg0.treasury,
            reimbursement_amount : arg4,
            reserve_returned     : 0x2::balance::value<T1>(&v0) - arg4,
            quote_unallocated    : v2,
        };
        0x2::event::emit<GasReserveSettled<T0, T1>>(v3);
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

