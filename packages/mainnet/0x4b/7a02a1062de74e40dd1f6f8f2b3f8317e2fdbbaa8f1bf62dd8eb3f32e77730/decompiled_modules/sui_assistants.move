module 0x4b7a02a1062de74e40dd1f6f8f2b3f8317e2fdbbaa8f1bf62dd8eb3f32e77730::sui_assistants {
    struct Assistant has store, key {
        id: 0x2::object::UID,
        category: 0x1::string::String,
        enabled: bool,
        about: 0x1::string::String,
        default_greetings: 0x1::string::String,
        language: 0x1::string::String,
        name: 0x1::string::String,
        profile_image: 0x1::string::String,
        role: 0x1::string::String,
        is_private: bool,
        prompt: 0x1::string::String,
        user_id: 0x1::string::String,
        user_email: 0x1::string::String,
        user_name: 0x1::string::String,
        likes: u64,
        user_price: u64,
    }

    struct AssistantAccess has store, key {
        id: 0x2::object::UID,
        user_access: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct AssistantsRegistry has key {
        id: 0x2::object::UID,
        assistants: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_assistants: u64,
    }

    struct AssistantNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun about(arg0: &Assistant) : 0x1::string::String {
        arg0.about
    }

    entry fun add_user_access(arg0: &mut AssistantAccess, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_access, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_access, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_access, arg1);
        let (v1, _) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
        if (!v1) {
            0x1::vector::push_back<0x2::object::ID>(v0, arg2);
        };
    }

    public fun burn(arg0: Assistant, arg1: &mut 0x2::tx_context::TxContext) {
        let Assistant {
            id                : v0,
            category          : _,
            enabled           : _,
            about             : _,
            default_greetings : _,
            language          : _,
            name              : _,
            profile_image     : _,
            role              : _,
            is_private        : _,
            prompt            : _,
            user_id           : _,
            user_email        : _,
            user_name         : _,
            likes             : _,
            user_price        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun category(arg0: &Assistant) : 0x1::string::String {
        arg0.category
    }

    entry fun create_assistant(arg0: &mut AssistantsRegistry, arg1: 0x1::string::String, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: bool, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = Assistant{
            id                : 0x2::object::new(arg16),
            category          : arg1,
            enabled           : arg2,
            about             : arg3,
            default_greetings : arg4,
            language          : arg5,
            name              : arg6,
            profile_image     : arg7,
            role              : arg8,
            is_private        : arg9,
            prompt            : arg10,
            user_id           : arg11,
            user_email        : arg12,
            user_name         : arg13,
            likes             : arg14,
            user_price        : arg15,
        };
        let v1 = AssistantNFTMinted{
            object_id : 0x2::object::id<Assistant>(&v0),
            creator   : 0x2::tx_context::sender(arg16),
            name      : v0.name,
        };
        0x2::event::emit<AssistantNFTMinted>(v1);
        0x2::transfer::transfer<Assistant>(v0, 0x2::tx_context::sender(arg16));
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, 0x2::tx_context::sender(arg16))) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.assistants, 0x2::tx_context::sender(arg16), 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, 0x2::tx_context::sender(arg16)), *0x2::object::borrow_id<Assistant>(&v0));
        arg0.total_assistants = arg0.total_assistants + 1;
    }

    entry fun decrease_likes(arg0: &mut Assistant) {
        arg0.likes = arg0.likes - 1;
    }

    public fun default_greetings(arg0: &Assistant) : 0x1::string::String {
        arg0.default_greetings
    }

    public fun enabled(arg0: &Assistant) : bool {
        arg0.enabled
    }

    entry fun increase_likes(arg0: &mut Assistant) {
        arg0.likes = arg0.likes + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AssistantsRegistry{
            id               : 0x2::object::new(arg0),
            assistants       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_assistants : 0,
        };
        let v1 = AssistantAccess{
            id          : 0x2::object::new(arg0),
            user_access : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::transfer<AssistantsRegistry>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AssistantAccess>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_private(arg0: &Assistant) : bool {
        arg0.is_private
    }

    public fun language(arg0: &Assistant) : 0x1::string::String {
        arg0.language
    }

    public fun likes(arg0: &Assistant) : u64 {
        arg0.likes
    }

    public fun name(arg0: &Assistant) : 0x1::string::String {
        arg0.name
    }

    public fun profile_image(arg0: &Assistant) : 0x1::string::String {
        arg0.profile_image
    }

    public fun prompt(arg0: &Assistant) : 0x1::string::String {
        arg0.prompt
    }

    entry fun remove_user_access(arg0: &mut AssistantAccess, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_access, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_access, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
            };
        };
    }

    public fun role(arg0: &Assistant) : 0x1::string::String {
        arg0.role
    }

    entry fun update_assistant(arg0: &mut Assistant, arg1: 0x1::string::String, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: bool, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64) {
        arg0.category = arg1;
        arg0.enabled = arg2;
        arg0.about = arg3;
        arg0.default_greetings = arg4;
        arg0.language = arg5;
        arg0.name = arg6;
        arg0.profile_image = arg7;
        arg0.role = arg8;
        arg0.is_private = arg9;
        arg0.prompt = arg10;
        arg0.user_id = arg11;
        arg0.user_email = arg12;
        arg0.user_name = arg13;
        arg0.likes = arg14;
        arg0.user_price = arg15;
    }

    public fun user_email(arg0: &Assistant) : 0x1::string::String {
        arg0.user_email
    }

    public fun user_id(arg0: &Assistant) : 0x1::string::String {
        arg0.user_id
    }

    public fun user_name(arg0: &Assistant) : 0x1::string::String {
        arg0.user_name
    }

    public fun user_price(arg0: &Assistant) : u64 {
        arg0.user_price
    }

    // decompiled from Move bytecode v6
}

