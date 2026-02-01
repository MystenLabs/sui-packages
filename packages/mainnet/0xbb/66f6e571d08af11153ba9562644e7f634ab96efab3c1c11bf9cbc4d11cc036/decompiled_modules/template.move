module 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::template {
    struct TemplateCreated has copy, drop {
        template_id: 0x2::object::ID,
        creator_agent: 0x2::object::ID,
        name: 0x1::string::String,
        skill_id: 0x2::object::ID,
        created_at: u64,
    }

    struct TemplateUpdated has copy, drop {
        template_id: 0x2::object::ID,
        updated_at: u64,
    }

    struct TemplateDeprecated has copy, drop {
        template_id: 0x2::object::ID,
        deprecated_at: u64,
    }

    struct Template has key {
        id: 0x2::object::UID,
        creator_agent: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        skill_id: 0x2::object::ID,
        skill_version: 0x1::string::String,
        default_input_ref: 0x1::option::Option<0x1::string::String>,
        default_expected_hash: 0x1::option::Option<0x1::string::String>,
        default_priority: u8,
        default_timeout: u64,
        is_public: bool,
        deprecated: bool,
        usage_count: u64,
        created_at: u64,
        updated_at: u64,
    }

    public fun id(arg0: &Template) : 0x2::object::ID {
        0x2::object::id<Template>(arg0)
    }

    public fun create(arg0: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::Skill, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: u8, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg0) == 0x2::tx_context::sender(arg9), 0);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg9);
        let v1 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg0);
        let v2 = 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::Skill>(arg1);
        let v3 = Template{
            id                    : 0x2::object::new(arg9),
            creator_agent         : v1,
            name                  : arg2,
            description           : arg3,
            skill_id              : v2,
            skill_version         : 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::skill::version(arg1),
            default_input_ref     : arg4,
            default_expected_hash : arg5,
            default_priority      : arg6,
            default_timeout       : arg7,
            is_public             : arg8,
            deprecated            : false,
            usage_count           : 0,
            created_at            : v0,
            updated_at            : v0,
        };
        let v4 = TemplateCreated{
            template_id   : 0x2::object::id<Template>(&v3),
            creator_agent : v1,
            name          : v3.name,
            skill_id      : v2,
            created_at    : v0,
        };
        0x2::event::emit<TemplateCreated>(v4);
        0x2::transfer::share_object<Template>(v3);
    }

    public fun created_at(arg0: &Template) : u64 {
        arg0.created_at
    }

    public fun creator_agent(arg0: &Template) : 0x2::object::ID {
        arg0.creator_agent
    }

    public fun default_expected_hash(arg0: &Template) : 0x1::option::Option<0x1::string::String> {
        arg0.default_expected_hash
    }

    public fun default_input_ref(arg0: &Template) : 0x1::option::Option<0x1::string::String> {
        arg0.default_input_ref
    }

    public fun default_priority(arg0: &Template) : u8 {
        arg0.default_priority
    }

    public fun default_timeout(arg0: &Template) : u64 {
        arg0.default_timeout
    }

    public fun deprecate(arg0: &mut Template, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.creator_agent, 1);
        assert!(!arg0.deprecated, 18);
        arg0.deprecated = true;
        let v0 = TemplateDeprecated{
            template_id   : 0x2::object::id<Template>(arg0),
            deprecated_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TemplateDeprecated>(v0);
    }

    public fun description(arg0: &Template) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun increment_usage(arg0: &mut Template) {
        arg0.usage_count = arg0.usage_count + 1;
    }

    public fun is_deprecated(arg0: &Template) : bool {
        arg0.deprecated
    }

    public fun is_public(arg0: &Template) : bool {
        arg0.is_public
    }

    public fun is_usable(arg0: &Template) : bool {
        !arg0.deprecated
    }

    public fun name(arg0: &Template) : 0x1::string::String {
        arg0.name
    }

    public fun set_public(arg0: &mut Template, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.creator_agent, 1);
        arg0.is_public = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
    }

    public fun skill_id(arg0: &Template) : 0x2::object::ID {
        arg0.skill_id
    }

    public fun skill_version(arg0: &Template) : 0x1::string::String {
        arg0.skill_version
    }

    public fun update(arg0: &mut Template, arg1: &0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::owner(arg1) == 0x2::tx_context::sender(arg6), 0);
        assert!(0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent::Agent>(arg1) == arg0.creator_agent, 1);
        assert!(!arg0.deprecated, 18);
        arg0.default_input_ref = arg2;
        arg0.default_expected_hash = arg3;
        arg0.default_priority = arg4;
        arg0.default_timeout = arg5;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v0 = TemplateUpdated{
            template_id : 0x2::object::id<Template>(arg0),
            updated_at  : arg0.updated_at,
        };
        0x2::event::emit<TemplateUpdated>(v0);
    }

    public fun updated_at(arg0: &Template) : u64 {
        arg0.updated_at
    }

    public fun usage_count(arg0: &Template) : u64 {
        arg0.usage_count
    }

    // decompiled from Move bytecode v6
}

