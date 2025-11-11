module 0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropRegistry has key {
        id: 0x2::object::UID,
        merkle_roots: 0x2::table::Table<u8, 0x2::table::Table<u64, MerkleRoot>>,
        token_pool: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>,
        user_batch_claims: 0x2::table::Table<UserBatchClaimKey, bool>,
        nft_batch_claims: 0x2::table::Table<NftBatchClaimKey, bool>,
        paused: bool,
        airdrop_end_time: u64,
    }

    struct MerkleRoot has store {
        root: vector<u8>,
        created_at: u64,
    }

    struct UserBatchClaimKey has copy, drop, store {
        category: u8,
        user: address,
        batch_id: u64,
    }

    struct NftBatchClaimKey has copy, drop, store {
        category: u8,
        seq_id: u16,
        batch_id: u64,
    }

    public fun add_airdrop_batch(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = MerkleRoot{
            root       : arg4,
            created_at : v0,
        };
        let v2 = 0x2::table::borrow_mut<u8, 0x2::table::Table<u64, MerkleRoot>>(&mut arg1.merkle_roots, arg2);
        assert!(!0x2::table::contains<u64, MerkleRoot>(v2, arg3), 6);
        0x2::table::add<u64, MerkleRoot>(v2, arg3, v1);
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_batch_added(arg2, arg3, arg4, v0);
    }

    public fun airdrop_end_time(arg0: &AirdropRegistry) : u64 {
        arg0.airdrop_end_time
    }

    public fun claim_rewards(arg0: &mut AirdropRegistry, arg1: u8, arg2: u64, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT> {
        assert!(!arg0.paused, 1);
        assert!(!is_airdrop_ended(arg0, arg6), 10);
        assert!(arg4 > 0, 3);
        assert!(arg5 == 0, 5);
        assert!(arg1 == 0 || arg1 == 2, 11);
        let v0 = 0x2::tx_context::sender(arg7);
        verify_user_merkle_proof(arg0, arg1, arg2, &arg3, v0, arg4, arg5);
        let v1 = UserBatchClaimKey{
            category : arg1,
            user     : v0,
            batch_id : arg2,
        };
        assert!(!0x2::table::contains<UserBatchClaimKey, bool>(&arg0.user_batch_claims, v1), 7);
        0x2::table::add<UserBatchClaimKey, bool>(&mut arg0.user_batch_claims, v1, true);
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_tokens_claimed(v0, arg1, arg2, arg4, arg4, 0, 0x2::clock::timestamp_ms(arg6));
        0x2::coin::take<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg0.token_pool, arg4, arg7)
    }

    public fun claim_rewards_and_transfer(arg0: &mut AirdropRegistry, arg1: u8, arg2: u64, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(claim_rewards(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8), arg6);
    }

    public fun claim_rewards_v2(arg0: &mut AirdropRegistry, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg3: u8, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>, 0x1::option::Option<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>) {
        assert!(!arg0.paused, 1);
        assert!(!is_airdrop_ended(arg0, arg8), 10);
        assert!(arg6 > 0, 3);
        assert!(arg7 <= 100, 5);
        assert!(arg3 == 0 || arg3 == 2, 11);
        let v0 = 0x2::tx_context::sender(arg9);
        verify_user_merkle_proof(arg0, arg3, arg4, &arg5, v0, arg6, arg7);
        let v1 = UserBatchClaimKey{
            category : arg3,
            user     : v0,
            batch_id : arg4,
        };
        assert!(!0x2::table::contains<UserBatchClaimKey, bool>(&arg0.user_batch_claims, v1), 7);
        0x2::table::add<UserBatchClaimKey, bool>(&mut arg0.user_batch_claims, v1, true);
        let (v2, v3) = get_tokens(arg0, arg1, arg2, arg6, arg7, arg8, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = if (0x1::option::is_some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(&v5)) {
            0x2::coin::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(0x1::option::borrow<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(&v5))
        } else {
            0
        };
        let v7 = if (0x1::option::is_some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(&v4)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::balance(0x1::option::borrow<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(&v4))
        } else {
            0
        };
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_tokens_claimed(v0, arg3, arg4, arg6, v6, v7, 0x2::clock::timestamp_ms(arg8));
        (v5, v4)
    }

    public fun claim_rewards_v2_and_transfer(arg0: &mut AirdropRegistry, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg3: u8, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_rewards_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v2 = v0;
        if (0x1::option::is_some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(0x1::option::destroy_some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(v2), arg8);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(v2);
        };
        let v3 = v1;
        if (0x1::option::is_some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(&v3)) {
            0x2::transfer::public_transfer<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(0x1::option::destroy_some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(v3), arg8);
        } else {
            0x1::option::destroy_none<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(v3);
        };
    }

    public fun claim_title_deed_rewards(arg0: &mut AirdropRegistry, arg1: &0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed::TitleDeed, arg2: u64, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT> {
        assert!(!arg0.paused, 1);
        assert!(!is_airdrop_ended(arg0, arg6), 10);
        assert!(arg4 > 0, 3);
        assert!(arg5 == 0, 5);
        let v0 = 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed::seq_id(arg1);
        verify_nft_merkle_proof(arg0, 1, arg2, &arg3, v0, arg4, arg5);
        let v1 = NftBatchClaimKey{
            category : 1,
            seq_id   : v0,
            batch_id : arg2,
        };
        assert!(!0x2::table::contains<NftBatchClaimKey, bool>(&arg0.nft_batch_claims, v1), 7);
        0x2::table::add<NftBatchClaimKey, bool>(&mut arg0.nft_batch_claims, v1, true);
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_tokens_claimed(0x2::tx_context::sender(arg7), 1, arg2, arg4, arg4, 0, 0x2::clock::timestamp_ms(arg6));
        0x2::coin::take<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg0.token_pool, arg4, arg7)
    }

    public fun claim_title_deed_rewards_and_transfer(arg0: &mut AirdropRegistry, arg1: &0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed::TitleDeed, arg2: u64, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(claim_title_deed_rewards(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8), arg6);
    }

    public fun claim_title_deed_rewards_v2(arg0: &mut AirdropRegistry, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg3: &0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed::TitleDeed, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>, 0x1::option::Option<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>) {
        assert!(!arg0.paused, 1);
        assert!(!is_airdrop_ended(arg0, arg8), 10);
        assert!(arg6 > 0, 3);
        assert!(arg7 <= 100, 5);
        let v0 = 0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed::seq_id(arg3);
        verify_nft_merkle_proof(arg0, 1, arg4, &arg5, v0, arg6, arg7);
        let v1 = NftBatchClaimKey{
            category : 1,
            seq_id   : v0,
            batch_id : arg4,
        };
        assert!(!0x2::table::contains<NftBatchClaimKey, bool>(&arg0.nft_batch_claims, v1), 7);
        0x2::table::add<NftBatchClaimKey, bool>(&mut arg0.nft_batch_claims, v1, true);
        let (v2, v3) = get_tokens(arg0, arg1, arg2, arg6, arg7, arg8, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = if (0x1::option::is_some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(&v5)) {
            0x2::coin::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(0x1::option::borrow<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(&v5))
        } else {
            0
        };
        let v7 = if (0x1::option::is_some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(&v4)) {
            0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::balance(0x1::option::borrow<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(&v4))
        } else {
            0
        };
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_tokens_claimed(0x2::tx_context::sender(arg9), 1, arg4, arg6, v6, v7, 0x2::clock::timestamp_ms(arg8));
        (v5, v4)
    }

    public fun claim_title_deed_rewards_v2_and_transfer(arg0: &mut AirdropRegistry, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg3: &0x17e299f57874f7460ff8eec1d6e542702e1bec88fe7b93e8fbc5a4cbbe637e2e::title_deed::TitleDeed, arg4: u64, arg5: vector<vector<u8>>, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_title_deed_rewards_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v2 = v0;
        if (0x1::option::is_some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(0x1::option::destroy_some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(v2), arg8);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(v2);
        };
        let v3 = v1;
        if (0x1::option::is_some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(&v3)) {
            0x2::transfer::public_transfer<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(0x1::option::destroy_some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(v3), arg8);
        } else {
            0x1::option::destroy_none<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(v3);
        };
    }

    public fun deposit_tokens(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: 0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg3: &0x2::clock::Clock) {
        0x2::balance::join<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg1.token_pool, 0x2::coin::into_balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(arg2));
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_tokens_deposited(0x2::coin::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg2), 0x2::clock::timestamp_ms(arg3));
    }

    fun get_tokens(arg0: &mut AirdropRegistry, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>, 0x1::option::Option<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>) {
        let v0 = 0x2::balance::split<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg0.token_pool, arg3);
        let v1 = arg3 * arg4 / 100;
        let v2 = if (v1 > 0) {
            0x1::option::some<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::user_v1::create_with_stake(arg1, arg2, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::max_bond_unbond_at(), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::bond_mode_max_bond(), 0x2::balance::split<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut v0, v1), arg5, arg6))
        } else {
            0x1::option::none<0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_token::VeToken>()
        };
        let v3 = if (arg3 - v1 > 0) {
            0x1::option::some<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(0x2::coin::from_balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(v0, arg6))
        } else {
            0x2::balance::destroy_zero<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(v0);
            0x1::option::none<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>()
        };
        (v3, v2)
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, 0x2::table::Table<u64, MerkleRoot>>(arg1);
        0x2::table::add<u8, 0x2::table::Table<u64, MerkleRoot>>(&mut v0, 0, 0x2::table::new<u64, MerkleRoot>(arg1));
        0x2::table::add<u8, 0x2::table::Table<u64, MerkleRoot>>(&mut v0, 1, 0x2::table::new<u64, MerkleRoot>(arg1));
        0x2::table::add<u8, 0x2::table::Table<u64, MerkleRoot>>(&mut v0, 2, 0x2::table::new<u64, MerkleRoot>(arg1));
        let v1 = AirdropRegistry{
            id                : 0x2::object::new(arg1),
            merkle_roots      : v0,
            token_pool        : 0x2::balance::zero<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(),
            user_batch_claims : 0x2::table::new<UserBatchClaimKey, bool>(arg1),
            nft_batch_claims  : 0x2::table::new<NftBatchClaimKey, bool>(arg1),
            paused            : false,
            airdrop_end_time  : 0,
        };
        0x2::transfer::share_object<AirdropRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun is_airdrop_ended(arg0: &AirdropRegistry, arg1: &0x2::clock::Clock) : bool {
        arg0.airdrop_end_time != 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.airdrop_end_time
    }

    public fun is_nft_batch_claimed(arg0: &AirdropRegistry, arg1: u8, arg2: u16, arg3: u64) : bool {
        let v0 = NftBatchClaimKey{
            category : arg1,
            seq_id   : arg2,
            batch_id : arg3,
        };
        0x2::table::contains<NftBatchClaimKey, bool>(&arg0.nft_batch_claims, v0)
    }

    public fun is_paused(arg0: &AirdropRegistry) : bool {
        arg0.paused
    }

    public fun is_user_batch_claimed(arg0: &AirdropRegistry, arg1: u8, arg2: address, arg3: u64) : bool {
        let v0 = UserBatchClaimKey{
            category : arg1,
            user     : arg2,
            batch_id : arg3,
        };
        0x2::table::contains<UserBatchClaimKey, bool>(&arg0.user_batch_claims, v0)
    }

    public fun pause(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: &0x2::clock::Clock) {
        assert!(!arg1.paused, 9);
        arg1.paused = true;
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_paused(0x2::clock::timestamp_ms(arg2));
    }

    public fun remaining_tokens(arg0: &AirdropRegistry) : u64 {
        0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg0.token_pool)
    }

    public fun remove_airdrop_batch(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<u8, 0x2::table::Table<u64, MerkleRoot>>(&mut arg1.merkle_roots, arg2);
        assert!(0x2::table::contains<u64, MerkleRoot>(v0, arg3), 4);
        let MerkleRoot {
            root       : _,
            created_at : _,
        } = 0x2::table::remove<u64, MerkleRoot>(v0, arg3);
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_batch_removed(arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun set_airdrop_end_time(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        arg1.airdrop_end_time = arg2;
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_airdrop_end_time_set(arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: &0x2::clock::Clock) {
        assert!(arg1.paused, 8);
        arg1.paused = false;
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_unpaused(0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun verify_nft_merkle_proof(arg0: &AirdropRegistry, arg1: u8, arg2: u64, arg3: &vector<vector<u8>>, arg4: u16, arg5: u64, arg6: u64) {
        let v0 = 0x2::table::borrow<u8, 0x2::table::Table<u64, MerkleRoot>>(&arg0.merkle_roots, arg1);
        assert!(0x2::table::contains<u64, MerkleRoot>(v0, arg2), 4);
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u16>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u8>(&arg1));
        assert!(0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::merkle_proof::verify(arg3, &0x2::table::borrow<u64, MerkleRoot>(v0, arg2).root, &v1), 2);
    }

    public(friend) fun verify_user_merkle_proof(arg0: &AirdropRegistry, arg1: u8, arg2: u64, arg3: &vector<vector<u8>>, arg4: address, arg5: u64, arg6: u64) {
        let v0 = 0x2::table::borrow<u8, 0x2::table::Table<u64, MerkleRoot>>(&arg0.merkle_roots, arg1);
        assert!(0x2::table::contains<u64, MerkleRoot>(v0, arg2), 4);
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u8>(&arg1));
        assert!(0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::merkle_proof::verify(arg3, &0x2::table::borrow<u64, MerkleRoot>(v0, arg2).root, &v1), 2);
    }

    public fun withdraw_tokens(arg0: &AdminCap, arg1: &mut AirdropRegistry, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg3 <= 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg1.token_pool), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>>(0x2::coin::take<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg1.token_pool, arg3, arg5), arg2);
        0xfd770f276ba8a35b0f19ac4547d50eeba5a3be779d4b829e425f7b391645cd9f::events::emit_tokens_withdrawn(arg2, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v6
}

