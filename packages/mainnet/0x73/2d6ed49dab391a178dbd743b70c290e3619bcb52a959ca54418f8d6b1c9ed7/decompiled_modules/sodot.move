module 0x732d6ed49dab391a178dbd743b70c290e3619bcb52a959ca54418f8d6b1c9ed7::sodot {
    struct SodotModule has store, key {
        id: 0x2::object::UID,
        module_cap: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::ApproveModuleCap,
    }

    struct InitEvent has copy, drop {
        approve_cap_id: 0x2::object::ID,
        workspace_id: 0x2::object::ID,
        user_id: u16,
        identifier: 0x1::string::String,
        sender: address,
    }

    struct ApproveMessageEvent has copy, drop {
        approve_cap_id: 0x2::object::ID,
        messages: vector<vector<u8>>,
    }

    public fun approve_message(arg0: &SodotModule, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::ApproveRequest) {
        let (v0, _, _, _, _, v5) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::consume_approve_request(&arg0.module_cap, arg1);
        let v6 = ApproveMessageEvent{
            approve_cap_id : v0,
            messages       : v5,
        };
        0x2::event::emit<ApproveMessageEvent>(v6);
    }

    public fun create_sodot_module(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = SodotModule{
            id         : v0,
            module_cap : 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::create_approve_module_cap(0x2::object::uid_to_inner(&v0), arg0),
        };
        0x2::transfer::share_object<SodotModule>(v1);
    }

    public fun get_module_cap_id(arg0: &SodotModule) : 0x2::object::ID {
        0x2::object::id<0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::ApproveModuleCap>(&arg0.module_cap)
    }

    public fun init_sodot(arg0: &SodotModule, arg1: 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::InitApproveModuleRequest, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x8149631b2b88686a6ae1337c93939c0ed52f9b32dd0817612557dee54c8f1894::approve_interface::consume_init_approve_module_request(&arg0.module_cap, arg1);
        let v3 = InitEvent{
            approve_cap_id : v0,
            workspace_id   : v1,
            user_id        : v2,
            identifier     : arg2,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<InitEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

