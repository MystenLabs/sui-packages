module 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::queue {
    struct ExistingOracle has copy, drop, store {
        oracle_id: 0x2::object::ID,
        oracle_key: vector<u8>,
    }

    struct Queue has key {
        id: 0x2::object::UID,
        queue_key: vector<u8>,
        authority: address,
        name: 0x1::string::String,
        fee: u64,
        fee_recipient: address,
        min_attestations: u64,
        oracle_validity_length_ms: u64,
        last_queue_override_ms: u64,
        guardian_queue_id: 0x2::object::ID,
        existing_oracles: 0x2::table::Table<vector<u8>, ExistingOracle>,
        fee_types: vector<0x1::type_name::TypeName>,
        version: u8,
    }

    public(friend) fun new(arg0: vector<u8>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg9);
        if (arg8) {
            let v1 = Queue{
                id                        : v0,
                queue_key                 : arg0,
                authority                 : arg1,
                name                      : arg2,
                fee                       : arg3,
                fee_recipient             : arg4,
                min_attestations          : arg5,
                oracle_validity_length_ms : arg6,
                last_queue_override_ms    : 0,
                guardian_queue_id         : *0x2::object::uid_as_inner(&v0),
                existing_oracles          : 0x2::table::new<vector<u8>, ExistingOracle>(arg9),
                fee_types                 : 0x1::vector::singleton<0x1::type_name::TypeName>(0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>()),
                version                   : 1,
            };
            0x2::transfer::share_object<Queue>(v1);
        } else {
            let v2 = Queue{
                id                        : v0,
                queue_key                 : arg0,
                authority                 : arg1,
                name                      : arg2,
                fee                       : arg3,
                fee_recipient             : arg4,
                min_attestations          : arg5,
                oracle_validity_length_ms : arg6,
                last_queue_override_ms    : 0,
                guardian_queue_id         : arg7,
                existing_oracles          : 0x2::table::new<vector<u8>, ExistingOracle>(arg9),
                fee_types                 : 0x1::vector::singleton<0x1::type_name::TypeName>(0x1::type_name::get<0x2::coin::Coin<0x2::sui::SUI>>()),
                version                   : 1,
            };
            0x2::transfer::share_object<Queue>(v2);
        };
        *0x2::object::uid_as_inner(&v0)
    }

    public(friend) fun add_existing_oracle(arg0: &mut Queue, arg1: vector<u8>, arg2: 0x2::object::ID) {
        let v0 = ExistingOracle{
            oracle_id  : arg2,
            oracle_key : arg1,
        };
        0x2::table::add<vector<u8>, ExistingOracle>(&mut arg0.existing_oracles, arg1, v0);
    }

    public(friend) fun add_fee_type<T0>(arg0: &mut Queue) {
        let v0 = 0x1::type_name::get<0x2::coin::Coin<T0>>();
        if (0x1::vector::contains<0x1::type_name::TypeName>(&arg0.fee_types, &v0)) {
            return
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.fee_types, 0x1::type_name::get<0x2::coin::Coin<T0>>());
    }

    public fun authority(arg0: &Queue) : address {
        arg0.authority
    }

    public fun existing_oracles(arg0: &Queue) : &0x2::table::Table<vector<u8>, ExistingOracle> {
        &arg0.existing_oracles
    }

    public fun existing_oracles_contains(arg0: &Queue, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, ExistingOracle>(&arg0.existing_oracles, arg1)
    }

    public fun fee(arg0: &Queue) : u64 {
        arg0.fee
    }

    public fun fee_recipient(arg0: &Queue) : address {
        arg0.fee_recipient
    }

    public fun fee_types(arg0: &Queue) : vector<0x1::type_name::TypeName> {
        arg0.fee_types
    }

    public fun guardian_queue_id(arg0: &Queue) : 0x2::object::ID {
        arg0.guardian_queue_id
    }

    public fun has_authority(arg0: &Queue, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.authority == 0x2::tx_context::sender(arg1)
    }

    public fun has_fee_type<T0>(arg0: &Queue) : bool {
        let v0 = 0x1::type_name::get<0x2::coin::Coin<T0>>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.fee_types, &v0)
    }

    public fun id(arg0: &Queue) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun last_queue_override_ms(arg0: &Queue) : u64 {
        arg0.last_queue_override_ms
    }

    public fun min_attestations(arg0: &Queue) : u64 {
        arg0.min_attestations
    }

    public fun name(arg0: &Queue) : 0x1::string::String {
        arg0.name
    }

    public fun oracle_id(arg0: &ExistingOracle) : 0x2::object::ID {
        arg0.oracle_id
    }

    public fun oracle_key(arg0: &ExistingOracle) : vector<u8> {
        arg0.oracle_key
    }

    public fun oracle_validity_length_ms(arg0: &Queue) : u64 {
        arg0.oracle_validity_length_ms
    }

    public fun queue_key(arg0: &Queue) : vector<u8> {
        arg0.queue_key
    }

    public(friend) fun remove_fee_type<T0>(arg0: &mut Queue) {
        let v0 = 0x1::type_name::get<0x2::coin::Coin<T0>>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.fee_types, &v0);
        if (v1 == false) {
            return
        };
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.fee_types, v2);
    }

    public(friend) fun set_authority(arg0: &mut Queue, arg1: address) {
        arg0.authority = arg1;
    }

    public(friend) fun set_configs(arg0: &mut Queue, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        arg0.name = arg1;
        arg0.fee = arg2;
        arg0.fee_recipient = arg3;
        arg0.min_attestations = arg4;
        arg0.oracle_validity_length_ms = arg5;
    }

    public(friend) fun set_guardian_queue_id(arg0: &mut Queue, arg1: 0x2::object::ID) {
        arg0.guardian_queue_id = arg1;
    }

    public(friend) fun set_last_queue_override_ms(arg0: &mut Queue, arg1: u64) {
        arg0.last_queue_override_ms = arg1;
    }

    public(friend) fun set_queue_key(arg0: &mut Queue, arg1: vector<u8>) {
        arg0.queue_key = arg1;
    }

    public fun version(arg0: &Queue) : u8 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

