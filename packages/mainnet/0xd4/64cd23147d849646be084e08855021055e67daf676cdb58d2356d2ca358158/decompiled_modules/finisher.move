module 0xd464cd23147d849646be084e08855021055e67daf676cdb58d2356d2ca358158::finisher {
    struct FINISHER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry: 0x1::option::Option<0x2::object::ID>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        campaign: 0x1::string::String,
        key: vector<u8>,
        image_url: 0x1::string::String,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct Finisher has key {
        id: 0x2::object::UID,
        holder: address,
        campaign: 0x1::string::String,
        claimed_at: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Authorization has drop {
        domain: 0x1::string::String,
        registry: 0x2::object::ID,
        campaign: 0x1::string::String,
        holder: address,
        nonce: vector<u8>,
        expires: u64,
    }

    struct Claimed has copy, drop {
        registry: 0x2::object::ID,
        holder: address,
        object_id: 0x2::object::ID,
        campaign: 0x1::string::String,
        nonce: vector<u8>,
        claimed_at: u64,
    }

    public fun claim(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        verify(arg0, v0, arg2, arg3, &arg4, v1);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        let v2 = make_trophy(arg0, v0, v1, arg5);
        let v3 = Claimed{
            registry   : 0x2::object::id<Registry>(arg0),
            holder     : v0,
            object_id  : 0x2::object::id<Finisher>(&v2),
            campaign   : arg0.campaign,
            nonce      : arg2,
            claimed_at : v1,
        };
        0x2::event::emit<Claimed>(v3);
        0x2::transfer::transfer<Finisher>(v2, v0);
    }

    public fun configure(arg0: &mut AdminCap, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_none<0x2::object::ID>(&arg0.registry)) {
            if (0x1::vector::length<u8>(&arg1) == 32) {
                !0x1::string::is_empty(&arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = Registry{
            id        : 0x2::object::new(arg4),
            campaign  : arg2,
            key       : arg1,
            image_url : arg3,
            claimed   : 0x2::table::new<address, bool>(arg4),
        };
        0x1::option::fill<0x2::object::ID>(&mut arg0.registry, 0x2::object::id<Registry>(&v1));
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun create_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<Finisher>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<Finisher>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<Finisher>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<Finisher>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display_registry::set<Finisher>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://sling69.themanifestmovement.xyz"));
        0x2::display_registry::set<Finisher>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://sling69.themanifestmovement.xyz/profile/{holder}"));
        0x2::display_registry::share<Finisher>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<Finisher>>(v2, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: FINISHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<FINISHER>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AdminCap{
            id       : 0x2::object::new(arg1),
            registry : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun make_trophy(arg0: &Registry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Finisher {
        Finisher{
            id          : 0x2::object::new(arg3),
            holder      : arg1,
            campaign    : arg0.campaign,
            claimed_at  : arg2,
            name        : 0x1::string::utf8(b"SLING69 Completion Trophy"),
            description : 0x1::string::utf8(b"Completed all 69 server-validated Ranked courses. A nontransferable digital achievement. No financial reward."),
            image_url   : arg0.image_url,
        }
    }

    public fun rotate_authorizer(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>) {
        let v0 = 0x2::object::id<Registry>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.registry, &v0) && 0x1::vector::length<u8>(&arg2) == 32, 4);
        arg1.key = arg2;
    }

    fun verify(arg0: &Registry, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &vector<u8>, arg5: u64) {
        assert!(arg3 >= arg5 && arg3 - arg5 <= 600000, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, arg1), 2);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0);
        let v0 = Authorization{
            domain   : 0x1::string::utf8(b"SLING69_FINISHER_V1_SUI_MAINNET"),
            registry : 0x2::object::id<Registry>(arg0),
            campaign : arg0.campaign,
            holder   : arg1,
            nonce    : arg2,
            expires  : arg3,
        };
        let v1 = 0x1::bcs::to_bytes<Authorization>(&v0);
        assert!(0x2::ed25519::ed25519_verify(arg4, &arg0.key, &v1), 0);
    }

    // decompiled from Move bytecode v7
}

