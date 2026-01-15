module 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_registry {
    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct BadgeMinted has copy, drop {
        registry_id: 0x2::object::ID,
        source_id: 0x1::string::String,
        recipient: address,
        badge_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct BadgeRevoked has copy, drop {
        registry_id: 0x2::object::ID,
        badge_id: 0x2::object::ID,
    }

    struct TradingEnabled has copy, drop {
        registry_id: 0x2::object::ID,
        badge_id: 0x2::object::ID,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct BadgeRegistry has key {
        id: 0x2::object::UID,
        mints: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        badge_details: 0x2::table::Table<0x2::object::ID, BadgeDetails>,
        admin_addresses: 0x2::vec_set::VecSet<address>,
        total_minted: u64,
    }

    struct BadgeDetails has drop, store {
        revoked: bool,
        tradeable: bool,
    }

    struct BADGE_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun admin_cap_registry_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun create_registry(arg0: &SuperAdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = BadgeRegistry{
            id              : 0x2::object::new(arg1),
            mints           : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            badge_details   : 0x2::table::new<0x2::object::ID, BadgeDetails>(arg1),
            admin_addresses : 0x2::vec_set::empty<address>(),
            total_minted    : 0,
        };
        let v1 = 0x2::object::id<BadgeRegistry>(&v0);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg1),
            registry_id : v1,
        };
        let v3 = RegistryCreated{
            registry_id  : v1,
            admin_cap_id : 0x2::object::id<AdminCap>(&v2),
        };
        0x2::event::emit<RegistryCreated>(v3);
        0x2::transfer::share_object<BadgeRegistry>(v0);
        v2
    }

    public fun enable_trading(arg0: &0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::Version, arg1: &mut BadgeRegistry, arg2: &AdminCap, arg3: 0x2::object::ID) {
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::check(arg0);
        assert!(arg2.registry_id == 0x2::object::id<BadgeRegistry>(arg1), 0);
        assert!(0x2::table::contains<0x2::object::ID, BadgeDetails>(&arg1.badge_details, arg3), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, BadgeDetails>(&mut arg1.badge_details, arg3);
        assert!(!v0.revoked, 3);
        v0.tradeable = true;
        let v1 = TradingEnabled{
            registry_id : 0x2::object::id<BadgeRegistry>(arg1),
            badge_id    : arg3,
        };
        0x2::event::emit<TradingEnabled>(v1);
    }

    public fun get_badge_id(arg0: &BadgeRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.mints, arg1)
    }

    fun init(arg0: BADGE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_minted(arg0: &BadgeRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.mints, arg1)
    }

    public fun is_tradeable(arg0: &BadgeRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, BadgeDetails>(&arg0.badge_details, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, BadgeDetails>(&arg0.badge_details, arg1);
        !v0.revoked && v0.tradeable
    }

    public fun is_valid(arg0: &BadgeRegistry, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, BadgeDetails>(&arg0.badge_details, arg1)) {
            return false
        };
        !0x2::table::borrow<0x2::object::ID, BadgeDetails>(&arg0.badge_details, arg1).revoked
    }

    public fun mint_badge_to_kiosk(arg0: &0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::Version, arg1: &mut BadgeRegistry, arg2: &AdminCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>, arg5: 0x1::string::String, arg6: address, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u8, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::check(arg0);
        assert!(arg2.registry_id == 0x2::object::id<BadgeRegistry>(arg1), 0);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.mints, arg5), 1);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg3), 5);
        assert!(0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_extension::is_installed(arg3), 4);
        let v0 = 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::mint(0x2::object::id<BadgeRegistry>(arg1), arg7, arg8, arg9, arg5, arg10, arg11, arg12);
        let v1 = 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::id(&v0);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.mints, arg5, v1);
        let v2 = BadgeDetails{
            revoked   : false,
            tradeable : false,
        };
        0x2::table::add<0x2::object::ID, BadgeDetails>(&mut arg1.badge_details, v1, v2);
        arg1.total_minted = arg1.total_minted + 1;
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_extension::lock(arg3, v0, arg4);
        let v3 = BadgeMinted{
            registry_id : 0x2::object::id<BadgeRegistry>(arg1),
            source_id   : arg5,
            recipient   : arg6,
            badge_id    : v1,
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
        };
        0x2::event::emit<BadgeMinted>(v3);
    }

    public fun mint_badge_with_kiosk(arg0: &0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::Version, arg1: &mut BadgeRegistry, arg2: &AdminCap, arg3: &0x2::transfer_policy::TransferPolicy<0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::Badge>, arg4: 0x1::string::String, arg5: address, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u8, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::check(arg0);
        assert!(arg2.registry_id == 0x2::object::id<BadgeRegistry>(arg1), 0);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.mints, arg4), 1);
        let (v0, v1) = 0x2::kiosk::new(arg11);
        let v2 = v1;
        let v3 = v0;
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_extension::add_with_cap(&mut v3, &v2, arg11);
        let v4 = 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::mint(0x2::object::id<BadgeRegistry>(arg1), arg6, arg7, arg8, arg4, arg9, arg10, arg11);
        let v5 = 0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge::id(&v4);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.mints, arg4, v5);
        let v6 = BadgeDetails{
            revoked   : false,
            tradeable : false,
        };
        0x2::table::add<0x2::object::ID, BadgeDetails>(&mut arg1.badge_details, v5, v6);
        arg1.total_minted = arg1.total_minted + 1;
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::badge_extension::lock(&mut v3, v4, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v3, v2, arg5, arg11);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        let v7 = BadgeMinted{
            registry_id : 0x2::object::id<BadgeRegistry>(arg1),
            source_id   : arg4,
            recipient   : arg5,
            badge_id    : v5,
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
        };
        0x2::event::emit<BadgeMinted>(v7);
    }

    public fun revoke_badge(arg0: &0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::Version, arg1: &mut BadgeRegistry, arg2: &AdminCap, arg3: 0x2::object::ID) {
        0x684d769da54c85ee004fe07d4be8ae248886d4db69353979be87e995d6130b76::version::check(arg0);
        assert!(arg2.registry_id == 0x2::object::id<BadgeRegistry>(arg1), 0);
        assert!(0x2::table::contains<0x2::object::ID, BadgeDetails>(&arg1.badge_details, arg3), 2);
        0x2::table::borrow_mut<0x2::object::ID, BadgeDetails>(&mut arg1.badge_details, arg3).revoked = true;
        let v0 = BadgeRevoked{
            registry_id : 0x2::object::id<BadgeRegistry>(arg1),
            badge_id    : arg3,
        };
        0x2::event::emit<BadgeRevoked>(v0);
    }

    public fun total_minted(arg0: &BadgeRegistry) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v6
}

