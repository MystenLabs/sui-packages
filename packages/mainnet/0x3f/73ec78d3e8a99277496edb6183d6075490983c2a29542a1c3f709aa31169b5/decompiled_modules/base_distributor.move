module 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::base_distributor {
    struct ProjectRegistry has key {
        id: 0x2::object::UID,
        project_to_distributor: 0x2::table::Table<vector<u8>, address>,
    }

    struct Distributor<phantom T0> has key {
        id: 0x2::object::UID,
        claimed_claims: 0x2::table::Table<vector<u8>, bool>,
        authorized_public_key: vector<u8>,
        token_balance: 0x2::balance::Balance<T0>,
        start_time: u64,
        end_time: u64,
        paused: bool,
        creator: address,
        fee_collector_config: address,
        version: vector<u8>,
    }

    struct DistributorCreated has copy, drop {
        distributor_id: address,
        project_id: vector<u8>,
    }

    struct BaseParamsSet has copy, drop {
        distributor_id: address,
        token_type: 0x1::option::Option<0x1::type_name::TypeName>,
        start_time: u64,
        end_time: u64,
        authorized_public_key: vector<u8>,
    }

    struct PauseToggled has copy, drop {
        distributor_id: address,
        paused: bool,
    }

    public entry fun create_and_share_distributor<T0>(arg0: vector<u8>, arg1: &mut ProjectRegistry, arg2: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::FeeCollectorConfig, arg3: &mut 0x2::tx_context::TxContext) {
        share_distributor<T0>(create_distributor<T0>(arg0, arg1, arg2, arg3));
    }

    public fun create_distributor<T0>(arg0: vector<u8>, arg1: &mut ProjectRegistry, arg2: &0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::FeeCollectorConfig, arg3: &mut 0x2::tx_context::TxContext) : Distributor<T0> {
        assert!(!0x2::table::contains<vector<u8>, address>(&arg1.project_to_distributor, arg0), 11);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_address(&v0);
        0x2::table::add<vector<u8>, address>(&mut arg1.project_to_distributor, arg0, v1);
        let v2 = 0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::version::with_module(b"Base Distributor");
        let v3 = Distributor<T0>{
            id                    : v0,
            claimed_claims        : 0x2::table::new<vector<u8>, bool>(arg3),
            authorized_public_key : 0x1::vector::empty<u8>(),
            token_balance         : 0x2::balance::zero<T0>(),
            start_time            : 0,
            end_time              : 0,
            paused                : false,
            creator               : 0x2::tx_context::sender(arg3),
            fee_collector_config  : 0x2::object::id_address<0x3f73ec78d3e8a99277496edb6183d6075490983c2a29542a1c3f709aa31169b5::fee_collector::FeeCollectorConfig>(arg2),
            version               : *0x1::string::as_bytes(&v2),
        };
        let v4 = DistributorCreated{
            distributor_id : v1,
            project_id     : arg0,
        };
        0x2::event::emit<DistributorCreated>(v4);
        v3
    }

    public entry fun deposit<T0>(arg0: &mut Distributor<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun encode_hash_to_be_signed<T0>(arg0: &Distributor<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::object::uid_to_address(&arg0.id)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::hash::sha2_256(v0)
    }

    public fun get_balance<T0>(arg0: &Distributor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_balance)
    }

    public fun get_claim_status<T0>(arg0: &Distributor<T0>, arg1: vector<vector<u8>>) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            0x1::vector::push_back<bool>(&mut v0, is_claimed<T0>(arg0, *0x1::vector::borrow<vector<u8>>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_distributor_by_project_id(arg0: &ProjectRegistry, arg1: vector<u8>) : 0x1::option::Option<address> {
        if (0x2::table::contains<vector<u8>, address>(&arg0.project_to_distributor, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<vector<u8>, address>(&arg0.project_to_distributor, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public entry fun get_distributor_info<T0>(arg0: &Distributor<T0>) : (address, vector<u8>, 0x1::type_name::TypeName, u64, u64, bool, vector<u8>, u64, address) {
        (0x2::object::uid_to_address(&arg0.id), arg0.authorized_public_key, 0x1::type_name::get<T0>(), arg0.start_time, arg0.end_time, arg0.paused, arg0.version, 0x2::balance::value<T0>(&arg0.token_balance), arg0.fee_collector_config)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProjectRegistry{
            id                     : 0x2::object::new(arg0),
            project_to_distributor : 0x2::table::new<vector<u8>, address>(arg0),
        };
        0x2::transfer::share_object<ProjectRegistry>(v0);
    }

    public fun is_claim_active<T0>(arg0: &Distributor<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (!arg0.paused) {
            if (v0 >= arg0.start_time) {
                v0 <= arg0.end_time
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_claimed<T0>(arg0: &Distributor<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.claimed_claims, arg1)
    }

    public(friend) fun mark_claimed<T0>(arg0: &mut Distributor<T0>, arg1: vector<u8>) {
        assert!(!is_claimed<T0>(arg0, arg1), 5);
        0x2::table::add<vector<u8>, bool>(&mut arg0.claimed_claims, arg1, true);
    }

    public fun recover_address(arg0: vector<u8>, arg1: vector<u8>) : address {
        assert!(0x1::vector::length<u8>(&arg0) == 65, 10);
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 1);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 1;
        while (v3 < 65) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v1, v3));
            v3 = v3 + 1;
        };
        0x2::address::from_bytes(0x1::hash::sha2_256(v2))
    }

    public(friend) fun send_tokens<T0>(arg0: &mut Distributor<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg2), arg3), arg1);
    }

    public entry fun set_base_params<T0>(arg0: &mut Distributor<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 12);
        assert!(arg1 < arg2, 9);
        arg0.start_time = arg1;
        arg0.end_time = arg2;
        assert!(0x1::vector::length<u8>(&arg3) == 33, 10);
        arg0.authorized_public_key = arg3;
        let v0 = BaseParamsSet{
            distributor_id        : 0x2::object::uid_to_address(&arg0.id),
            token_type            : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()),
            start_time            : arg1,
            end_time              : arg2,
            authorized_public_key : arg3,
        };
        0x2::event::emit<BaseParamsSet>(v0);
    }

    public fun share_distributor<T0>(arg0: Distributor<T0>) {
        0x2::transfer::share_object<Distributor<T0>>(arg0);
    }

    public entry fun toggle_pause<T0>(arg0: &mut Distributor<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 12);
        arg0.paused = !arg0.paused;
        let v0 = PauseToggled{
            distributor_id : 0x2::object::uid_to_address(&arg0.id),
            paused         : arg0.paused,
        };
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 8;
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> v1 * 8 & 255) as u8));
        };
        v0
    }

    public entry fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 64, 10);
        assert!(0x1::vector::length<u8>(&arg0) == 33, 10);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg2, &arg0, &arg1, 1), 10);
    }

    public fun verify_time_constraints<T0>(arg0: &Distributor<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 >= arg0.start_time && v0 <= arg0.end_time, 1);
        assert!(arg1 <= v0 && arg1 >= arg0.start_time, 2);
    }

    public entry fun withdraw<T0>(arg0: &mut Distributor<T0>, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 12);
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            *0x1::option::borrow<u64>(&arg1)
        } else {
            0x2::balance::value<T0>(&arg0.token_balance)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

