module 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::holder_rewards {
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
    }

    struct RoundClosed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        meme_returned: u64,
        quote_returned: u64,
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

    public fun claim<T0, T1>(arg0: &mut Round<T0, T1>, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < arg0.leaf_count, 13836465863958134796);
        let (v0, v1) = claim_bit(arg1);
        assert!(*0x1::vector::borrow<u256>(&arg0.claimed_bitmap, v0) & v1 == 0, 13836747351819878414);
        assert!(arg2 != @0x0, 13837028831091687440);
        assert!(arg3 > 0 || arg4 > 0, 13838436210270863386);
        assert!(0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::merkle_tree::verify(arg0.root, leaf(arg0.vault_id, arg0.number, arg1, arg2, arg3, arg4), arg1, arg0.leaf_count, &arg5), 13837310331838332946);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.claimed_bitmap, v0);
        *v2 = *v2 | v1;
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::pay<T0>(&mut arg0.meme, arg3, arg2, arg6);
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale::pay<T1>(&mut arg0.quote, arg4, arg2, arg6);
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

    public fun close_round<T0, T1>(arg0: Round<T0, T1>, arg1: &mut 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.vault_id == 0x2::object::id<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::Vault<T0, T1>>(arg1), 13837873397756133398);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.claim_deadline_ms, 13838154877027942424);
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
        } = arg0;
        let v9 = v8;
        let v10 = v7;
        let v11 = v0;
        0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::restore_holder_rewards<T0, T1>(arg1, v10, v9);
        let v12 = RoundClosed<T0, T1>{
            vault_id       : v1,
            round_id       : 0x2::object::uid_to_inner(&v11),
            number         : v2,
            meme_returned  : 0x2::balance::value<T0>(&v10),
            quote_returned : 0x2::balance::value<T1>(&v9),
        };
        0x2::event::emit<RoundClosed<T0, T1>>(v12);
        0x2::object::delete(v11);
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

    public fun publish_round<T0, T1>(arg0: &mut 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::Vault<T0, T1>, arg1: &0x726fb49b880faa89719b95c6ef3a91be794f771ed3560fe5894d0a605c8469f9::blast_acl::AdminWitness<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::blast_presale_domain::RewardsAdmin>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::next_round<T0, T1>(arg0), 13835058235670855682);
        let v0 = if (arg3 < arg4) {
            let v1 = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::last_checkpoint<T0, T1>(arg0);
            let v2 = &v1;
            0x1::option::is_none<u64>(v2) || *0x1::option::borrow<u64>(v2) == arg3
        } else {
            false
        };
        assert!(v0, 13835339727827566596);
        assert!(0x1::vector::length<u8>(&arg5) == 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::merkle_tree::digest_length() && 0x1::vector::length<u8>(&arg6) == 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::merkle_tree::digest_length(), 13835621224279244806);
        assert!(arg7 > 0 && arg7 <= 65536, 13835902707846021128);
        assert!(arg8 > 0 || arg9 > 0, 13836184187117830154);
        assert!(arg10 > 0x2::clock::timestamp_ms(arg11), 13837591566297006100);
        let v3 = 0x2::object::id<0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::Vault<T0, T1>>(arg0);
        let (v4, v5) = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::fund_round<T0, T1>(arg0, arg4, arg8, arg9);
        let v6 = Round<T0, T1>{
            id                : 0x2::object::new(arg12),
            vault_id          : v3,
            number            : arg2,
            claim_deadline_ms : arg10,
            root              : arg5,
            leaf_count        : arg7,
            claimed_bitmap    : unclaimed(arg7),
            meme              : v4,
            quote             : v5,
        };
        let (v7, v8) = 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::presale_vault::holder_rewards_balances<T0, T1>(arg0);
        let v9 = RoundPublished<T0, T1>{
            vault_id          : v3,
            round_id          : 0x2::object::uid_to_inner(&v6.id),
            number            : arg2,
            start_checkpoint  : arg3,
            end_checkpoint    : arg4,
            claim_deadline_ms : arg10,
            root              : arg5,
            manifest_digest   : arg6,
            leaf_count        : arg7,
            meme_amount       : arg8,
            quote_amount      : arg9,
            meme_unallocated  : v7,
            quote_unallocated : v8,
        };
        0x2::event::emit<RoundPublished<T0, T1>>(v9);
        0x2::transfer::share_object<Round<T0, T1>>(v6);
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

