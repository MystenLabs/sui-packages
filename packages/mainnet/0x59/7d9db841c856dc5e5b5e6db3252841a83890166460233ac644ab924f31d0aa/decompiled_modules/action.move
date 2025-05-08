module 0x597d9db841c856dc5e5b5e6db3252841a83890166460233ac644ab924f31d0aa::action {
    struct ACTION has drop {
        dummy_field: bool,
    }

    struct Action has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        slug: 0x1::string::String,
    }

    struct ActionRegistry has key {
        id: 0x2::object::UID,
        actions: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut ActionRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Action{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            slug        : arg2,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg3.actions, arg2, 0x2::object::id<Action>(&v0));
        0x2::transfer::share_object<Action>(v0);
    }

    fun init(arg0: ACTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ActionRegistry{
            id      : 0x2::object::new(arg1),
            actions : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<ActionRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

