module 0xb6750b757e4e44a0d01e3e62824e0b00ab3cb50e2f54888346a3e4c0ba38524d::suins_communities {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Community has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        banner_url: 0x1::option::Option<0x1::string::String>,
        image_url: 0x1::option::Option<0x1::string::String>,
        created_at: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        x_link: 0x1::option::Option<0x1::string::String>,
        youtube_link: 0x1::option::Option<0x1::string::String>,
        web_link: 0x1::option::Option<0x1::string::String>,
        discord_link: 0x1::option::Option<0x1::string::String>,
        telegram_link: 0x1::option::Option<0x1::string::String>,
        github_link: 0x1::option::Option<0x1::string::String>,
        top_x_links: vector<0x1::string::String>,
        linked_domain_id: 0x1::option::Option<0x2::object::ID>,
        faucet_requirements: FaucetRequirements,
    }

    struct FaucetRequirements has store {
        who: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fee: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        wallet_age: u64,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::bag::Bag,
    }

    struct SUINS_COMMUNITIES has drop {
        dummy_field: bool,
    }

    public fun banner_url(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.banner_url
    }

    public fun burn(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: Community, arg2: 0x1::string::String, arg3: &mut Registry, arg4: &0x2::clock::Clock, arg5: &Version, arg6: &mut 0x2::tx_context::TxContext) {
        validate_version(arg5);
        validate_name_ownership_and_status(arg0, arg2, arg4, arg6);
        0x2::bag::remove<0x1::string::String, 0x2::object::ID>(&mut arg3.registry, arg2);
        let Community {
            id                  : v0,
            name                : _,
            banner_url          : _,
            image_url           : _,
            created_at          : _,
            title               : _,
            description         : _,
            x_link              : _,
            youtube_link        : _,
            web_link            : _,
            discord_link        : _,
            telegram_link       : _,
            github_link         : _,
            top_x_links         : v13,
            linked_domain_id    : _,
            faucet_requirements : v15,
        } = arg1;
        0x2::object::delete(v0);
        0x1::vector::destroy_empty<0x1::string::String>(v13);
        let FaucetRequirements {
            who        : _,
            fee        : _,
            wallet_age : _,
        } = v15;
    }

    public fun description(arg0: &Community) : 0x1::string::String {
        arg0.description
    }

    public fun discord_link(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.discord_link
    }

    public fun fee_requirements(arg0: &Community) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.faucet_requirements.fee
    }

    public fun github_link(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.github_link
    }

    public fun image_url(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.image_url
    }

    fun init(arg0: SUINS_COMMUNITIES, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUINS_COMMUNITIES>(arg0, arg1);
        let v0 = Registry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::bag::new(arg1),
        };
        let v1 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Version>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun linked_domain_id(arg0: &Community) : 0x1::option::Option<0x2::object::ID> {
        arg0.linked_domain_id
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Version) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    public fun mint(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::option::Option<0x1::string::String>, arg10: 0x1::option::Option<0x1::string::String>, arg11: 0x1::option::Option<0x1::string::String>, arg12: vector<0x1::string::String>, arg13: &mut Registry, arg14: &0x2::clock::Clock, arg15: &Version, arg16: &mut 0x2::tx_context::TxContext) {
        validate_version(arg15);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg13.registry, arg1), 5);
        validate_name_ownership_and_status(arg0, arg1, arg14, arg16);
        let v0 = FaucetRequirements{
            who        : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            fee        : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            wallet_age : 0,
        };
        let v1 = Community{
            id                  : 0x2::object::new(arg16),
            name                : arg1,
            banner_url          : arg4,
            image_url           : arg5,
            created_at          : 0x2::clock::timestamp_ms(arg14),
            title               : arg2,
            description         : arg3,
            x_link              : arg6,
            youtube_link        : arg7,
            web_link            : arg8,
            discord_link        : arg9,
            telegram_link       : arg10,
            github_link         : arg11,
            top_x_links         : arg12,
            linked_domain_id    : 0x1::option::none<0x2::object::ID>(),
            faucet_requirements : v0,
        };
        0x2::bag::add<0x1::string::String, 0x2::object::ID>(&mut arg13.registry, arg1, 0x2::object::id<Community>(&v1));
        0x2::transfer::share_object<Community>(v1);
    }

    public fun name(arg0: &Community) : 0x1::string::String {
        arg0.name
    }

    public fun package_version() : u64 {
        1
    }

    public fun registry(arg0: &Registry) : &0x2::bag::Bag {
        &arg0.registry
    }

    public fun remove_fee_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        validate_version(arg3);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg4);
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.fee, &v0);
    }

    public fun remove_who_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        validate_version(arg3);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg4);
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.who, &v0);
    }

    public fun set_banner_url(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.banner_url = arg2;
    }

    public fun set_description(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.description = arg2;
    }

    public fun set_discord_link(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.discord_link = arg2;
    }

    public fun set_fee_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: u64, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &0x2::tx_context::TxContext) {
        validate_version(arg4);
        assert!(arg2 > 0, 6);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.faucet_requirements.fee, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.fee, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.fee, &v0) = arg2;
        };
    }

    public fun set_github_link(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.github_link = arg2;
    }

    public fun set_image_url(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.image_url = arg2;
    }

    public(friend) fun set_linked_domain_id(arg0: &mut Community, arg1: 0x2::object::ID) {
        arg0.linked_domain_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_telegram_link(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.telegram_link = arg2;
    }

    public fun set_title(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.title = arg2;
    }

    public fun set_top_x_links(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.top_x_links = arg2;
    }

    public fun set_wallet_age_requirement(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: u64, arg4: &Version, arg5: &0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg5);
        arg1.faucet_requirements.wallet_age = arg3;
    }

    public fun set_web_link(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.web_link = arg2;
    }

    public fun set_who_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: u64, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &0x2::tx_context::TxContext) {
        validate_version(arg4);
        assert!(arg2 > 0, 7);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.faucet_requirements.who, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.who, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.who, &v0) = arg2;
        };
    }

    public fun set_x_link(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.x_link = arg2;
    }

    public fun set_youtube_link(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.youtube_link = arg2;
    }

    fun split_by_dot(arg0: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = 0x1::string::utf8(b".");
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (!0x1::string::is_empty(&arg0)) {
            let v2 = 0x1::string::index_of(&arg0, &v0);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::substring(&arg0, 0, v2));
            let v3 = 0x1::string::length(&arg0);
            let v4 = if (v2 == v3) {
                v3
            } else {
                v2 + 1
            };
            let v5 = &arg0;
            arg0 = 0x1::string::substring(v5, v4, v3);
        };
        v1
    }

    public fun telegram_link(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.telegram_link
    }

    public fun title(arg0: &Community) : 0x1::string::String {
        arg0.title
    }

    public fun top_x_links(arg0: &Community) : vector<0x1::string::String> {
        arg0.top_x_links
    }

    public(friend) fun validate_name_ownership_and_status(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = split_by_dot(arg1);
        assert!(0x1::vector::length<0x1::string::String>(&v0) == 2, 3);
        let v1 = 0x1::string::utf8(b"sui");
        assert!(0x1::vector::borrow<0x1::string::String>(&v0, 1) == &v1, 4);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1));
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v2), 0);
        let v3 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&mut v2);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::has_expired(&v3, arg2), 2);
        let v4 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(&v3);
        assert!(0x1::option::extract<address>(&mut v4) == 0x2::tx_context::sender(arg3), 1);
    }

    fun validate_version(arg0: &Version) {
        assert!(arg0.version == 1, 8);
    }

    public fun version(arg0: &Version) : u64 {
        arg0.version
    }

    public fun wallet_age_requirement(arg0: &Community) : u64 {
        arg0.faucet_requirements.wallet_age
    }

    public fun web_link(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.web_link
    }

    public fun who_requirements(arg0: &Community) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.faucet_requirements.who
    }

    public fun x_link(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.x_link
    }

    public fun youtube_link(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.youtube_link
    }

    // decompiled from Move bytecode v6
}

