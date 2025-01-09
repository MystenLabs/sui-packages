module 0xc68c45197e53143b4964cad39d920cb995ad8a24dbcbe6779fcb6a09984113fd::sui_assistants {
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

    struct AssistantsMarketPlaceRegistry has key {
        id: 0x2::object::UID,
        assistants: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_assistants: u64,
    }

    struct AssistantsPrivateRegistry has key {
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

    public entry fun add_martketplace(arg0: &mut AssistantsMarketPlaceRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1), arg2);
        arg0.total_assistants = arg0.total_assistants + 1;
    }

    public entry fun add_private(arg0: &mut AssistantsPrivateRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1), arg2);
        arg0.total_assistants = arg0.total_assistants + 1;
    }

    public entry fun add_registry(arg0: &mut AssistantsRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1), arg2);
        arg0.total_assistants = arg0.total_assistants + 1;
    }

    public entry fun add_user_access(arg0: &mut AssistantAccess, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_access, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.user_access, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.user_access, arg1);
        let (v1, _) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
        if (!v1) {
            0x1::vector::push_back<0x2::object::ID>(v0, arg2);
        };
    }

    public entry fun burn_assistant(arg0: Assistant) {
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

    public entry fun create_assistant(arg0: 0x1::string::String, arg1: bool, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: bool, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = Assistant{
            id                : 0x2::object::new(arg15),
            category          : arg0,
            enabled           : arg1,
            about             : arg2,
            default_greetings : arg3,
            language          : arg4,
            name              : arg5,
            profile_image     : arg6,
            role              : arg7,
            is_private        : arg8,
            prompt            : arg9,
            user_id           : arg10,
            user_email        : arg11,
            user_name         : arg12,
            likes             : arg13,
            user_price        : arg14,
        };
        let v1 = AssistantNFTMinted{
            object_id : 0x2::object::id<Assistant>(&v0),
            creator   : 0x2::tx_context::sender(arg15),
            name      : v0.name,
        };
        0x2::event::emit<AssistantNFTMinted>(v1);
        0x2::transfer::transfer<Assistant>(v0, 0x2::tx_context::sender(arg15));
    }

    public entry fun decrease_likes(arg0: &mut Assistant) {
        arg0.likes = arg0.likes - 1;
    }

    public fun default_greetings(arg0: &Assistant) : 0x1::string::String {
        arg0.default_greetings
    }

    public fun enabled(arg0: &Assistant) : bool {
        arg0.enabled
    }

    public entry fun increase_likes(arg0: &mut Assistant) {
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
        let v2 = AssistantsMarketPlaceRegistry{
            id               : 0x2::object::new(arg0),
            assistants       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_assistants : 0,
        };
        let v3 = AssistantsPrivateRegistry{
            id               : 0x2::object::new(arg0),
            assistants       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_assistants : 0,
        };
        0x2::transfer::transfer<AssistantsRegistry>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AssistantAccess>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AssistantsMarketPlaceRegistry>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AssistantsPrivateRegistry>(v3, 0x2::tx_context::sender(arg0));
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

    public entry fun remove_martketplace(arg0: &mut AssistantsMarketPlaceRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
                arg0.total_assistants = arg0.total_assistants - 1;
            };
        };
    }

    public entry fun remove_private(arg0: &mut AssistantsPrivateRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
                arg0.total_assistants = arg0.total_assistants - 1;
            };
        };
    }

    public entry fun remove_registry(arg0: &mut AssistantsRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.assistants, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.assistants, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
                arg0.total_assistants = arg0.total_assistants - 1;
            };
        };
    }

    public entry fun remove_user_access(arg0: &mut AssistantAccess, arg1: address, arg2: 0x2::object::ID) {
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

    public entry fun update_assistant(arg0: &mut Assistant, arg1: 0x1::string::String, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: bool, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u64, arg15: u64) {
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

