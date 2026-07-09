module 0x5f0b1f84bd349e706d0e27ca93425430272b7da652be048d31f8d7df1a229405::warp_mesh {
    struct MeshHub has key {
        id: 0x2::object::UID,
        admin: address,
        quorum_threshold: u64,
        registered_agents: 0x2::vec_set::VecSet<address>,
        tunnel_count: u64,
        epoch: u64,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        hub_id: 0x2::object::ID,
        agent: address,
    }

    struct Tunnel has key {
        id: 0x2::object::UID,
        owner: address,
        hub_id: 0x2::object::ID,
        balances: 0x2::bag::Bag,
        open_count: u64,
        settled_epoch: u64,
    }

    struct AttestationBallot has key {
        id: 0x2::object::UID,
        hub_id: 0x2::object::ID,
        epoch: u64,
        merkle_root: vector<u8>,
        leg_hashes: vector<vector<u8>>,
        attesters: 0x2::vec_set::VecSet<address>,
    }

    struct AttestationReceipt {
        hub_id: 0x2::object::ID,
        epoch: u64,
        merkle_root: vector<u8>,
        leg_hashes: vector<vector<u8>>,
        cursor: u64,
    }

    struct TunnelDeposited has copy, drop {
        tunnel_id: 0x2::object::ID,
        amount: u64,
    }

    struct AttestationRecorded has copy, drop {
        hub_id: 0x2::object::ID,
        epoch: u64,
        agent: address,
        quorum_size: u64,
    }

    struct CheckpointSettled has copy, drop {
        hub_id: 0x2::object::ID,
        epoch: u64,
        tunnel_id: 0x2::object::ID,
        credit: u64,
        debit: u64,
    }

    public entry fun advance_epoch(arg0: &mut MeshHub, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        arg0.epoch = arg0.epoch + 1;
    }

    fun apply_net_delta<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &MeshHub, arg3: &mut Tunnel, arg4: &mut Tunnel, arg5: u64) {
        assert!(arg0 == 0x2::object::id<MeshHub>(arg2), 6);
        assert!(arg3.hub_id == arg0, 6);
        assert!(arg4.hub_id == arg0, 6);
        assert!(arg1 == arg2.epoch, 7);
        assert!(arg5 > 0, 9);
        assert!(0x2::object::id<Tunnel>(arg3) != 0x2::object::id<Tunnel>(arg4), 10);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg3.balances, v0), 8);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg3.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg5, 8);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg4.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg4.balances, v0), 0x2::balance::split<T0>(v1, arg5));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg4.balances, v0, 0x2::balance::split<T0>(v1, arg5));
        };
        arg3.settled_epoch = arg1;
        arg4.settled_epoch = arg1;
        let v2 = CheckpointSettled{
            hub_id    : arg0,
            epoch     : arg1,
            tunnel_id : 0x2::object::id<Tunnel>(arg3),
            credit    : 0,
            debit     : arg5,
        };
        0x2::event::emit<CheckpointSettled>(v2);
        let v3 = CheckpointSettled{
            hub_id    : arg0,
            epoch     : arg1,
            tunnel_id : 0x2::object::id<Tunnel>(arg4),
            credit    : arg5,
            debit     : 0,
        };
        0x2::event::emit<CheckpointSettled>(v3);
    }

    public entry fun attest(arg0: &mut AttestationBallot, arg1: &AgentCap, arg2: &MeshHub) {
        assert!(arg0.hub_id == 0x2::object::id<MeshHub>(arg2), 6);
        assert!(arg1.hub_id == 0x2::object::id<MeshHub>(arg2), 3);
        assert!(0x2::vec_set::contains<address>(&arg2.registered_agents, &arg1.agent), 3);
        assert!(!0x2::vec_set::contains<address>(&arg0.attesters, &arg1.agent), 4);
        0x2::vec_set::insert<address>(&mut arg0.attesters, arg1.agent);
        let v0 = AttestationRecorded{
            hub_id      : arg0.hub_id,
            epoch       : arg0.epoch,
            agent       : arg1.agent,
            quorum_size : 0x2::vec_set::size<address>(&arg0.attesters),
        };
        0x2::event::emit<AttestationRecorded>(v0);
    }

    public fun close_checkpoint<T0>(arg0: AttestationReceipt, arg1: &mut MeshHub, arg2: &mut Tunnel, arg3: &mut Tunnel, arg4: u64) {
        let AttestationReceipt {
            hub_id      : v0,
            epoch       : v1,
            merkle_root : _,
            leg_hashes  : v3,
            cursor      : v4,
        } = arg0;
        let v5 = v3;
        assert!(v4 + 1 == 0x1::vector::length<vector<u8>>(&v5), 5);
        assert!(leg_hash<T0>(0x2::object::id<Tunnel>(arg2), 0x2::object::id<Tunnel>(arg3), arg4) == *0x1::vector::borrow<vector<u8>>(&v5, v4), 7);
        apply_net_delta<T0>(v0, v1, arg1, arg2, arg3, arg4);
        arg1.epoch = arg1.epoch + 1;
    }

    public fun create_mesh_hub(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : MeshHub {
        assert!(arg0 > 0, 5);
        MeshHub{
            id                : 0x2::object::new(arg1),
            admin             : 0x2::tx_context::sender(arg1),
            quorum_threshold  : arg0,
            registered_agents : 0x2::vec_set::empty<address>(),
            tunnel_count      : 0,
            epoch             : 0,
        }
    }

    public entry fun deposit<T0>(arg0: &mut Tunnel, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = TunnelDeposited{
            tunnel_id : 0x2::object::id<Tunnel>(arg0),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<TunnelDeposited>(v1);
    }

    public fun finalize_ballot(arg0: AttestationBallot, arg1: &MeshHub) : AttestationReceipt {
        let AttestationBallot {
            id          : v0,
            hub_id      : v1,
            epoch       : v2,
            merkle_root : v3,
            leg_hashes  : v4,
            attesters   : v5,
        } = arg0;
        let v6 = v5;
        let v7 = v4;
        assert!(v1 == 0x2::object::id<MeshHub>(arg1), 6);
        assert!(0x2::vec_set::size<address>(&v6) >= arg1.quorum_threshold, 5);
        assert!(0x1::vector::length<vector<u8>>(&v7) > 0, 7);
        0x2::object::delete(v0);
        AttestationReceipt{
            hub_id      : v1,
            epoch       : v2,
            merkle_root : v3,
            leg_hashes  : v7,
            cursor      : 0,
        }
    }

    public fun leg_hash<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        let v1 = 0x1::type_name::get<T0>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0x2::hash::keccak256(&v0)
    }

    public entry fun open_ballot(arg0: &MeshHub, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg2) > 0, 7);
        let v0 = AttestationBallot{
            id          : 0x2::object::new(arg3),
            hub_id      : 0x2::object::id<MeshHub>(arg0),
            epoch       : arg0.epoch,
            merkle_root : arg1,
            leg_hashes  : arg2,
            attesters   : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AttestationBallot>(v0);
    }

    public entry fun open_tunnel(arg0: &mut MeshHub, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.tunnel_count = arg0.tunnel_count + 1;
        let v0 = Tunnel{
            id            : 0x2::object::new(arg1),
            owner         : 0x2::tx_context::sender(arg1),
            hub_id        : 0x2::object::id<MeshHub>(arg0),
            balances      : 0x2::bag::new(arg1),
            open_count    : 0,
            settled_epoch : arg0.epoch,
        };
        0x2::transfer::transfer<Tunnel>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_agent(arg0: &mut MeshHub, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(!0x2::vec_set::contains<address>(&arg0.registered_agents, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.registered_agents, arg1);
        let v0 = AgentCap{
            id     : 0x2::object::new(arg2),
            hub_id : 0x2::object::id<MeshHub>(arg0),
            agent  : arg1,
        };
        0x2::transfer::transfer<AgentCap>(v0, arg1);
    }

    public fun settle_checkpoint<T0>(arg0: AttestationReceipt, arg1: &MeshHub, arg2: &mut Tunnel, arg3: &mut Tunnel, arg4: u64) : AttestationReceipt {
        let AttestationReceipt {
            hub_id      : v0,
            epoch       : v1,
            merkle_root : v2,
            leg_hashes  : v3,
            cursor      : v4,
        } = arg0;
        let v5 = v3;
        assert!(v4 + 1 < 0x1::vector::length<vector<u8>>(&v5), 5);
        assert!(leg_hash<T0>(0x2::object::id<Tunnel>(arg2), 0x2::object::id<Tunnel>(arg3), arg4) == *0x1::vector::borrow<vector<u8>>(&v5, v4), 7);
        apply_net_delta<T0>(v0, v1, arg1, arg2, arg3, arg4);
        AttestationReceipt{
            hub_id      : v0,
            epoch       : v1,
            merkle_root : v2,
            leg_hashes  : v5,
            cursor      : v4 + 1,
        }
    }

    public entry fun share_mesh_hub(arg0: MeshHub) {
        0x2::transfer::share_object<MeshHub>(arg0);
    }

    public fun teleport_out<T0>(arg0: &mut Tunnel, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 8);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

