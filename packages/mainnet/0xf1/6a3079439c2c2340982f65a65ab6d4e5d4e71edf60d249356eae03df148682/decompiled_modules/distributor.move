module 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::distributor {
    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        controller: address,
        reward_balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<u128, bool>,
        version: u64,
    }

    struct RewardsSignaturePayload has copy, drop {
        pool: address,
        receiver: address,
        amount: u64,
        nonce: u128,
    }

    struct Signature has copy, drop {
        sig: vector<u8>,
        pk: vector<u8>,
        scheme: u8,
    }

    entry fun claim_rewards<T0>(arg0: &mut RewardPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        assert!(0x1::vector::length<u8>(&arg1) == 88, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::invalid_size());
        assert!(0x1::vector::length<u8>(&arg2) == 99 || 0x1::vector::length<u8>(&arg2) == 100, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::invalid_size());
        let v0 = 0x2::bcs::new(arg1);
        let v1 = RewardsSignaturePayload{
            pool     : 0x2::bcs::peel_address(&mut v0),
            receiver : 0x2::bcs::peel_address(&mut v0),
            amount   : 0x2::bcs::peel_u64(&mut v0),
            nonce    : 0x2::bcs::peel_u128(&mut v0),
        };
        let v2 = 0x2::bcs::new(arg2);
        let v3 = Signature{
            sig    : 0x2::bcs::peel_vec_u8(&mut v2),
            pk     : 0x2::bcs::peel_vec_u8(&mut v2),
            scheme : 0x2::bcs::peel_u8(&mut v2),
        };
        let v4 = 0x1::hash::sha2_256(arg1);
        if (v3.scheme == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::secp256k1_scheme()) {
            assert!(0x2::ecdsa_k1::secp256k1_verify(&v3.sig, &v3.pk, &v4, 1), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::invalid_signature());
            0x1::vector::insert<u8>(&mut v3.pk, 1, 0);
        } else {
            assert!(v3.scheme == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::ed25519_scheme(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::unsupported_wallet_scheme());
            assert!(0x2::ed25519::ed25519_verify(&v3.sig, &v3.pk, &v4), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::invalid_signature());
            0x1::vector::insert<u8>(&mut v3.pk, 0, 0);
        };
        assert!(0x2::hash::blake2b256(&v3.pk) == 0x2::address::to_bytes(arg0.controller), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::not_pool_operator());
        assert!(v1.pool == 0x2::object::uid_to_address(&arg0.id), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::pool_address_dont_match());
        assert!(!0x2::table::contains<u128, bool>(&arg0.claimed, v1.nonce), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::already_claimed());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, v1.amount, arg3), v1.receiver);
        0x2::table::add<u128, bool>(&mut arg0.claimed, v1.nonce, true);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_rewards_claimed_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), v1.receiver, v1.amount, v1.nonce);
    }

    entry fun create_reward_pool<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::zero_address());
        let v0 = 0x2::object::new(arg2);
        let v1 = RewardPool<T0>{
            id             : v0,
            controller     : arg1,
            reward_balance : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<u128, bool>(arg2),
            version        : 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v1);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_created_rewards_pool_event(0x2::object::uid_to_inner(&v0), arg1);
    }

    entry fun fund_rewards_pool<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        0x2::coin::put<T0>(&mut arg0.reward_balance, arg1);
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_reward_amount_deposited_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.reward_balance));
    }

    entry fun update_rewards_controller<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: &mut RewardPool<T0>, arg2: address) {
        assert!(arg1.version == 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::constants::get_version(), 0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::errors::version_mismatch());
        arg1.controller = arg2;
        0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::events::emit_rewards_pool_controller_update_event(0x2::object::uid_to_inner(&arg1.id), arg2);
    }

    entry fun update_version_for_reward_pool<T0>(arg0: &0xfadc2a695e4d92612a203f5bfc48e9f0a5be4d6bad9d08b1e8f06ce9be7a3f5a::roles::AdminCap, arg1: &mut RewardPool<T0>) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

