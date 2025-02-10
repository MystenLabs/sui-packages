module 0x2cc8f46cd267e8fb99b381f8ee70a8ce6633ce26623e1ea4c903599cb58c5339::skill_manager {
    struct Skill has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        doc: 0x1::ascii::String,
        fee: u64,
        author: address,
        is_enabled: bool,
    }

    public entry fun create_skill(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Skill{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            doc         : arg2,
            fee         : arg3,
            author      : 0x2::tx_context::sender(arg4),
            is_enabled  : true,
        };
        0x2::transfer::share_object<Skill>(v0);
    }

    public fun is_enabled(arg0: &Skill) : bool {
        arg0.is_enabled
    }

    public entry fun toggle_skill(arg0: &mut Skill, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.author, 202);
        arg0.is_enabled = !arg0.is_enabled;
    }

    public entry fun update_skill(arg0: &mut Skill, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.author, 202);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.doc = arg3;
        arg0.fee = arg4;
    }

    // decompiled from Move bytecode v6
}

