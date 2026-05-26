module 0x1595e8774c136091eb12b6b12c0a363a62a53f3fcc028c34a25fffe7dcdb85d::app_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AppProfile has key {
        id: 0x2::object::UID,
        app_name: 0x1::string::String,
        developer: address,
        website_url: 0x1::string::String,
        github_url: 0x1::string::String,
        suins_name: 0x1::string::String,
        app_version: 0x1::string::String,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct AppRegistered has copy, drop {
        app_name: 0x1::string::String,
        developer: address,
        app_profile_id: 0x2::object::ID,
        website_url: 0x1::string::String,
        github_url: 0x1::string::String,
        suins_name: 0x1::string::String,
        app_version: 0x1::string::String,
    }

    struct AppProfileUpdated has copy, drop {
        app_profile_id: 0x2::object::ID,
        developer: address,
        website_url: 0x1::string::String,
        github_url: 0x1::string::String,
        suins_name: 0x1::string::String,
        app_version: 0x1::string::String,
        updated_at_ms: u64,
    }

    public fun app_name(arg0: &AppProfile) : 0x1::string::String {
        arg0.app_name
    }

    public fun app_version(arg0: &AppProfile) : 0x1::string::String {
        arg0.app_version
    }

    public fun developer(arg0: &AppProfile) : address {
        arg0.developer
    }

    public fun github_url(arg0: &AppProfile) : 0x1::string::String {
        arg0.github_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        assert!(v0 == @0xbbc8f3deb39954974cd4556cd81579429ceb32d7a01d66570ce3d3d542c37b69, 1);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = AppProfile{
            id            : 0x2::object::new(arg0),
            app_name      : 0x1::string::utf8(b"Walrus Decentralized Image Bed"),
            developer     : @0xbbc8f3deb39954974cd4556cd81579429ceb32d7a01d66570ce3d3d542c37b69,
            website_url   : 0x1::string::utf8(b"TBD"),
            github_url    : 0x1::string::utf8(b"TBD"),
            suins_name    : 0x1::string::utf8(b"TBD"),
            app_version   : 0x1::string::utf8(b"1.0.0"),
            created_at_ms : 0,
            updated_at_ms : 0,
        };
        let v3 = AppRegistered{
            app_name       : 0x1::string::utf8(b"Walrus Decentralized Image Bed"),
            developer      : @0xbbc8f3deb39954974cd4556cd81579429ceb32d7a01d66570ce3d3d542c37b69,
            app_profile_id : 0x2::object::id<AppProfile>(&v2),
            website_url    : 0x1::string::utf8(b"TBD"),
            github_url     : 0x1::string::utf8(b"TBD"),
            suins_name     : 0x1::string::utf8(b"TBD"),
            app_version    : 0x1::string::utf8(b"1.0.0"),
        };
        0x2::event::emit<AppRegistered>(v3);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<AppProfile>(v2);
    }

    public fun suins_name(arg0: &AppProfile) : 0x1::string::String {
        arg0.suins_name
    }

    public fun update_profile(arg0: &AdminCap, arg1: &mut AppProfile, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64) {
        arg1.website_url = arg2;
        arg1.github_url = arg3;
        arg1.suins_name = arg4;
        arg1.app_version = arg5;
        arg1.updated_at_ms = arg6;
        let v0 = AppProfileUpdated{
            app_profile_id : 0x2::object::id<AppProfile>(arg1),
            developer      : arg1.developer,
            website_url    : arg1.website_url,
            github_url     : arg1.github_url,
            suins_name     : arg1.suins_name,
            app_version    : arg1.app_version,
            updated_at_ms  : arg6,
        };
        0x2::event::emit<AppProfileUpdated>(v0);
    }

    public fun website_url(arg0: &AppProfile) : 0x1::string::String {
        arg0.website_url
    }

    // decompiled from Move bytecode v7
}

