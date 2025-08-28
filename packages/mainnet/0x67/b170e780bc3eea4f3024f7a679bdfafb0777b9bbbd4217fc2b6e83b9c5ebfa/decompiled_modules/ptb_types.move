module 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types {
    struct Argument has copy, drop, store {
        arg_type: u8,
        index: u64,
        nested_index: u64,
    }

    struct Input has copy, drop, store {
        input_type: u8,
        data: vector<u8>,
    }

    struct ObjectRef has copy, drop, store {
        object_id: address,
        version: u64,
        digest: vector<u8>,
    }

    struct SharedObjectRef has copy, drop, store {
        object_id: address,
        initial_shared_version: u64,
        mutable: bool,
    }

    struct TypeTag has copy, drop, store {
        type_tag: vector<u8>,
    }

    struct Command has copy, drop, store {
        command_type: u8,
        data: vector<u8>,
    }

    struct MoveCallData has copy, drop, store {
        package: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        type_arguments: vector<TypeTag>,
        arguments: vector<Argument>,
    }

    struct PTBInstruction has copy, drop, store {
        inputs: vector<Input>,
        commands: vector<Command>,
    }

    struct InstructionGroup has copy, drop, store {
        instructions: PTBInstruction,
        required_objects: vector<address>,
        required_types: vector<0x1::string::String>,
    }

    struct InstructionGroups has copy, drop, store {
        groups: vector<InstructionGroup>,
    }

    struct OffchainLookup has copy, drop, store {
        lookup_type: u8,
        parent_object: address,
        lookup_key: vector<u8>,
        placeholder_name: 0x1::string::String,
        required_for_command: u64,
    }

    struct ResolverResult has copy, drop, store {
        status: u8,
        instruction_groups: InstructionGroups,
        offchain_lookups: vector<OffchainLookup>,
        iteration: u8,
    }

    struct ResolverNeedsDataEvent has copy, drop {
        status: u8,
        iteration: u8,
        lookup_type: u8,
        parent_object: address,
        lookup_key: vector<u8>,
        placeholder_name: 0x1::string::String,
    }

    struct ResolverInstructionsEvent has copy, drop {
        status: u8,
        iteration: u8,
        inputs: vector<Input>,
        commands: vector<Command>,
        required_objects: vector<address>,
        required_types: vector<0x1::string::String>,
    }

    struct ResolverOutputEvent has copy, drop {
        status: u8,
        iteration: u8,
        event_type: u8,
        payload: vector<u8>,
    }

    struct KeyValue has copy, drop, store {
        key: 0x1::string::String,
        value: vector<u8>,
    }

    struct DiscoveredData has copy, drop {
        entries: vector<KeyValue>,
    }

    public fun add_discovered_entry(arg0: &mut DiscoveredData, arg1: 0x1::string::String, arg2: vector<u8>) {
        let v0 = KeyValue{
            key   : arg1,
            value : arg2,
        };
        0x1::vector::push_back<KeyValue>(&mut arg0.entries, v0);
    }

    public fun create_discovered_data() : DiscoveredData {
        DiscoveredData{entries: 0x1::vector::empty<KeyValue>()}
    }

    public fun create_dynamic_field_by_type_lookup(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) : OffchainLookup {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg1));
        0x1::vector::push_back<u8>(&mut v0, 255);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg2));
        OffchainLookup{
            lookup_type          : 4,
            parent_object        : arg0,
            lookup_key           : v0,
            placeholder_name     : arg3,
            required_for_command : arg4,
        }
    }

    public fun create_dynamic_field_lookup(arg0: address, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64) : OffchainLookup {
        OffchainLookup{
            lookup_type          : 0,
            parent_object        : arg0,
            lookup_key           : arg1,
            placeholder_name     : arg2,
            required_for_command : arg3,
        }
    }

    public fun create_error_result(arg0: u8) : ResolverResult {
        let v0 = InstructionGroups{groups: 0x1::vector::empty<InstructionGroup>()};
        ResolverResult{
            status             : 2,
            instruction_groups : v0,
            offchain_lookups   : 0x1::vector::empty<OffchainLookup>(),
            iteration          : arg0,
        }
    }

    public fun create_gas_coin_arg() : Argument {
        Argument{
            arg_type     : 0,
            index        : 0,
            nested_index : 0,
        }
    }

    public fun create_generic_event(arg0: &ResolverResult) : ResolverOutputEvent {
        let v0 = if (arg0.status == 0) {
            1
        } else if (arg0.status == 1) {
            0
        } else {
            2
        };
        ResolverOutputEvent{
            status     : arg0.status,
            iteration  : arg0.iteration,
            event_type : v0,
            payload    : 0x2::bcs::to_bytes<ResolverResult>(arg0),
        }
    }

    public fun create_input_arg(arg0: u64) : Argument {
        Argument{
            arg_type     : 1,
            index        : arg0,
            nested_index : 0,
        }
    }

    public fun create_instruction_group(arg0: PTBInstruction, arg1: vector<address>, arg2: vector<0x1::string::String>) : InstructionGroup {
        InstructionGroup{
            instructions     : arg0,
            required_objects : arg1,
            required_types   : arg2,
        }
    }

    public fun create_instruction_groups(arg0: vector<InstructionGroup>) : InstructionGroups {
        InstructionGroups{groups: arg0}
    }

    public fun create_instructions_event(arg0: u8, arg1: &InstructionGroup) : ResolverInstructionsEvent {
        ResolverInstructionsEvent{
            status           : 0,
            iteration        : arg0,
            inputs           : arg1.instructions.inputs,
            commands         : arg1.instructions.commands,
            required_objects : arg1.required_objects,
            required_types   : arg1.required_types,
        }
    }

    public fun create_move_call_command(arg0: MoveCallData) : Command {
        Command{
            command_type : 0,
            data         : 0x2::bcs::to_bytes<MoveCallData>(&arg0),
        }
    }

    public fun create_move_call_data(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<TypeTag>, arg4: vector<Argument>) : MoveCallData {
        MoveCallData{
            package        : arg0,
            module_name    : arg1,
            function_name  : arg2,
            type_arguments : arg3,
            arguments      : arg4,
        }
    }

    public fun create_needs_data_event(arg0: u8, arg1: &OffchainLookup) : ResolverNeedsDataEvent {
        ResolverNeedsDataEvent{
            status           : 1,
            iteration        : arg0,
            lookup_type      : arg1.lookup_type,
            parent_object    : arg1.parent_object,
            lookup_key       : arg1.lookup_key,
            placeholder_name : arg1.placeholder_name,
        }
    }

    public fun create_needs_offchain_result(arg0: vector<OffchainLookup>, arg1: u8) : ResolverResult {
        let v0 = InstructionGroups{groups: 0x1::vector::empty<InstructionGroup>()};
        ResolverResult{
            status             : 1,
            instruction_groups : v0,
            offchain_lookups   : arg0,
            iteration          : arg1,
        }
    }

    public fun create_nested_result_arg(arg0: u64, arg1: u64) : Argument {
        Argument{
            arg_type     : 3,
            index        : arg0,
            nested_index : arg1,
        }
    }

    public fun create_object_input(arg0: ObjectRef) : Input {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0.object_id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.version));
        0x1::vector::append<u8>(&mut v0, arg0.digest);
        Input{
            input_type : 1,
            data       : v0,
        }
    }

    public fun create_object_metadata_lookup(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) : OffchainLookup {
        OffchainLookup{
            lookup_type          : 3,
            parent_object        : arg0,
            lookup_key           : *0x1::string::as_bytes(&arg1),
            placeholder_name     : arg2,
            required_for_command : arg3,
        }
    }

    public fun create_object_ref(arg0: address, arg1: u64, arg2: vector<u8>) : ObjectRef {
        ObjectRef{
            object_id : arg0,
            version   : arg1,
            digest    : arg2,
        }
    }

    public fun create_ptb_instruction(arg0: vector<Input>, arg1: vector<Command>) : PTBInstruction {
        PTBInstruction{
            inputs   : arg0,
            commands : arg1,
        }
    }

    public fun create_pure_input(arg0: vector<u8>) : Input {
        Input{
            input_type : 0,
            data       : arg0,
        }
    }

    public fun create_resolved_result(arg0: InstructionGroups, arg1: u8) : ResolverResult {
        ResolverResult{
            status             : 0,
            instruction_groups : arg0,
            offchain_lookups   : 0x1::vector::empty<OffchainLookup>(),
            iteration          : arg1,
        }
    }

    public fun create_result_arg(arg0: u64) : Argument {
        Argument{
            arg_type     : 2,
            index        : arg0,
            nested_index : 0,
        }
    }

    public fun create_shared_object_input(arg0: SharedObjectRef) : Input {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0.object_id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.initial_shared_version));
        let v1 = if (arg0.mutable) {
            1
        } else {
            0
        };
        0x1::vector::push_back<u8>(&mut v0, v1);
        Input{
            input_type : 2,
            data       : v0,
        }
    }

    public fun create_shared_object_ref(arg0: address, arg1: u64, arg2: bool) : SharedObjectRef {
        SharedObjectRef{
            object_id              : arg0,
            initial_shared_version : arg1,
            mutable                : arg2,
        }
    }

    public fun create_table_lookup(arg0: address, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64) : OffchainLookup {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg1));
        0x1::vector::push_back<u8>(&mut v0, 255);
        0x1::vector::append<u8>(&mut v0, arg2);
        OffchainLookup{
            lookup_type          : 2,
            parent_object        : arg0,
            lookup_key           : v0,
            placeholder_name     : arg3,
            required_for_command : arg4,
        }
    }

    public fun create_type_tag(arg0: vector<u8>) : TypeTag {
        TypeTag{type_tag: arg0}
    }

    public fun discovered_data_from_bytes(arg0: vector<u8>) : DiscoveredData {
        if (0x1::vector::is_empty<u8>(&arg0)) {
            return create_discovered_data()
        };
        let v0 = create_discovered_data();
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(&arg0);
        if (v1 >= v2) {
            return v0
        };
        let v3 = v1 + 1;
        let v4 = 0;
        while (v4 < *0x1::vector::borrow<u8>(&arg0, v1) && v3 < v2) {
            let v5 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64);
            v3 = v3 + 1;
            let v6 = 0x1::vector::empty<u8>();
            let v7 = 0;
            while (v7 < v5 && v3 < v2) {
                0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&arg0, v3));
                v3 = v3 + 1;
                v7 = v7 + 1;
            };
            if (v3 + 1 >= v2) {
                break
            };
            let v8 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64) | (*0x1::vector::borrow<u8>(&arg0, v3 + 1) as u64) << 8;
            v3 = v3 + 2;
            let v9 = 0x1::vector::empty<u8>();
            let v10 = 0;
            while (v10 < v8 && v3 < v2) {
                0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(&arg0, v3));
                v3 = v3 + 1;
                v10 = v10 + 1;
            };
            let v11 = &mut v0;
            add_discovered_entry(v11, 0x1::string::utf8(v6), v9);
            v4 = v4 + 1;
        };
        v0
    }

    public fun discovered_data_length(arg0: &DiscoveredData) : u64 {
        0x1::vector::length<KeyValue>(&arg0.entries)
    }

    public fun emit_resolver_event(arg0: &ResolverResult) {
        if (arg0.status == 0) {
            let v0 = &arg0.instruction_groups.groups;
            if (0x1::vector::length<InstructionGroup>(v0) > 0) {
                0x2::event::emit<ResolverInstructionsEvent>(create_instructions_event(arg0.iteration, 0x1::vector::borrow<InstructionGroup>(v0, 0)));
            };
        } else if (arg0.status == 1) {
            let v1 = &arg0.offchain_lookups;
            if (0x1::vector::length<OffchainLookup>(v1) > 0) {
                0x2::event::emit<ResolverNeedsDataEvent>(create_needs_data_event(arg0.iteration, 0x1::vector::borrow<OffchainLookup>(v1, 0)));
            };
        } else {
            0x2::event::emit<ResolverOutputEvent>(create_generic_event(arg0));
        };
    }

    public fun encode_discovered_data(arg0: &DiscoveredData) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<KeyValue>(&arg0.entries);
        0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<KeyValue>(&arg0.entries, v2);
            let v4 = 0x1::string::as_bytes(&v3.key);
            0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<u8>(v4) as u8));
            0x1::vector::append<u8>(&mut v0, *v4);
            let v5 = 0x1::vector::length<u8>(&v3.value);
            0x1::vector::push_back<u8>(&mut v0, ((v5 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v0, ((v5 >> 8 & 255) as u8));
            0x1::vector::append<u8>(&mut v0, v3.value);
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_discovered_keys(arg0: &DiscoveredData) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<KeyValue>(&arg0.entries)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::vector::borrow<KeyValue>(&arg0.entries, v1).key);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_discovered_value(arg0: &DiscoveredData, arg1: &0x1::string::String) : vector<u8> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<KeyValue>(&arg0.entries)) {
            let v1 = 0x1::vector::borrow<KeyValue>(&arg0.entries, v0);
            if (v1.key == *arg1) {
                return v1.value
            };
            v0 = v0 + 1;
        };
        0x1::vector::empty<u8>()
    }

    public fun get_resolver_groups(arg0: &ResolverResult) : &InstructionGroups {
        &arg0.instruction_groups
    }

    public fun get_resolver_iteration(arg0: &ResolverResult) : u8 {
        arg0.iteration
    }

    public fun get_resolver_lookups(arg0: &ResolverResult) : &vector<OffchainLookup> {
        &arg0.offchain_lookups
    }

    public fun get_resolver_status(arg0: &ResolverResult) : u8 {
        arg0.status
    }

    public fun has_discovered_key(arg0: &DiscoveredData, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<KeyValue>(&arg0.entries)) {
            if (0x1::vector::borrow<KeyValue>(&arg0.entries, v0).key == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

