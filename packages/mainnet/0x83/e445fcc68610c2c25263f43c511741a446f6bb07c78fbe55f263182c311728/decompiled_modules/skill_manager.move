module 0x83e445fcc68610c2c25263f43c511741a446f6bb07c78fbe55f263182c311728::skill_manager {
    struct Skill has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        endpoint: 0x1::ascii::String,
        github_repo: 0x1::ascii::String,
        docker_image: 0x1::ascii::String,
        app_id: 0x1::ascii::String,
        fee: u64,
        author: address,
        is_enabled: bool,
        skill_type: 0x1::ascii::String,
    }

    public entry fun create_skill(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64, arg7: 0x1::ascii::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Skill{
            id           : 0x2::object::new(arg8),
            name         : arg0,
            description  : arg1,
            endpoint     : arg2,
            github_repo  : arg3,
            docker_image : arg4,
            app_id       : arg5,
            fee          : arg6,
            author       : 0x2::tx_context::sender(arg8),
            is_enabled   : true,
            skill_type   : arg7,
        };
        0x2::transfer::share_object<Skill>(v0);
    }

    public fun get_skill_type(arg0: &Skill) : 0x1::ascii::String {
        arg0.skill_type
    }

    public fun is_enabled(arg0: &Skill) : bool {
        arg0.is_enabled
    }

    public entry fun toggle_skill(arg0: &mut Skill, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.author, 202);
        arg0.is_enabled = !arg0.is_enabled;
    }

    public entry fun update_skill(arg0: &mut Skill, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.author, 202);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.fee = arg3;
    }

    // decompiled from Move bytecode v6
}

