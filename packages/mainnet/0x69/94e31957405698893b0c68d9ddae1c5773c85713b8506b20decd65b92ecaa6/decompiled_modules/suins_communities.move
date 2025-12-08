module 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities {
    struct X has drop {
        dummy_field: bool,
    }

    struct Youtube has drop {
        dummy_field: bool,
    }

    struct Web has drop {
        dummy_field: bool,
    }

    struct Discord has drop {
        dummy_field: bool,
    }

    struct Telegram has drop {
        dummy_field: bool,
    }

    struct Github has drop {
        dummy_field: bool,
    }

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
        social_links: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::string::String>,
        top_account_links: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x1::string::String>>,
        faucet_enabled: bool,
        faucet_fee_paid: bool,
        linked_domain_id: 0x1::option::Option<0x2::object::ID>,
        faucet_requirements: FaucetRequirements,
    }

    struct Allowlist has key {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, bool>,
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

    struct MintRequest {
        id: 0x2::object::ID,
    }

    public fun add_address(arg0: &AdminCap, arg1: &mut Allowlist, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.addresses, arg2, true);
    }

    public fun banner_url(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        arg0.banner_url
    }

    public fun burn(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: Community, arg2: 0x1::string::String, arg3: &mut Registry, arg4: &0x2::clock::Clock, arg5: &Version, arg6: &mut 0x2::tx_context::TxContext) {
        validate_version(arg5);
        validate_name_ownership_and_status(arg0, arg2, arg4, arg6);
        assert!(arg2 == arg1.name, 15);
        assert!(0x2::bag::contains<0x1::string::String>(&arg3.registry, arg2), 12);
        assert!(!arg1.faucet_enabled, 13);
        0x2::bag::remove<0x1::string::String, 0x2::object::ID>(&mut arg3.registry, arg2);
        let Community {
            id                  : v0,
            name                : _,
            banner_url          : _,
            image_url           : _,
            created_at          : _,
            title               : _,
            description         : _,
            social_links        : _,
            top_account_links   : _,
            faucet_enabled      : _,
            faucet_fee_paid     : _,
            linked_domain_id    : _,
            faucet_requirements : v12,
        } = arg1;
        0x2::object::delete(v0);
        let FaucetRequirements {
            who        : _,
            fee        : _,
            wallet_age : _,
        } = v12;
    }

    public fun burn_allowlist_and_admin_cap(arg0: AdminCap, arg1: Allowlist) {
        let Allowlist {
            id        : v0,
            addresses : v1,
        } = arg1;
        0x2::table::drop<address, bool>(v1);
        0x2::object::delete(v0);
        let AdminCap { id: v2 } = arg0;
        0x2::object::delete(v2);
    }

    fun check_multiple_social_platforms(arg0: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::string::String>, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::string::String>(&arg0);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (!(0x1::type_name::address_string(0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2)) == arg1)) {
                v3 = false;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = true;
        v3
    }

    fun check_social_platform(arg0: 0x1::type_name::TypeName, arg1: 0x1::ascii::String) : bool {
        0x1::type_name::address_string(&arg0) == arg1
    }

    public fun complete_mint(arg0: Community, arg1: MintRequest, arg2: &Version) {
        validate_version(arg2);
        let MintRequest { id: v0 } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 10);
        0x2::transfer::share_object<Community>(arg0);
    }

    public fun create_allowlist(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Allowlist{
            id        : 0x2::object::new(arg1),
            addresses : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Allowlist>(v0);
    }

    public fun description(arg0: &Community) : 0x1::string::String {
        arg0.description
    }

    public fun faucet_enabled(arg0: &Community) : bool {
        arg0.faucet_enabled
    }

    public fun faucet_fee_paid(arg0: &Community) : bool {
        arg0.faucet_fee_paid
    }

    public fun fee_requirements(arg0: &Community) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.faucet_requirements.fee
    }

    public fun get_addresses(arg0: &Allowlist) : &0x2::table::Table<address, bool> {
        &arg0.addresses
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
            version : 2,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Version>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun linked_domain_id(arg0: &Community) : 0x1::option::Option<0x2::object::ID> {
        arg0.linked_domain_id
    }

    entry fun migrate(arg0: &0x2::package::Publisher, arg1: &mut Version) {
        assert!(0x2::package::from_package<Version>(arg0), 9);
        assert!(arg1.version < 2, 8);
        arg1.version = 2;
    }

    public fun mint_authorized(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::string::String>, arg7: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x1::string::String>>, arg8: &mut Registry, arg9: &Allowlist, arg10: &0x2::clock::Clock, arg11: &Version, arg12: &mut 0x2::tx_context::TxContext) : (Community, MintRequest) {
        validate_version(arg11);
        assert!(0x2::table::contains<address, bool>(&arg9.addresses, 0x2::tx_context::sender(arg12)), 14);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg8.registry, arg1), 5);
        validate_name_ownership_and_status(arg0, arg1, arg10, arg12);
        let v0 = 0x1::type_name::with_defining_ids<Community>();
        assert!(check_multiple_social_platforms(arg6, 0x1::type_name::address_string(&v0)), 11);
        let v1 = FaucetRequirements{
            who        : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            fee        : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            wallet_age : 0,
        };
        let v2 = Community{
            id                  : 0x2::object::new(arg12),
            name                : arg1,
            banner_url          : arg4,
            image_url           : arg5,
            created_at          : 0x2::clock::timestamp_ms(arg10),
            title               : arg2,
            description         : arg3,
            social_links        : arg6,
            top_account_links   : arg7,
            faucet_enabled      : false,
            faucet_fee_paid     : false,
            linked_domain_id    : 0x1::option::none<0x2::object::ID>(),
            faucet_requirements : v1,
        };
        0x2::bag::add<0x1::string::String, 0x2::object::ID>(&mut arg8.registry, arg1, 0x2::object::uid_to_inner(&v2.id));
        let v3 = MintRequest{id: 0x2::object::uid_to_inner(&v2.id)};
        (v2, v3)
    }

    public fun name(arg0: &Community) : 0x1::string::String {
        arg0.name
    }

    public fun package_version() : u64 {
        2
    }

    public fun registry(arg0: &Registry) : &0x2::bag::Bag {
        &arg0.registry
    }

    public fun remove_address(arg0: &AdminCap, arg1: &mut Allowlist, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.addresses, arg2);
    }

    public fun remove_fee_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        validate_version(arg3);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.fee, &v0);
    }

    public fun remove_social_link<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        validate_version(arg3);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::string::String>(&mut arg1.social_links, &v0);
    }

    public fun remove_top_accounts<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        validate_version(arg3);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x1::string::String>>(&mut arg1.top_account_links, &v0);
    }

    public fun remove_who_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: &Version, arg4: &0x2::tx_context::TxContext) {
        validate_version(arg3);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
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

    public(friend) fun set_faucet_enabled(arg0: &mut Community, arg1: bool) {
        arg0.faucet_enabled = arg1;
    }

    public(friend) fun set_faucet_fee_paid(arg0: &mut Community, arg1: bool) {
        arg0.faucet_fee_paid = arg1;
    }

    public fun set_fee_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: u64, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &0x2::tx_context::TxContext) {
        validate_version(arg4);
        assert!(arg2 > 0, 6);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.faucet_requirements.fee, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.fee, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.fee, &v0) = arg2;
        };
    }

    public fun set_image_url(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.image_url = arg2;
    }

    public(friend) fun set_linked_domain_id(arg0: &mut Community, arg1: 0x1::option::Option<0x2::object::ID>) {
        arg0.linked_domain_id = arg1;
    }

    public fun set_social_link<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<Community>();
        assert!(check_social_platform(v0, 0x1::type_name::address_string(&v1)), 11);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::string::String>(&arg1.social_links, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::string::String>(&mut arg1.social_links, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::string::String>(&mut arg1.social_links, v0, arg2);
        };
    }

    public fun set_title(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        arg1.title = arg2;
    }

    public fun set_top_accounts<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &mut 0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<Community>();
        assert!(check_social_platform(v0, 0x1::type_name::address_string(&v1)), 11);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x1::string::String>>(&arg1.top_account_links, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<0x1::string::String>>(&mut arg1.top_account_links, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<0x1::string::String>>(&mut arg1.top_account_links, v0, arg2);
        };
    }

    public fun set_wallet_age_requirement(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: &0x2::clock::Clock, arg3: u64, arg4: &Version, arg5: &0x2::tx_context::TxContext) {
        validate_version(arg4);
        validate_name_ownership_and_status(arg0, arg1.name, arg2, arg5);
        arg1.faucet_requirements.wallet_age = arg3;
    }

    public fun set_who_requirement<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut Community, arg2: u64, arg3: &0x2::clock::Clock, arg4: &Version, arg5: &0x2::tx_context::TxContext) {
        validate_version(arg4);
        assert!(arg2 > 0, 7);
        validate_name_ownership_and_status(arg0, arg1.name, arg3, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.faucet_requirements.who, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.who, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.faucet_requirements.who, &v0) = arg2;
        };
    }

    public fun social_link_by_platform<T0>(arg0: &Community) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::try_get<0x1::type_name::TypeName, 0x1::string::String>(&arg0.social_links, &v0)
    }

    public fun social_links(arg0: &Community) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::string::String> {
        &arg0.social_links
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

    public fun title(arg0: &Community) : 0x1::string::String {
        arg0.title
    }

    public fun top_accounts(arg0: &Community) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x1::string::String>> {
        &arg0.top_account_links
    }

    public fun top_accounts_by_platform<T0>(arg0: &Community) : 0x1::option::Option<vector<0x1::string::String>> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::try_get<0x1::type_name::TypeName, vector<0x1::string::String>>(&arg0.top_account_links, &v0)
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
        assert!(arg0.version == 2, 8);
    }

    public fun version(arg0: &Version) : u64 {
        arg0.version
    }

    public fun wallet_age_requirement(arg0: &Community) : u64 {
        arg0.faucet_requirements.wallet_age
    }

    public fun who_requirements(arg0: &Community) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        &arg0.faucet_requirements.who
    }

    // decompiled from Move bytecode v6
}

