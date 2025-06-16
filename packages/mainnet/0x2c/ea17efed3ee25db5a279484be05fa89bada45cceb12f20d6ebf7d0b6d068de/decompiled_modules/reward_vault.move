module 0x2cea17efed3ee25db5a279484be05fa89bada45cceb12f20d6ebf7d0b6d068de::reward_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        registered_types: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        controller_pk: vector<u8>,
        reward_balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<u128, bool>,
    }

    struct SignaturePayload has copy, drop {
        pool_id: address,
        receiver: address,
        amount: u64,
        expiry: u64,
        nonce: u128,
    }

    struct RewardPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::string::String,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        claimer: address,
        receiver: address,
        amount: u64,
        nonce: u128,
    }

    struct RewardDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        total_balance: u64,
    }

    struct ControllerUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        new_controller_pk: vector<u8>,
    }

    public entry fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut RewardPool<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = verify_signature(arg0, 0x2::object::uid_to_inner(&arg1.id), &arg1.controller_pk, arg2, arg3);
        claim_rewards_internal<T0>(arg1, v0.receiver, v0.amount, v0.nonce, arg4);
    }

    fun claim_rewards_internal<T0>(arg0: &mut RewardPool<T0>, arg1: address, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u128, bool>(&arg0.claimed, arg3), 1);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= arg2, 2);
        assert!(arg1 != @0x0, 3);
        0x2::table::add<u128, bool>(&mut arg0.claimed, arg3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, arg2, arg4), arg1);
        let v0 = RewardsClaimed{
            pool_id  : 0x2::object::uid_to_inner(&arg0.id),
            claimer  : 0x2::tx_context::sender(arg4),
            receiver : arg1,
            amount   : arg2,
            nonce    : arg3,
        };
        0x2::event::emit<RewardsClaimed>(v0);
    }

    public entry fun create_reward_pool<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.registered_types, v0), 7);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = RewardPool<T0>{
            id             : v1,
            controller_pk  : arg2,
            reward_balance : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<u128, bool>(arg3),
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.registered_types, v0, v2);
        let v4 = RewardPoolCreated{
            pool_id    : v2,
            token_type : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
        };
        0x2::event::emit<RewardPoolCreated>(v4);
        0x2::transfer::share_object<RewardPool<T0>>(v3);
    }

    public entry fun emergency_withdraw<T0>(arg0: &AdminCap, arg1: &mut RewardPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.reward_balance) >= arg2, 2);
        assert!(arg3 != @0x0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.reward_balance, arg2, arg4), arg3);
    }

    public entry fun fund_rewards_pool<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.reward_balance, arg1);
        let v0 = RewardDeposited{
            pool_id       : 0x2::object::uid_to_inner(&arg0.id),
            depositor     : 0x2::tx_context::sender(arg2),
            amount        : 0x2::coin::value<T0>(&arg1),
            total_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<RewardDeposited>(v0);
    }

    public fun get_pool_balance<T0>(arg0: &RewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id               : 0x2::object::new(arg0),
            registered_types : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun is_nonce_claimed<T0>(arg0: &RewardPool<T0>, arg1: u128) : bool {
        0x2::table::contains<u128, bool>(&arg0.claimed, arg1)
    }

    public entry fun update_rewards_controller<T0>(arg0: &AdminCap, arg1: &mut RewardPool<T0>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        arg1.controller_pk = arg2;
        let v0 = ControllerUpdated{
            pool_id           : 0x2::object::uid_to_inner(&arg1.id),
            new_controller_pk : arg2,
        };
        0x2::event::emit<ControllerUpdated>(v0);
    }

    fun verify_signature(arg0: &0x2::clock::Clock, arg1: 0x2::object::ID, arg2: &vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : SignaturePayload {
        let v0 = 0x2::bcs::new(arg3);
        let v1 = SignaturePayload{
            pool_id  : 0x2::bcs::peel_address(&mut v0),
            receiver : 0x2::bcs::peel_address(&mut v0),
            amount   : 0x2::bcs::peel_u64(&mut v0),
            expiry   : 0x2::bcs::peel_u64(&mut v0),
            nonce    : 0x2::bcs::peel_u128(&mut v0),
        };
        assert!(v1.pool_id == 0x2::object::id_to_address(&arg1), 6);
        assert!(v1.expiry == 0 || v1.expiry > 0x2::clock::timestamp_ms(arg0), 4);
        let v2 = 0x1::hash::sha2_256(arg3);
        assert!(0x2::ed25519::ed25519_verify(&arg4, arg2, &v2), 5);
        v1
    }

    // decompiled from Move bytecode v6
}

