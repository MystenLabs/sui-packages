module 0x387eef6222895f1cdd3ab2a440540fa2cee63c77a299f4ca15a74fe0ba11a0ac::gates {
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

    public fun remove_gate(arg0: FormGate, arg1: &0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::Form, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::owner(arg1), 1);
        assert!(arg0.form_id == 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::id(arg1), 2);
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

    public fun set_gate<T0>(arg0: &0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::Form, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::owner(arg0), 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = FormGate{
            id        : 0x2::object::new(arg1),
            form_id   : 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::id(arg0),
            gate_type : v0,
        };
        let v2 = GateCreated{
            gate_id   : 0x2::object::id<FormGate>(&v1),
            form_id   : 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::id(arg0),
            gate_type : v0,
        };
        0x2::event::emit<GateCreated>(v2);
        0x2::transfer::share_object<FormGate>(v1);
    }

    public fun submit_gated<T0: key>(arg0: &FormGate, arg1: &mut 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::Form, arg2: &T0, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.form_id == 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::id(arg1), 2);
        assert!(0x1::type_name::get<T0>() == arg0.gate_type, 3);
        0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::submission::submit(arg1, arg3, arg4, arg5);
    }

    public fun update_gate<T0>(arg0: &mut FormGate, arg1: &0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::Form, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::owner(arg1), 1);
        assert!(arg0.form_id == 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::id(arg1), 2);
        let v0 = 0x1::type_name::get<T0>();
        arg0.gate_type = v0;
        let v1 = GateUpdated{
            gate_id       : 0x2::object::id<FormGate>(arg0),
            form_id       : 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::id(arg1),
            new_gate_type : v0,
        };
        0x2::event::emit<GateUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

