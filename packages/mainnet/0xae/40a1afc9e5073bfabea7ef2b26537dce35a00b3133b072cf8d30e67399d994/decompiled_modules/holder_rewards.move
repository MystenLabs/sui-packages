module 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::holder_rewards {
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

    public fun claim<T0, T1>(arg0: &mut Round<T0, T1>, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < arg0.leaf_count, 13836465881138003980);
        let (v0, v1) = claim_bit(arg1);
        assert!(*0x1::vector::borrow<u256>(&arg0.claimed_bitmap, v0) & v1 == 0, 13836747364704780302);
        assert!(arg2 != @0x0, 13837028843976589328);
        assert!(arg3 > 0 || arg4 > 0, 13838436223155765274);
        assert!(0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::merkle_tree::verify(arg0.root, leaf(arg0.vault_id, arg0.number, arg1, arg2, arg3, arg4), arg1, arg0.leaf_count, &arg5), 13837310340428267538);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.claimed_bitmap, v0);
        *v2 = *v2 | v1;
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::pay<T0>(&mut arg0.meme, arg3, arg2, arg6);
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::pay<T1>(&mut arg0.quote, arg4, arg2, arg6);
        let v3 = RewardClaimed<T0, T1>{
            round_id        : 0x2::object::uid_to_inner(&arg0.id),
            index           : arg1,
            beneficiary     : arg2,
            meme_amount     : arg3,
            quote_amount    : arg4,
            meme_remaining  : 0x2::balance::value<T0>(&arg0.meme),
            quote_remaining : 0x2::balance::value<T1>(&arg0.quote),
        };
        0x2::event::emit<RewardClaimed<T0, T1>>(v3);
    }

    fun claim_bit(arg0: u64) : (u64, u256) {
        (arg0 / 256, 1 << ((arg0 % 256) as u8))
    }

    public fun close_round<T0, T1>(arg0: Round<T0, T1>, arg1: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.vault_id == 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>>(arg1), 13837873479360512022);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.claim_deadline_ms, 13838154958632321048);
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
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::restore_holder_rewards<T0, T1>(arg1, v12, v11);
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

    public fun publish_round<T0, T1>(arg0: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale_domain::RewardsAdmin>, arg2: &0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::fee_policy::FeePolicy, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::fee_policy::destination(arg2);
        assert!(v0 == arg3, 13839561873955029026);
        assert!(arg4 == 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::next_round<T0, T1>(arg0), 13835058278620528642);
        let v1 = if (arg5 < arg6) {
            let v2 = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::last_checkpoint<T0, T1>(arg0);
            let v3 = &v2;
            0x1::option::is_none<u64>(v3) || *0x1::option::borrow<u64>(v3) <= arg5
        } else {
            false
        };
        assert!(v1, 13835339770777239556);
        assert!(0x1::vector::length<u8>(&arg7) == 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::merkle_tree::digest_length() && 0x1::vector::length<u8>(&arg8) == 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::merkle_tree::digest_length(), 13835621267228917766);
        assert!(arg9 > 0 && arg9 <= 65536, 13835902750795694088);
        assert!(arg10 > 0 || arg11 > 0, 13836184230067503114);
        assert!(arg13 > 0x2::clock::timestamp_ms(arg14), 13837591609246679060);
        let (v4, v5) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::holder_rewards_balances<T0, T1>(arg0);
        let v6 = if (arg10 <= v4) {
            if (arg11 <= v5) {
                arg12 <= v5 - arg11
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 13838717530628882460);
        let v7 = 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>>(arg0);
        let (v8, v9) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::fund_round<T0, T1>(arg0, arg6, arg10, arg11 + arg12);
        let v10 = v9;
        let v11 = if (arg12 > 0) {
            0x1::option::some<0x2::balance::Balance<T1>>(0x2::balance::split<T1>(&mut v10, arg12))
        } else {
            0x1::option::none<0x2::balance::Balance<T1>>()
        };
        let v12 = Round<T0, T1>{
            id                : 0x2::object::new(arg15),
            vault_id          : v7,
            number            : arg4,
            claim_deadline_ms : arg13,
            root              : arg7,
            leaf_count        : arg9,
            claimed_bitmap    : unclaimed(arg9),
            meme              : v8,
            quote             : v10,
            treasury          : v0,
            gas_reserve       : v11,
        };
        let (v13, v14) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::holder_rewards_balances<T0, T1>(arg0);
        let v15 = RoundPublished<T0, T1>{
            vault_id           : v7,
            round_id           : 0x2::object::uid_to_inner(&v12.id),
            number             : arg4,
            start_checkpoint   : arg5,
            end_checkpoint     : arg6,
            claim_deadline_ms  : arg13,
            root               : arg7,
            manifest_digest    : arg8,
            leaf_count         : arg9,
            meme_amount        : arg10,
            quote_amount       : arg11,
            meme_unallocated   : v13,
            quote_unallocated  : v14,
            treasury           : v0,
            gas_reserve_amount : arg12,
        };
        0x2::event::emit<RoundPublished<T0, T1>>(v15);
        0x2::transfer::share_object<Round<T0, T1>>(v12);
    }

    public fun settle_gas_reserve<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale_domain::RewardsAdmin>, arg2: &mut 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == 0x2::object::id<0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::Vault<T0, T1>>(arg2), 13837873384871231510);
        assert!(0x1::option::is_some<0x2::balance::Balance<T1>>(&arg0.gas_reserve), 13838999289073565726);
        assert!(arg3 <= 0x2::balance::value<T1>(0x1::option::borrow<0x2::balance::Balance<T1>>(&arg0.gas_reserve)), 13839280768345374752);
        let v0 = 0x1::option::extract<0x2::balance::Balance<T1>>(&mut arg0.gas_reserve);
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::blast_presale::pay<T1>(&mut v0, arg3, arg0.treasury, arg4);
        0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::restore_holder_rewards<T0, T1>(arg2, 0x2::balance::zero<T0>(), v0);
        let (_, v2) = 0xae40a1afc9e5073bfabea7ef2b26537dce35a00b3133b072cf8d30e67399d994::presale_vault::holder_rewards_balances<T0, T1>(arg2);
        let v3 = GasReserveSettled<T0, T1>{
            vault_id             : arg0.vault_id,
            round_id             : 0x2::object::uid_to_inner(&arg0.id),
            number               : arg0.number,
            treasury             : arg0.treasury,
            reimbursement_amount : arg3,
            reserve_returned     : 0x2::balance::value<T1>(&v0) - arg3,
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

