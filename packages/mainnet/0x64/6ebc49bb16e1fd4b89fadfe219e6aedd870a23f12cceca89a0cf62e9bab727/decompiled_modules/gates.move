module 0x646ebc49bb16e1fd4b89fadfe219e6aedd870a23f12cceca89a0cf62e9bab727::gates {
    struct FormGate has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        gate_type: 0x1::type_name::TypeName,
    }

    struct GateCreated has copy, drop {
        gate_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        gate_type: 0x1::type_name::TypeName,
    }

    struct GateUpdated has copy, drop {
        gate_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        new_gate_type: 0x1::type_name::TypeName,
    }

    struct GateRemoved has copy, drop {
        gate_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
    }

    public fun form_id(arg0: &FormGate) : 0x2::object::ID {
        arg0.form_id
    }

    public fun gate_type(arg0: &FormGate) : &0x1::type_name::TypeName {
        &arg0.gate_type
    }

    public fun remove_gate(arg0: FormGate, arg1: &0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::Form, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::owner(arg1), 1);
        assert!(arg0.form_id == 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::id(arg1), 2);
        let FormGate {
            id        : v0,
            form_id   : v1,
            gate_type : _,
        } = arg0;
        let v3 = v0;
        0x2::object::delete(v3);
        let v4 = GateRemoved{
            gate_id : 0x2::object::uid_to_inner(&v3),
            form_id : v1,
        };
        0x2::event::emit<GateRemoved>(v4);
    }

    public fun set_gate<T0>(arg0: &0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::Form, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::owner(arg0), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = FormGate{
            id        : 0x2::object::new(arg1),
            form_id   : 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::id(arg0),
            gate_type : v0,
        };
        let v2 = GateCreated{
            gate_id   : 0x2::object::id<FormGate>(&v1),
            form_id   : 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::id(arg0),
            gate_type : v0,
        };
        0x2::event::emit<GateCreated>(v2);
        0x2::transfer::share_object<FormGate>(v1);
    }

    public fun submit_gated<T0: key>(arg0: &FormGate, arg1: &mut 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::Form, arg2: &T0, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.form_id == 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::id(arg1), 2);
        assert!(0x1::type_name::get<T0>() == arg0.gate_type, 3);
        0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::submission::submit(arg1, arg3, arg4, arg5);
    }

    public fun update_gate<T0>(arg0: &mut FormGate, arg1: &0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::Form, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::owner(arg1), 1);
        assert!(arg0.form_id == 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::id(arg1), 2);
        let v0 = 0x1::type_name::get<T0>();
        arg0.gate_type = v0;
        let v1 = GateUpdated{
            gate_id       : 0x2::object::id<FormGate>(arg0),
            form_id       : 0x8a51080b9102dc8891e5837612403fb0e98b32b8d1c890d0422e73b3dc1aaca1::form::id(arg1),
            new_gate_type : v0,
        };
        0x2::event::emit<GateUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

