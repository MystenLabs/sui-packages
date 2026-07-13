module 0x5415a2dee038c47122709496180580195f49c05ef73027cda07cd4a1b8594b44::reputation {
    struct ReputationIssuer has key {
        id: 0x2::object::UID,
        admin: address,
        issuer: address,
    }

    struct ReputationBadge has key {
        id: 0x2::object::UID,
        holder: address,
        role: u8,
        tier: u8,
        updated_ms: u64,
    }

    struct ReputationIssuerCreated has copy, drop {
        issuer_id: 0x2::object::ID,
        admin: address,
        issuer: address,
    }

    struct ReputationUpdated has copy, drop {
        badge_id: 0x2::object::ID,
        holder: address,
        role: u8,
        tier: u8,
        updated_ms: u64,
    }

    public fun badge_holder(arg0: &ReputationBadge) : address {
        arg0.holder
    }

    public fun badge_role(arg0: &ReputationBadge) : u8 {
        arg0.role
    }

    public fun badge_tier(arg0: &ReputationBadge) : u8 {
        arg0.tier
    }

    public fun badge_updated_ms(arg0: &ReputationBadge) : u64 {
        arg0.updated_ms
    }

    public fun init_reputation_issuer(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != arg1, 2);
        let v0 = ReputationIssuer{
            id     : 0x2::object::new(arg2),
            admin  : arg0,
            issuer : arg1,
        };
        let v1 = ReputationIssuerCreated{
            issuer_id : 0x2::object::id<ReputationIssuer>(&v0),
            admin     : arg0,
            issuer    : arg1,
        };
        0x2::event::emit<ReputationIssuerCreated>(v1);
        0x2::transfer::share_object<ReputationIssuer>(v0);
    }

    public fun issuer_addr(arg0: &ReputationIssuer) : address {
        arg0.issuer
    }

    public fun issuer_admin(arg0: &ReputationIssuer) : address {
        arg0.admin
    }

    public fun mint_badge(arg0: &ReputationIssuer, arg1: address, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.issuer, 0);
        assert!(arg3 <= 4, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = ReputationBadge{
            id         : 0x2::object::new(arg5),
            holder     : arg1,
            role       : arg2,
            tier       : arg3,
            updated_ms : v0,
        };
        let v2 = ReputationUpdated{
            badge_id   : 0x2::object::id<ReputationBadge>(&v1),
            holder     : arg1,
            role       : arg2,
            tier       : arg3,
            updated_ms : v0,
        };
        0x2::event::emit<ReputationUpdated>(v2);
        0x2::transfer::transfer<ReputationBadge>(v1, arg1);
    }

    public fun refresh_badge(arg0: &ReputationIssuer, arg1: ReputationBadge, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.issuer, 0);
        assert!(arg2 <= 4, 3);
        let v0 = arg1.holder;
        let v1 = arg1.role;
        let ReputationBadge {
            id         : v2,
            holder     : _,
            role       : _,
            tier       : _,
            updated_ms : _,
        } = arg1;
        0x2::object::delete(v2);
        let v7 = 0x2::clock::timestamp_ms(arg3);
        assert!(v7 > arg1.updated_ms, 4);
        let v8 = ReputationBadge{
            id         : 0x2::object::new(arg4),
            holder     : v0,
            role       : v1,
            tier       : arg2,
            updated_ms : v7,
        };
        let v9 = ReputationUpdated{
            badge_id   : 0x2::object::id<ReputationBadge>(&v8),
            holder     : v0,
            role       : v1,
            tier       : arg2,
            updated_ms : v7,
        };
        0x2::event::emit<ReputationUpdated>(v9);
        0x2::transfer::transfer<ReputationBadge>(v8, v0);
    }

    public fun role_guest() : u8 {
        0
    }

    public fun role_host() : u8 {
        1
    }

    public fun set_issuer(arg0: &mut ReputationIssuer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg0.admin != arg1, 2);
        arg0.issuer = arg1;
    }

    public fun tier_bronze() : u8 {
        1
    }

    public fun tier_for_counts(arg0: u32, arg1: u32) : u8 {
        if (arg1 > 0) {
            return 0
        };
        if (arg0 >= 15) {
            return 4
        };
        if (arg0 >= 7) {
            return 3
        };
        if (arg0 >= 3) {
            return 2
        };
        if (arg0 >= 1) {
            return 1
        };
        0
    }

    public fun tier_gold() : u8 {
        3
    }

    public fun tier_none() : u8 {
        0
    }

    public fun tier_platinum() : u8 {
        4
    }

    public fun tier_silver() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

