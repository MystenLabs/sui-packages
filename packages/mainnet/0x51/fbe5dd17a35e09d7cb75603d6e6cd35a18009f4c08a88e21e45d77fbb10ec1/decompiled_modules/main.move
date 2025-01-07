module 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::main {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config<phantom T0> has store, key {
        id: 0x2::object::UID,
        enable: bool,
        start_at: u64,
        end_at: u64,
        merkle_root: 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::Bytes32,
        token: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<address, u64>,
    }

    struct OwnerCapCreated has copy, drop {
        owner: address,
        owner_cap_id: address,
    }

    struct ConfigCreated has copy, drop {
        creator: address,
        config_id: address,
    }

    struct ConfigTimeUpdated has copy, drop {
        sender: address,
        config_id: address,
        start_at: u64,
        end_at: u64,
    }

    struct ConfigStateUpdated has copy, drop {
        sender: address,
        config_id: address,
        enable: bool,
    }

    struct ConfigMerkleRootUpdated has copy, drop {
        sender: address,
        config_id: address,
        merkle_root: address,
    }

    struct ConfigDepositToken has copy, drop {
        sender: address,
        config_id: address,
        amount: u64,
    }

    struct ConfigWithdrawToken has copy, drop {
        sender: address,
        config_id: address,
        amount: u64,
    }

    struct UserClaimed has copy, drop {
        user: address,
        config_id: address,
        amount: u64,
    }

    public entry fun claim_token<T0>(arg0: &0x2::clock::Clock, arg1: &mut Config<T0>, arg2: u64, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(claim_token_internal<T0>(arg0, arg1, v0, arg2, arg3), arg4), v0);
    }

    fun claim_token_internal<T0>(arg0: &0x2::clock::Clock, arg1: &mut Config<T0>, arg2: address, arg3: u64, arg4: vector<address>) : 0x2::balance::Balance<T0> {
        assert!(arg1.enable, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::airdrop_closed());
        assert!(0x2::clock::timestamp_ms(arg0) >= arg1.start_at && 0x2::clock::timestamp_ms(arg0) <= arg1.end_at, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::invalid_time());
        assert!(!0x2::table::contains<address, u64>(&arg1.claimed, arg2), 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::already_claimed());
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg3 as u256))));
        assert!(0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::merkle_tree::verify(0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector_addresses(arg4), arg1.merkle_root, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(0x2::hash::keccak256(&v0))), 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::invalid_proof());
        0x2::table::add<address, u64>(&mut arg1.claimed, arg2, arg3);
        let v1 = UserClaimed{
            user      : arg2,
            config_id : 0x2::object::uid_to_address(&arg1.id),
            amount    : arg3,
        };
        0x2::event::emit<UserClaimed>(v1);
        0x2::balance::split<T0>(&mut arg1.token, arg3)
    }

    public fun claim_token_non_entry<T0>(arg0: &0x2::clock::Clock, arg1: &mut Config<T0>, arg2: u64, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        claim_token_internal<T0>(arg0, arg1, 0x2::tx_context::sender(arg4), arg2, arg3)
    }

    public fun create_config<T0>(arg0: &OwnerCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Config<T0>{
            id          : v0,
            enable      : true,
            start_at    : arg1,
            end_at      : arg2,
            merkle_root : 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(0x2::address::to_bytes(arg3)),
            token       : 0x2::balance::zero<T0>(),
            claimed     : 0x2::table::new<address, u64>(arg4),
        };
        0x2::transfer::share_object<Config<T0>>(v1);
        let v2 = ConfigCreated{
            creator   : 0x2::tx_context::sender(arg4),
            config_id : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<ConfigCreated>(v2);
    }

    public fun deposit_config_token<T0>(arg0: &OwnerCap, arg1: &mut Config<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::insufficient_balance());
        0x2::balance::join<T0>(&mut arg1.token, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)));
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        let v0 = ConfigDepositToken{
            sender    : 0x2::tx_context::sender(arg4),
            config_id : 0x2::object::uid_to_address(&arg1.id),
            amount    : arg3,
        };
        0x2::event::emit<ConfigDepositToken>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = OwnerCap{id: v1};
        0x2::transfer::public_transfer<OwnerCap>(v2, v0);
        let v3 = OwnerCapCreated{
            owner        : v0,
            owner_cap_id : 0x2::object::uid_to_address(&v1),
        };
        0x2::event::emit<OwnerCapCreated>(v3);
    }

    public fun update_config_merkle<T0>(arg0: &OwnerCap, arg1: &mut Config<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        arg1.merkle_root = 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::bytes32::from_vector(0x2::address::to_bytes(arg2));
        let v0 = ConfigMerkleRootUpdated{
            sender      : 0x2::tx_context::sender(arg3),
            config_id   : 0x2::object::uid_to_address(&arg1.id),
            merkle_root : arg2,
        };
        0x2::event::emit<ConfigMerkleRootUpdated>(v0);
    }

    public fun update_config_state<T0>(arg0: &OwnerCap, arg1: &mut Config<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        arg1.enable = arg2;
        let v0 = ConfigStateUpdated{
            sender    : 0x2::tx_context::sender(arg3),
            config_id : 0x2::object::uid_to_address(&arg1.id),
            enable    : arg2,
        };
        0x2::event::emit<ConfigStateUpdated>(v0);
    }

    public fun update_config_time<T0>(arg0: &OwnerCap, arg1: &mut Config<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            arg1.start_at = arg2;
        };
        if (arg3 > 0) {
            arg1.end_at = arg3;
        };
        let v0 = ConfigTimeUpdated{
            sender    : 0x2::tx_context::sender(arg4),
            config_id : 0x2::object::uid_to_address(&arg1.id),
            start_at  : arg1.start_at,
            end_at    : arg1.end_at,
        };
        0x2::event::emit<ConfigTimeUpdated>(v0);
    }

    public fun withdraw_config_token<T0>(arg0: &OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut Config<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.enable || 0x2::clock::timestamp_ms(arg1) > arg2.end_at, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::invalid_time());
        assert!(0x2::balance::value<T0>(&arg2.token) >= arg3, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::insufficient_balance());
        assert!(arg4 != @0x0, 0x51fbe5dd17a35e09d7cb75603d6e6cd35a18009f4c08a88e21e45d77fbb10ec1::error::invalid_receipent());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.token, arg3), arg5), arg4);
        let v0 = ConfigWithdrawToken{
            sender    : 0x2::tx_context::sender(arg5),
            config_id : 0x2::object::uid_to_address(&arg2.id),
            amount    : arg3,
        };
        0x2::event::emit<ConfigWithdrawToken>(v0);
    }

    // decompiled from Move bytecode v6
}

