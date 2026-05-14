module 0x10485b4712a4ea7552562a368f2ab2371ac82f51235bf9078584ed867d431aa3::form_manager {
    struct FormCap has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct Response has drop, store {
        sender: address,
        blob_id: 0x1::string::String,
        created_at: u64,
        priority: u8,
        status: u8,
        admin_note: 0x1::string::String,
    }

    struct WalechoForm has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        submitText: 0x1::string::String,
        blob_id: 0x1::string::String,
        admins: vector<address>,
        whitelist: vector<address>,
        is_sealed: bool,
        active: bool,
        counter: u64,
        responses: 0x2::table::Table<u64, Response>,
        created_at: u64,
    }

    struct FormAnchored has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        blob_id: 0x1::string::String,
    }

    struct ResponseSubmitted has copy, drop {
        form_id: 0x2::object::ID,
        response_id: u64,
        sender: address,
        blob_id: 0x1::string::String,
    }

    public fun add_admin(arg0: &mut WalechoForm, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        if (!0x1::vector::contains<address>(&arg0.admins, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v0 = FormCap{
                id      : 0x2::object::new(arg2),
                form_id : 0x2::object::id<WalechoForm>(arg0),
            };
            0x2::transfer::transfer<FormCap>(v0, arg1);
        };
    }

    public fun bulk_add_to_whitelist(arg0: &mut WalechoForm, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.whitelist, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.whitelist, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun bulk_remove_from_whitelist(arg0: &mut WalechoForm, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            let (v2, v3) = 0x1::vector::index_of<address>(&arg0.whitelist, &v1);
            if (v2) {
                0x1::vector::remove<address>(&mut arg0.whitelist, v3);
            };
            v0 = v0 + 1;
        };
    }

    public fun can_access(arg0: &WalechoForm, arg1: address) : bool {
        if (!arg0.active) {
            return false
        };
        if (!arg0.is_sealed) {
            return true
        };
        arg1 == arg0.owner || 0x1::vector::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun deploy_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = WalechoForm{
            id          : v1,
            owner       : v0,
            title       : arg0,
            description : arg1,
            submitText  : arg2,
            blob_id     : arg3,
            admins      : vector[],
            whitelist   : arg5,
            is_sealed   : arg4,
            active      : true,
            counter     : 0,
            responses   : 0x2::table::new<u64, Response>(arg7),
            created_at  : 0x2::clock::timestamp_ms(arg6),
        };
        let v4 = FormAnchored{
            form_id : v2,
            owner   : v0,
            blob_id : arg3,
        };
        0x2::event::emit<FormAnchored>(v4);
        0x2::transfer::share_object<WalechoForm>(v3);
        let v5 = FormCap{
            id      : 0x2::object::new(arg7),
            form_id : v2,
        };
        0x2::transfer::transfer<FormCap>(v5, v0);
    }

    public fun remove_admin(arg0: &mut WalechoForm, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &WalechoForm, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == arg1.owner) {
            true
        } else if (0x1::vector::contains<address>(&arg1.admins, &v0)) {
            true
        } else {
            0x1::vector::contains<address>(&arg1.whitelist, &v0)
        };
        assert!(v1, 1);
        assert!(*0x1::string::as_bytes(&arg1.blob_id) == arg2, 2);
    }

    entry fun seal_approve_response(arg0: vector<u8>, arg1: &WalechoForm, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.owner || 0x1::vector::contains<address>(&arg1.admins, &v0), 1);
        assert!(*0x1::string::as_bytes(&0x2::table::borrow<u64, Response>(&arg1.responses, arg2).blob_id) == arg3, 2);
    }

    public fun submit_response(arg0: &mut WalechoForm, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.active, 3);
        if (arg0.is_sealed) {
            assert!(v0 == arg0.owner || 0x1::vector::contains<address>(&arg0.whitelist, &v0), 1);
        };
        let v1 = arg0.counter;
        let v2 = Response{
            sender     : v0,
            blob_id    : arg1,
            created_at : 0x2::clock::timestamp_ms(arg2),
            priority   : 0,
            status     : 0,
            admin_note : 0x1::string::utf8(b""),
        };
        0x2::table::add<u64, Response>(&mut arg0.responses, v1, v2);
        arg0.counter = v1 + 1;
    }

    public fun toggle_active(arg0: &mut WalechoForm, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = !arg0.active;
    }

    public fun update_blob(arg0: &mut WalechoForm, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || 0x1::vector::contains<address>(&arg0.admins, &v0), 1);
        arg0.blob_id = arg1;
    }

    public fun update_response_status(arg0: &mut WalechoForm, arg1: u64, arg2: u8, arg3: u8, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner || 0x1::vector::contains<address>(&arg0.admins, &v0), 1);
        let v1 = 0x2::table::borrow_mut<u64, Response>(&mut arg0.responses, arg1);
        v1.priority = arg2;
        v1.status = arg3;
        v1.admin_note = arg4;
    }

    // decompiled from Move bytecode v7
}

