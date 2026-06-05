module 0xd1ed457cb4f1bb209c09a094f772472db15c115a29eb5995b7cb2a2313227896::event_01_gift {
    struct Gift has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        edition: u64,
    }

    struct GiftAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCounter has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        minted: u64,
        claimed: 0x2::table::Table<address, bool>,
        end_ms: u64,
    }

    struct EVENT_01_GIFT has drop {
        dummy_field: bool,
    }

    struct GiftMinted has copy, drop {
        edition: u64,
        recipient: address,
    }

    fun assert_active(arg0: &MintCounter, arg1: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 3);
        assert!(!arg0.paused, 4);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.end_ms, 6);
    }

    public entry fun burn_admin_cap(arg0: GiftAdminCap) {
        let GiftAdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun end_ms(arg0: &MintCounter) : u64 {
        arg0.end_ms
    }

    public fun has_claimed(arg0: &MintCounter, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    fun init(arg0: EVENT_01_GIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EVENT_01_GIFT>(arg0, arg1);
        let v1 = 0x2::display::new<Gift>(&v0, arg1);
        0x2::display::add<Gift>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{edition}"));
        0x2::display::add<Gift>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Gift>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Gift>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://conssswars.com/"));
        0x2::display::add<Gift>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"ConsssLab"));
        0x2::display::update_version<Gift>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Gift>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = GiftAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<GiftAdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = MintCounter{
            id      : 0x2::object::new(arg1),
            version : 1,
            paused  : false,
            minted  : 0,
            claimed : 0x2::table::new<address, bool>(arg1),
            end_ms  : 1782863999000,
        };
        0x2::transfer::share_object<MintCounter>(v3);
    }

    public fun is_paused(arg0: &MintCounter) : bool {
        arg0.paused
    }

    public entry fun migrate(arg0: &GiftAdminCap, arg1: &mut MintCounter) {
        assert!(arg1.version < 1, 5);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut MintCounter, arg1: &0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::Chronicle, arg2: &0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::Chronicle, arg3: &0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::Chronicle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 1);
        let v1 = if (0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::player(arg1) == v0) {
            if (0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::player(arg2) == v0) {
                0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::player(arg3) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
        let v2 = 0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::battle_id(arg1);
        let v3 = 0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::battle_id(arg2);
        let v4 = 0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::battle_id(arg3);
        let v5 = if (v2 != v3) {
            if (v2 != v4) {
                v3 != v4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 2);
        let v6 = if (v2 >= 1) {
            if (v2 <= 3) {
                if (v3 >= 1) {
                    if (v3 <= 3) {
                        if (v4 >= 1) {
                            v4 <= 3
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 8);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.minted = arg0.minted + 1;
        let v7 = arg0.minted;
        let v8 = Gift{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(b"ConSSS Wars - 1st Gift"),
            description : 0x1::string::utf8(b"Official limited-time event reward of ConSSS Wars: Echoes of Chainoa. A treasure chest opened by the heroes of Chainoa."),
            image_url   : 0x1::string::utf8(b"https://raw.githubusercontent.com/ConsssLab/public-assets/main/consss-first-gift/consss-1st-gift.png"),
            edition     : v7,
        };
        let v9 = GiftMinted{
            edition   : v7,
            recipient : v0,
        };
        0x2::event::emit<GiftMinted>(v9);
        0x2::transfer::public_transfer<Gift>(v8, v0);
    }

    public entry fun set_end_ms(arg0: &GiftAdminCap, arg1: &mut MintCounter, arg2: u64) {
        assert!(arg1.version == 1, 3);
        arg1.end_ms = arg2;
    }

    public entry fun set_paused(arg0: &GiftAdminCap, arg1: &mut MintCounter, arg2: bool) {
        assert!(arg1.version == 1, 3);
        arg1.paused = arg2;
    }

    public fun total_minted(arg0: &MintCounter) : u64 {
        arg0.minted
    }

    public fun version(arg0: &MintCounter) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

