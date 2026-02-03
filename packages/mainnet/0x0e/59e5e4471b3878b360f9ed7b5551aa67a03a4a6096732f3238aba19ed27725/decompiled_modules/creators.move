module 0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators {
    struct CREATORS has drop {
        dummy_field: bool,
    }

    struct Creators has store, key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, 0x2::object::ID>,
        blacklist: 0x2::table::Table<address, 0x2::object::ID>,
        codes: 0x2::table::Table<0x1::string::String, address>,
    }

    struct Creator has store, key {
        id: 0x2::object::UID,
        creator: address,
        joined: u64,
        active: bool,
    }

    struct CreatorJoinedEvent has copy, drop {
        creator_id: 0x2::object::ID,
        creator_address: address,
        timestamp: u64,
    }

    struct CreatorBlacklistedEvent has copy, drop {
        creator_id: 0x2::object::ID,
        creator_address: address,
        timestamp: u64,
    }

    struct CreatorRewhitelistedEvent has copy, drop {
        creator_id: 0x2::object::ID,
        creator_address: address,
        timestamp: u64,
    }

    struct ReferralCodeRegisteredEvent has copy, drop {
        code: 0x1::string::String,
        creator_address: address,
        timestamp: u64,
    }

    public fun admin_create_creators(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg1);
        let v0 = Creators{
            id        : 0x2::object::new(arg1),
            whitelist : 0x2::table::new<address, 0x2::object::ID>(arg1),
            blacklist : 0x2::table::new<address, 0x2::object::ID>(arg1),
            codes     : 0x2::table::new<0x1::string::String, address>(arg1),
        };
        0x2::transfer::public_share_object<Creators>(v0);
    }

    public fun admin_destroy_creators(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: Creators, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        let Creators {
            id        : v0,
            whitelist : v1,
            blacklist : v2,
            codes     : v3,
        } = arg1;
        0x2::table::drop<address, 0x2::object::ID>(v1);
        0x2::table::drop<address, 0x2::object::ID>(v2);
        0x2::table::drop<0x1::string::String, address>(v3);
        0x2::object::delete(v0);
    }

    public fun admin_whitelist_creator(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Creators, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        let v0 = Creator{
            id      : 0x2::object::new(arg4),
            creator : arg2,
            joined  : 0,
            active  : true,
        };
        let v1 = 0x2::object::id<Creator>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.whitelist, arg2, v1);
        0x2::transfer::public_transfer<Creator>(v0, arg2);
        let v2 = CreatorJoinedEvent{
            creator_id      : v1,
            creator_address : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CreatorJoinedEvent>(v2);
    }

    public fun blacklist_creator(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Creators, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.whitelist, arg2), 0);
        let v0 = 0x2::table::remove<address, 0x2::object::ID>(&mut arg1.whitelist, arg2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.blacklist, arg2, v0);
        let v1 = CreatorBlacklistedEvent{
            creator_id      : v0,
            creator_address : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CreatorBlacklistedEvent>(v1);
    }

    public fun burn_creator(arg0: Creator) {
        let Creator {
            id      : v0,
            creator : _,
            joined  : _,
            active  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_creator(arg0: &Creators, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.whitelist, arg1)
    }

    public fun get_active(arg0: &Creator) : bool {
        arg0.active
    }

    public fun get_creator_address(arg0: &Creator) : address {
        arg0.creator
    }

    public fun get_joined(arg0: &Creator) : u64 {
        arg0.joined
    }

    fun init(arg0: CREATORS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CREATORS>(arg0, arg1);
        let v1 = 0x2::display::new<Creator>(&v0, arg1);
        0x2::display::add<Creator>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Voultron Creator"));
        0x2::display::add<Creator>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://voultron.fun"));
        0x2::display::add<Creator>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/Xv2KS1iAlsIsCUIQjMcXDCuFi3ci0bVXPivvX4Dx-IQ"));
        0x2::display::update_version<Creator>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Creator>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun register_referral_code(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Creators, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg5);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.whitelist, arg3), 0);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg1.codes, arg2), 1);
        0x2::table::add<0x1::string::String, address>(&mut arg1.codes, arg2, arg3);
        let v0 = ReferralCodeRegisteredEvent{
            code            : arg2,
            creator_address : arg3,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ReferralCodeRegisteredEvent>(v0);
    }

    public fun resolve_code(arg0: &Creators, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.codes, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.codes, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun rewhitelist_creator(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Creators, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.blacklist, arg2), 0);
        let v0 = 0x2::table::remove<address, 0x2::object::ID>(&mut arg1.blacklist, arg2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.whitelist, arg2, v0);
        let v1 = CreatorRewhitelistedEvent{
            creator_id      : v0,
            creator_address : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CreatorRewhitelistedEvent>(v1);
    }

    public fun update_display_blob_id(arg0: &mut 0x2::display::Display<Creator>, arg1: &mut 0x1::string::String, arg2: 0x1::string::String) {
        0x1::string::append(arg1, arg2);
        0x2::display::edit<Creator>(arg0, 0x1::string::utf8(b"image_url"), *arg1);
        0x2::display::update_version<Creator>(arg0);
    }

    public fun update_image_url(arg0: &mut 0x2::display::Display<Creator>, arg1: 0x1::string::String) {
        0x2::display::edit<Creator>(arg0, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Creator>(arg0);
    }

    // decompiled from Move bytecode v6
}

