module 0x6d7346f060ab679636e195547c7886dca9ea55185cd2435276aa4c7cd8c7bf02::repeasy_verify {
    struct REPEASY_VERIFY has drop {
        dummy_field: bool,
    }

    struct DAppRegistry has key {
        id: 0x2::object::UID,
        dapps: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        domains: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        total_verified: u64,
    }

    struct DAppInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        domain_url: 0x1::string::String,
        twitter_username: 0x1::string::String,
        banner_blob_id: 0x1::string::String,
        icon_blob_id: 0x1::string::String,
        description_blob_id: 0x1::string::String,
        owner: address,
        verified_at: u64,
        verification_badge_id: 0x2::object::ID,
    }

    struct VerificationBadge has store, key {
        id: 0x2::object::UID,
        dapp_name: 0x1::string::String,
        domain_url: 0x1::string::String,
        owner: address,
        verified_at: u64,
        badge_number: u64,
        banner_blob_id: 0x1::string::String,
        icon_blob_id: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DAppVerified has copy, drop {
        dapp_info_id: 0x2::object::ID,
        badge_id: 0x2::object::ID,
        name: 0x1::string::String,
        domain_url: 0x1::string::String,
        owner: address,
        verified_at: u64,
    }

    struct DAppUpdated has copy, drop {
        dapp_info_id: 0x2::object::ID,
        name: 0x1::string::String,
        updated_by: address,
        updated_at: u64,
    }

    public fun get_badge_dapp_name(arg0: &VerificationBadge) : 0x1::string::String {
        arg0.dapp_name
    }

    public fun get_badge_domain_url(arg0: &VerificationBadge) : 0x1::string::String {
        arg0.domain_url
    }

    public fun get_badge_number(arg0: &VerificationBadge) : u64 {
        arg0.badge_number
    }

    public fun get_badge_owner(arg0: &VerificationBadge) : address {
        arg0.owner
    }

    public fun get_badge_verified_at(arg0: &VerificationBadge) : u64 {
        arg0.verified_at
    }

    public fun get_banner_blob_id(arg0: &DAppInfo) : 0x1::string::String {
        arg0.banner_blob_id
    }

    public fun get_dapp_id_by_domain(arg0: &DAppRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.domains, arg1), 5);
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.domains, arg1)
    }

    public fun get_dapp_id_by_name(arg0: &DAppRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.dapps, arg1), 5);
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.dapps, arg1)
    }

    public fun get_dapp_name(arg0: &DAppInfo) : 0x1::string::String {
        arg0.name
    }

    public fun get_description_blob_id(arg0: &DAppInfo) : 0x1::string::String {
        arg0.description_blob_id
    }

    public fun get_domain_url(arg0: &DAppInfo) : 0x1::string::String {
        arg0.domain_url
    }

    public fun get_icon_blob_id(arg0: &DAppInfo) : 0x1::string::String {
        arg0.icon_blob_id
    }

    public fun get_owner(arg0: &DAppInfo) : address {
        arg0.owner
    }

    public fun get_total_verified(arg0: &DAppRegistry) : u64 {
        arg0.total_verified
    }

    public fun get_twitter_username(arg0: &DAppInfo) : 0x1::string::String {
        arg0.twitter_username
    }

    public fun get_verified_at(arg0: &DAppInfo) : u64 {
        arg0.verified_at
    }

    fun init(arg0: REPEASY_VERIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DAppRegistry{
            id             : 0x2::object::new(arg1),
            dapps          : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            domains        : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            total_verified : 0,
        };
        0x2::transfer::share_object<DAppRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::package::claim<REPEASY_VERIFY>(arg0, arg1);
        let v3 = 0x2::display::new<VerificationBadge>(&v2, arg1);
        0x2::display::add<VerificationBadge>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Repeasy Verification Badge - {dapp_name}"));
        0x2::display::add<VerificationBadge>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Official verification badge for {dapp_name} on Repeasy platform"));
        0x2::display::add<VerificationBadge>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/{icon_blob_id}"));
        0x2::display::add<VerificationBadge>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"{domain_url}"));
        0x2::display::add<VerificationBadge>(&mut v3, 0x1::string::utf8(b"badge_number"), 0x1::string::utf8(b"#{badge_number}"));
        0x2::display::update_version<VerificationBadge>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VerificationBadge>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun is_dapp_verified(arg0: &DAppRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.dapps, arg1)
    }

    public fun is_domain_registered(arg0: &DAppRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.domains, arg1)
    }

    public entry fun update_dapp_info(arg0: &mut DAppInfo, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg0.owner == v0, 3);
        assert!(0x1::string::length(&arg2) > 0, 4);
        assert!(0x1::string::length(&arg3) > 0, 4);
        assert!(0x1::string::length(&arg4) > 0, 4);
        arg0.twitter_username = arg1;
        arg0.banner_blob_id = arg2;
        arg0.icon_blob_id = arg3;
        arg0.description_blob_id = arg4;
        let v1 = DAppUpdated{
            dapp_info_id : 0x2::object::id<DAppInfo>(arg0),
            name         : arg0.name,
            updated_by   : v0,
            updated_at   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DAppUpdated>(v1);
    }

    public entry fun verify_dapp(arg0: &mut DAppRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.dapps, arg1), 1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.domains, arg2), 2);
        assert!(0x1::string::length(&arg4) > 0, 4);
        assert!(0x1::string::length(&arg5) > 0, 4);
        assert!(0x1::string::length(&arg6) > 0, 4);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        arg0.total_verified = arg0.total_verified + 1;
        let v2 = VerificationBadge{
            id             : 0x2::object::new(arg8),
            dapp_name      : arg1,
            domain_url     : arg2,
            owner          : v0,
            verified_at    : v1,
            badge_number   : arg0.total_verified,
            banner_blob_id : arg4,
            icon_blob_id   : arg5,
        };
        let v3 = 0x2::object::id<VerificationBadge>(&v2);
        let v4 = DAppInfo{
            id                    : 0x2::object::new(arg8),
            name                  : arg1,
            domain_url            : arg2,
            twitter_username      : arg3,
            banner_blob_id        : arg4,
            icon_blob_id          : arg5,
            description_blob_id   : arg6,
            owner                 : v0,
            verified_at           : v1,
            verification_badge_id : v3,
        };
        let v5 = 0x2::object::id<DAppInfo>(&v4);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.dapps, arg1, v5);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.domains, arg2, v5);
        let v6 = DAppVerified{
            dapp_info_id : v5,
            badge_id     : v3,
            name         : arg1,
            domain_url   : arg2,
            owner        : v0,
            verified_at  : v1,
        };
        0x2::event::emit<DAppVerified>(v6);
        0x2::transfer::transfer<VerificationBadge>(v2, v0);
        0x2::transfer::share_object<DAppInfo>(v4);
    }

    // decompiled from Move bytecode v6
}

