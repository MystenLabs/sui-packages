module 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents {
    struct ActionSpec has copy, drop, store {
        version: u8,
        action_type: 0x1::type_name::TypeName,
        action_data: vector<u8>,
    }

    struct Intents has store {
        inner: 0x2::bag::Bag,
    }

    struct Intent<T0> has store {
        type_: 0x1::type_name::TypeName,
        key: 0x1::string::String,
        description: 0x1::string::String,
        account: address,
        creator: address,
        creation_time: u64,
        execution_times: vector<u64>,
        expiration_time: u64,
        action_specs: vector<ActionSpec>,
        outcome: T0,
    }

    struct Expired {
        account: address,
        key: 0x1::string::String,
        action_specs: vector<ActionSpec>,
        executed_actions: vector<bool>,
        remaining_executions: u64,
    }

    struct Params has store, key {
        id: 0x2::object::UID,
    }

    struct ParamsFieldsV1 has copy, drop, store {
        key: 0x1::string::String,
        description: 0x1::string::String,
        creation_time: u64,
        execution_times: vector<u64>,
        expiration_time: u64,
    }

    public(friend) fun empty(arg0: &mut 0x2::tx_context::TxContext) : Intents {
        Intents{inner: 0x2::bag::new(arg0)}
    }

    public fun length(arg0: &Intents) : u64 {
        0x2::bag::length(&arg0.inner)
    }

    public fun contains(arg0: &Intents, arg1: 0x1::string::String) : bool {
        0x2::bag::contains<0x1::string::String>(&arg0.inner, arg1)
    }

    public fun account<T0>(arg0: &Intent<T0>) : address {
        arg0.account
    }

    public fun action_count<T0>(arg0: &Intent<T0>) : u64 {
        0x1::vector::length<ActionSpec>(&arg0.action_specs)
    }

    public fun action_spec_data(arg0: &ActionSpec) : &vector<u8> {
        &arg0.action_data
    }

    public fun action_spec_package_addr(arg0: &ActionSpec) : address {
        0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(&arg0.action_type))))
    }

    public fun action_spec_type(arg0: &ActionSpec) : 0x1::type_name::TypeName {
        arg0.action_type
    }

    public fun action_spec_version(arg0: &ActionSpec) : u8 {
        arg0.version
    }

    public fun action_specs<T0>(arg0: &Intent<T0>) : &vector<ActionSpec> {
        &arg0.action_specs
    }

    public fun add_action_spec<T0, T1: drop, T2: drop>(arg0: &mut Intent<T0>, arg1: T1, arg2: vector<u8>, arg3: T2) {
        assert_is_witness<T0, T2>(arg0, arg3);
        assert!(0x1::vector::length<u8>(&arg2) <= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::max_action_data_size(), 12);
        let v0 = ActionSpec{
            version     : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::current_action_version(),
            action_type : 0x1::type_name::with_original_ids<T1>(),
            action_data : arg2,
        };
        0x1::vector::push_back<ActionSpec>(&mut arg0.action_specs, v0);
    }

    public fun add_action_spec_with_typename<T0, T1: drop>(arg0: &mut Intent<T0>, arg1: 0x1::type_name::TypeName, arg2: vector<u8>, arg3: T1) {
        assert_is_witness<T0, T1>(arg0, arg3);
        assert!(0x1::vector::length<u8>(&arg2) <= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::max_action_data_size(), 12);
        let v0 = ActionSpec{
            version     : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::current_action_version(),
            action_type : arg1,
            action_data : arg2,
        };
        0x1::vector::push_back<ActionSpec>(&mut arg0.action_specs, v0);
    }

    public fun add_existing_action_spec<T0, T1: drop>(arg0: &mut Intent<T0>, arg1: ActionSpec, arg2: T1) {
        assert_is_witness<T0, T1>(arg0, arg2);
        assert!(arg1.version == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::current_action_version(), 11);
        assert!(0x1::vector::length<u8>(&arg1.action_data) <= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::max_action_data_size(), 12);
        0x1::vector::push_back<ActionSpec>(&mut arg0.action_specs, arg1);
    }

    public(friend) fun add_intent<T0: store>(arg0: &mut Intents, arg1: Intent<T0>) {
        assert!(!contains(arg0, arg1.key), 6);
        0x2::bag::add<0x1::string::String, Intent<T0>>(&mut arg0.inner, arg1.key, arg1);
    }

    public fun add_typed_action<T0, T1: drop, T2: drop>(arg0: &mut Intent<T0>, arg1: T1, arg2: vector<u8>, arg3: T2) {
        add_action_spec<T0, T1, T2>(arg0, arg1, arg2, arg3);
    }

    public fun assert_expired_is_account(arg0: &Expired, arg1: address) {
        assert!(arg0.account == arg1, 7);
    }

    public fun assert_is_account<T0>(arg0: &Intent<T0>, arg1: address) {
        assert!(arg0.account == arg1, 7);
    }

    public fun assert_is_witness<T0, T1: drop>(arg0: &Intent<T0>, arg1: T1) {
        assert!(arg0.type_ == 0x1::type_name::with_original_ids<T1>(), 8);
    }

    public fun assert_single_execution(arg0: &Params) {
        assert!(0x1::vector::length<u64>(&0x2::dynamic_field::borrow<bool, ParamsFieldsV1>(&arg0.id, true).execution_times) == 1, 9);
    }

    public fun creation_time<T0>(arg0: &Intent<T0>) : u64 {
        arg0.creation_time
    }

    public fun creator<T0>(arg0: &Intent<T0>) : address {
        arg0.creator
    }

    public fun description<T0>(arg0: &Intent<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun destroy_expired(arg0: Expired) {
        let Expired {
            account              : _,
            key                  : _,
            action_specs         : v2,
            executed_actions     : v3,
            remaining_executions : _,
        } = arg0;
        let v5 = v3;
        let v6 = v2;
        assert!(0x1::vector::is_empty<ActionSpec>(&v6), 15);
        assert!(0x1::vector::is_empty<bool>(&v5), 15);
    }

    public(friend) fun destroy_intent<T0: drop + store>(arg0: &mut Intents, arg1: 0x1::string::String, arg2: bool) : Expired {
        let Intent {
            type_           : _,
            key             : v1,
            description     : _,
            account         : v3,
            creator         : _,
            creation_time   : _,
            execution_times : v6,
            expiration_time : _,
            action_specs    : v8,
            outcome         : _,
        } = 0x2::bag::remove<0x1::string::String, Intent<T0>>(&mut arg0.inner, arg1);
        let v10 = v8;
        let v11 = v6;
        let v12 = 0x1::vector::empty<bool>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<ActionSpec>(&v10)) {
            0x1::vector::push_back<bool>(&mut v12, arg2);
            v13 = v13 + 1;
        };
        0x1::vector::reverse<ActionSpec>(&mut v10);
        0x1::vector::reverse<bool>(&mut v12);
        Expired{
            account              : v3,
            key                  : v1,
            action_specs         : v10,
            executed_actions     : v12,
            remaining_executions : 0x1::vector::length<u64>(&v11),
        }
    }

    public fun drain_and_destroy_expired(arg0: Expired) {
        while (0x1::vector::length<ActionSpec>(&arg0.action_specs) > 0) {
            0x1::vector::pop_back<ActionSpec>(&mut arg0.action_specs);
            0x1::vector::pop_back<bool>(&mut arg0.executed_actions);
        };
        destroy_expired(arg0);
    }

    public fun execution_times<T0>(arg0: &Intent<T0>) : vector<u64> {
        arg0.execution_times
    }

    public fun expiration_time<T0>(arg0: &Intent<T0>) : u64 {
        arg0.expiration_time
    }

    public fun expired_account(arg0: &Expired) : address {
        arg0.account
    }

    public fun expired_action_count(arg0: &Expired) : u64 {
        0x1::vector::length<ActionSpec>(&arg0.action_specs)
    }

    public fun expired_action_specs(arg0: &Expired) : &vector<ActionSpec> {
        &arg0.action_specs
    }

    public fun expired_key(arg0: &Expired) : 0x1::string::String {
        arg0.key
    }

    public fun expired_remaining_executions(arg0: &Expired) : u64 {
        arg0.remaining_executions
    }

    public fun get<T0: store>(arg0: &Intents, arg1: 0x1::string::String) : &Intent<T0> {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.inner, arg1), 0);
        0x2::bag::borrow<0x1::string::String, Intent<T0>>(&arg0.inner, arg1)
    }

    public fun get_mut<T0: store>(arg0: &mut Intents, arg1: 0x1::string::String) : &mut Intent<T0> {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.inner, arg1), 0);
        0x2::bag::borrow_mut<0x1::string::String, Intent<T0>>(&mut arg0.inner, arg1)
    }

    public fun key<T0>(arg0: &Intent<T0>) : 0x1::string::String {
        arg0.key
    }

    public fun new_action_spec_with_typename(arg0: 0x1::type_name::TypeName, arg1: vector<u8>, arg2: u8) : ActionSpec {
        assert!(arg2 == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::current_action_version(), 11);
        assert!(0x1::vector::length<u8>(&arg1) <= 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::constants::max_action_data_size(), 12);
        ActionSpec{
            version     : arg2,
            action_type : arg0,
            action_data : arg1,
        }
    }

    public(friend) fun new_intent<T0, T1: drop>(arg0: Params, arg1: T0, arg2: address, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) : Intent<T0> {
        let Params { id: v0 } = arg0;
        let ParamsFieldsV1 {
            key             : v1,
            description     : v2,
            creation_time   : v3,
            execution_times : v4,
            expiration_time : v5,
        } = 0x2::dynamic_field::remove<bool, ParamsFieldsV1>(&mut v0, true);
        0x2::object::delete(v0);
        Intent<T0>{
            type_           : 0x1::type_name::with_original_ids<T1>(),
            key             : v1,
            description     : v2,
            account         : arg2,
            creator         : 0x2::tx_context::sender(arg4),
            creation_time   : v3,
            execution_times : v4,
            expiration_time : v5,
            action_specs    : 0x1::vector::empty<ActionSpec>(),
            outcome         : arg1,
        }
    }

    public fun new_params(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u64>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Params {
        assert!(!0x1::vector::is_empty<u64>(&arg2), 3);
        assert!(arg3 > 0, 14);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2) - 1) {
            assert!(*0x1::vector::borrow<u64>(&arg2, v0) <= *0x1::vector::borrow<u64>(&arg2, v0 + 1), 4);
            v0 = v0 + 1;
        };
        assert!(*0x1::vector::borrow<u64>(&arg2, 0x1::vector::length<u64>(&arg2) - 1) < arg3, 13);
        let v1 = ParamsFieldsV1{
            key             : arg0,
            description     : arg1,
            creation_time   : 0x2::clock::timestamp_ms(arg4),
            execution_times : arg2,
            expiration_time : arg3,
        };
        let v2 = 0x2::object::new(arg5);
        0x2::dynamic_field::add<bool, ParamsFieldsV1>(&mut v2, true, v1);
        Params{id: v2}
    }

    public fun new_params_with_rand_key(arg0: 0x1::string::String, arg1: vector<u64>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (Params, 0x1::string::String) {
        let v0 = 0x2::address::to_string(0x2::tx_context::fresh_object_address(arg4));
        (new_params(v0, arg0, arg1, arg2, arg3, arg4), v0)
    }

    public fun outcome<T0>(arg0: &Intent<T0>) : &T0 {
        &arg0.outcome
    }

    public fun outcome_mut<T0>(arg0: &mut Intent<T0>) : &mut T0 {
        &mut arg0.outcome
    }

    public fun params_creation_time(arg0: &Params) : u64 {
        0x2::dynamic_field::borrow<bool, ParamsFieldsV1>(&arg0.id, true).creation_time
    }

    public fun params_description(arg0: &Params) : 0x1::string::String {
        0x2::dynamic_field::borrow<bool, ParamsFieldsV1>(&arg0.id, true).description
    }

    public fun params_execution_times(arg0: &Params) : vector<u64> {
        0x2::dynamic_field::borrow<bool, ParamsFieldsV1>(&arg0.id, true).execution_times
    }

    public fun params_expiration_time(arg0: &Params) : u64 {
        0x2::dynamic_field::borrow<bool, ParamsFieldsV1>(&arg0.id, true).expiration_time
    }

    public fun params_key(arg0: &Params) : 0x1::string::String {
        0x2::dynamic_field::borrow<bool, ParamsFieldsV1>(&arg0.id, true).key
    }

    public(friend) fun pop_front_execution_time<T0>(arg0: &mut Intent<T0>) : u64 {
        0x1::vector::remove<u64>(&mut arg0.execution_times, 0)
    }

    public fun remove_action_spec(arg0: &mut Expired) : (ActionSpec, bool) {
        (0x1::vector::pop_back<ActionSpec>(&mut arg0.action_specs), 0x1::vector::pop_back<bool>(&mut arg0.executed_actions))
    }

    public(friend) fun remove_intent<T0: store>(arg0: &mut Intents, arg1: 0x1::string::String) : Intent<T0> {
        assert!(contains(arg0, arg1), 0);
        0x2::bag::remove<0x1::string::String, Intent<T0>>(&mut arg0.inner, arg1)
    }

    public fun type_<T0>(arg0: &Intent<T0>) : 0x1::type_name::TypeName {
        arg0.type_
    }

    // decompiled from Move bytecode v6
}

