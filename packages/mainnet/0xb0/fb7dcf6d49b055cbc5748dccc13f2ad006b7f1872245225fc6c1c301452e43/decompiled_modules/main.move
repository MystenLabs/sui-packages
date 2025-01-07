module 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::main {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        start_at: u64,
        end_at: u64,
        merkle_root: 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::bytes32::Bytes32,
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

    struct ConfigMerkleRootUpdated has copy, drop {
        sender: address,
        config_id: address,
        merkle_root: address,
    }

    struct UserClaimed has copy, drop {
        user: address,
        config_id: address,
        amount: u64,
    }

    public fun claim_token(arg0: &0x2::clock::Clock, arg1: &mut Config, arg2: u64, arg3: vector<address>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg0) >= arg1.start_at && 0x2::clock::timestamp_ms(arg0) <= arg1.end_at, 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::error::invalid_time());
        assert!(!0x2::table::contains<address, u64>(&arg1.claimed, 0x2::tx_context::sender(arg4)), 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::error::already_claimed());
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg4)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg2 as u256))));
        assert!(0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::merkle_tree::verify(0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::bytes32::from_vector_addresses(arg3), arg1.merkle_root, 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::bytes32::from_vector(0x2::hash::keccak256(&v0))), 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::error::invalid_proof());
        0x2::table::add<address, u64>(&mut arg1.claimed, 0x2::tx_context::sender(arg4), arg2);
        let v1 = UserClaimed{
            user      : 0x2::tx_context::sender(arg4),
            config_id : 0x2::object::uid_to_address(&arg1.id),
            amount    : arg2,
        };
        0x2::event::emit<UserClaimed>(v1);
    }

    public fun create_config(arg0: &OwnerCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Config{
            id          : v0,
            start_at    : arg1,
            end_at      : arg2,
            merkle_root : 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::bytes32::from_vector(0x2::address::to_bytes(arg3)),
            claimed     : 0x2::table::new<address, u64>(arg4),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = ConfigCreated{
            creator   : 0x2::tx_context::sender(arg4),
            config_id : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<ConfigCreated>(v2);
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

    public fun update_config_merkle(arg0: &OwnerCap, arg1: &mut Config, arg2: address, arg3: &0x2::tx_context::TxContext) {
        arg1.merkle_root = 0xb0fb7dcf6d49b055cbc5748dccc13f2ad006b7f1872245225fc6c1c301452e43::bytes32::from_vector(0x2::address::to_bytes(arg2));
        let v0 = ConfigMerkleRootUpdated{
            sender      : 0x2::tx_context::sender(arg3),
            config_id   : 0x2::object::uid_to_address(&arg1.id),
            merkle_root : arg2,
        };
        0x2::event::emit<ConfigMerkleRootUpdated>(v0);
    }

    public fun update_config_time(arg0: &OwnerCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
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

    // decompiled from Move bytecode v6
}

