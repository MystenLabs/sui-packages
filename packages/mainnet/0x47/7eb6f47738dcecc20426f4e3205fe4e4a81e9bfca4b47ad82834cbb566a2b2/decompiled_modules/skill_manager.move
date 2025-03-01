module 0x477eb6f47738dcecc20426f4e3205fe4e4a81e9bfca4b47ad82834cbb566a2b2::skill_manager {
    struct Skill has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        endpoint: 0x1::ascii::String,
        doc: 0x1::ascii::String,
        github_repo: 0x1::ascii::String,
        docker_image: 0x1::ascii::String,
        quote: 0x1::ascii::String,
        log_url: 0x1::ascii::String,
        public_key: 0x1::ascii::String,
        fee: u64,
        author: address,
        is_enabled: bool,
    }

    public entry fun create_skill(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = Skill{
            id           : 0x2::object::new(arg10),
            name         : arg0,
            description  : arg1,
            endpoint     : arg2,
            doc          : arg3,
            github_repo  : arg4,
            docker_image : arg5,
            quote        : arg6,
            log_url      : arg7,
            public_key   : arg8,
            fee          : arg9,
            author       : 0x2::tx_context::sender(arg10),
            is_enabled   : true,
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

