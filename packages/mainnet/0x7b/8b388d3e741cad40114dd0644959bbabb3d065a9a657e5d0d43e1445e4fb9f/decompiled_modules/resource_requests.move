module 0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::resource_requests {
    struct ResourceRequested has copy, drop {
        request_id: 0x2::object::ID,
        action_type: 0x1::type_name::TypeName,
    }

    struct ResourceFulfilled has copy, drop {
        request_id: 0x2::object::ID,
        action_type: 0x1::type_name::TypeName,
    }

    struct ResourceRequest<phantom T0> {
        id: 0x2::object::UID,
        context: 0x2::object::UID,
        context_entries: u64,
    }

    struct ResourceReceipt<phantom T0> has drop {
        request_id: 0x2::object::ID,
    }

    public(friend) fun add_context<T0, T1: store>(arg0: &mut ResourceRequest<T0>, arg1: 0x1::string::String, arg2: T1) {
        0x2::dynamic_field::add<0x1::string::String, T1>(&mut arg0.context, arg1, arg2);
        arg0.context_entries = arg0.context_entries + 1;
    }

    public fun create_receipt<T0: drop>(arg0: T0) : ResourceReceipt<T0> {
        ResourceReceipt<T0>{request_id: 0x2::object::id_from_address(@0x0)}
    }

    public fun extract_action<T0: store>(arg0: ResourceRequest<T0>) : T0 {
        let ResourceRequest {
            id              : v0,
            context         : v1,
            context_entries : v2,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        assert!(v2 == 1, 1);
        let v5 = ResourceFulfilled{
            request_id  : 0x2::object::uid_to_inner(&v4),
            action_type : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<ResourceFulfilled>(v5);
        0x2::object::delete(v4);
        0x2::object::delete(v3);
        0x2::dynamic_field::remove<0x1::string::String, T0>(&mut v3, 0x1::string::utf8(b"action"))
    }

    public fun fulfill<T0>(arg0: ResourceRequest<T0>) : ResourceReceipt<T0> {
        let ResourceRequest {
            id              : v0,
            context         : v1,
            context_entries : v2,
        } = arg0;
        let v3 = v0;
        let v4 = 0x2::object::uid_to_inner(&v3);
        assert!(v2 == 0, 0);
        let v5 = ResourceFulfilled{
            request_id  : v4,
            action_type : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<ResourceFulfilled>(v5);
        0x2::object::delete(v3);
        0x2::object::delete(v1);
        ResourceReceipt<T0>{request_id: v4}
    }

    public(friend) fun get_context<T0, T1: copy + store>(arg0: &ResourceRequest<T0>, arg1: 0x1::string::String) : T1 {
        *0x2::dynamic_field::borrow<0x1::string::String, T1>(&arg0.context, arg1)
    }

    public(friend) fun has_context<T0>(arg0: &ResourceRequest<T0>, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.context, arg1)
    }

    public fun new_request<T0>(arg0: &mut 0x2::tx_context::TxContext) : ResourceRequest<T0> {
        let v0 = 0x2::object::new(arg0);
        let v1 = ResourceRequested{
            request_id  : 0x2::object::uid_to_inner(&v0),
            action_type : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<ResourceRequested>(v1);
        ResourceRequest<T0>{
            id              : v0,
            context         : 0x2::object::new(arg0),
            context_entries : 0,
        }
    }

    public fun new_resource_request<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : ResourceRequest<T0> {
        let v0 = new_request<T0>(arg1);
        let v1 = &mut v0;
        add_context<T0, T0>(v1, 0x1::string::utf8(b"action"), arg0);
        v0
    }

    public fun receipt_id<T0>(arg0: &ResourceReceipt<T0>) : 0x2::object::ID {
        arg0.request_id
    }

    public fun request_id<T0>(arg0: &ResourceRequest<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun take_context<T0, T1: store>(arg0: &mut ResourceRequest<T0>, arg1: 0x1::string::String) : T1 {
        assert!(arg0.context_entries > 0, 1);
        arg0.context_entries = arg0.context_entries - 1;
        0x2::dynamic_field::remove<0x1::string::String, T1>(&mut arg0.context, arg1)
    }

    // decompiled from Move bytecode v6
}

