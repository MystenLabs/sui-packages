module 0x8c9ea919a3d54dd4fce7c5cfe62bfc08c0f68e926316871019baba50af6a1858::jellumi_badge {
    struct BadgeAdminCap has key {
        id: 0x2::object::UID,
    }

    struct BadgeConfig has key {
        id: 0x2::object::UID,
        claim_amount: u64,
        server_pubkey: vector<u8>,
        enabled: bool,
        paused: bool,
        used_nonces: 0x2::table::Table<vector<u8>, bool>,
        claimed_users: 0x2::table::Table<address, bool>,
        total_minted: u64,
        issuer: address,
        badge_name: 0x1::string::String,
        badge_description: 0x1::string::String,
        badge_image_url: 0x2::url::Url,
        badge_creator: 0x1::string::String,
    }

    struct SoulboundBadge has key {
        id: 0x2::object::UID,
        token_id: u64,
        owner: address,
        issuer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: 0x1::string::String,
        claimed_at: u64,
        amount_paid: u64,
        is_revoked: bool,
    }

    struct BadgeMinted has copy, drop {
        badge_id: 0x2::object::ID,
        token_id: u64,
        owner: address,
        issuer: address,
        claimed_at: u64,
    }

    struct BadgeRevoked has copy, drop {
        badge_id: 0x2::object::ID,
        token_id: u64,
        owner: address,
        revoked_by: address,
        reason: 0x1::string::String,
    }

    struct BadgeBurned has copy, drop {
        badge_id: 0x2::object::ID,
        token_id: u64,
        owner: address,
    }

    struct ConfigUpdated has copy, drop {
        claim_amount: u64,
        enabled: bool,
        paused: bool,
    }

    struct PubkeyRotated has copy, drop {
        old_pubkey_hash: vector<u8>,
        new_pubkey_hash: vector<u8>,
    }

    public fun admin_burn_badge(arg0: &BadgeAdminCap, arg1: SoulboundBadge) {
        let SoulboundBadge {
            id          : v0,
            token_id    : _,
            owner       : _,
            issuer      : _,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            claimed_at  : _,
            amount_paid : _,
            is_revoked  : _,
        } = arg1;
        0x2::object::delete(v0);
        let v11 = BadgeBurned{
            badge_id : 0x2::object::id<SoulboundBadge>(&arg1),
            token_id : arg1.token_id,
            owner    : arg1.owner,
        };
        0x2::event::emit<BadgeBurned>(v11);
    }

    public fun burn_badge(arg0: SoulboundBadge, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(!arg0.is_revoked, 6);
        let SoulboundBadge {
            id          : v0,
            token_id    : _,
            owner       : _,
            issuer      : _,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            claimed_at  : _,
            amount_paid : _,
            is_revoked  : _,
        } = arg0;
        0x2::object::delete(v0);
        let v11 = BadgeBurned{
            badge_id : 0x2::object::id<SoulboundBadge>(&arg0),
            token_id : arg0.token_id,
            owner    : arg0.owner,
        };
        0x2::event::emit<BadgeBurned>(v11);
    }

    public fun claim_badge(arg0: &mut BadgeConfig, arg1: &mut 0x9b9c2a0d889b75f90b3963b3c13874ce9bfd11046a4f9170b96c671431500bfb::jellumi_treasury::Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 8);
        assert!(arg0.enabled, 0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed_users, v0), 7);
        assert!(arg4 > v1, 3);
        assert!(arg4 <= v1 + 300000, 9);
        assert!(arg0.total_minted < 1000000, 10);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg3), 2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 == arg0.claim_amount, 4);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, 0x2::object::id_bytes<BadgeConfig>(arg0));
        0x1::vector::append<u8>(&mut v3, 0x2::address::to_bytes(v0));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg0.claim_amount));
        0x1::vector::append<u8>(&mut v3, arg3);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg4));
        let v4 = 0x2::hash::blake2b256(&v3);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.server_pubkey, &v4), 1);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_nonces, arg3, true);
        0x2::table::add<address, bool>(&mut arg0.claimed_users, v0, true);
        0x9b9c2a0d889b75f90b3963b3c13874ce9bfd11046a4f9170b96c671431500bfb::jellumi_treasury::deposit_simple(arg1, arg2);
        let v5 = arg0.total_minted;
        arg0.total_minted = arg0.total_minted + 1;
        let v6 = SoulboundBadge{
            id          : 0x2::object::new(arg7),
            token_id    : v5,
            owner       : v0,
            issuer      : arg0.issuer,
            name        : arg0.badge_name,
            description : arg0.badge_description,
            image_url   : arg0.badge_image_url,
            creator     : arg0.badge_creator,
            claimed_at  : v1,
            amount_paid : v2,
            is_revoked  : false,
        };
        let v7 = 0x2::object::id<SoulboundBadge>(&v6);
        let v8 = BadgeMinted{
            badge_id   : v7,
            token_id   : v5,
            owner      : v0,
            issuer     : arg0.issuer,
            claimed_at : v1,
        };
        0x2::event::emit<BadgeMinted>(v8);
        0x2::transfer::transfer<SoulboundBadge>(v6, v0);
        v7
    }

    public fun get_badge_info(arg0: &SoulboundBadge) : (u64, address, address, 0x1::string::String, 0x1::string::String, 0x2::url::Url, 0x1::string::String, u64, u64, bool, bool) {
        (arg0.token_id, arg0.owner, arg0.issuer, arg0.name, arg0.description, arg0.image_url, arg0.creator, arg0.claimed_at, arg0.amount_paid, arg0.is_revoked, true)
    }

    public fun get_claim_status(arg0: &BadgeConfig, arg1: address) : (bool, bool, u64) {
        let v0 = 0x2::table::contains<address, bool>(&arg0.claimed_users, arg1);
        let v1 = if (arg0.enabled) {
            if (!arg0.paused) {
                !v0
            } else {
                false
            }
        } else {
            false
        };
        (v1, v0, arg0.claim_amount)
    }

    public fun get_config_info(arg0: &BadgeConfig) : (u64, bool, bool, u64, address, 0x1::string::String, 0x1::string::String, 0x2::url::Url, 0x1::string::String) {
        (arg0.claim_amount, arg0.enabled, arg0.paused, arg0.total_minted, arg0.issuer, arg0.badge_name, arg0.badge_description, arg0.badge_image_url, arg0.badge_creator)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = BadgeAdminCap{id: 0x2::object::new(arg0)};
        let v2 = BadgeConfig{
            id                : 0x2::object::new(arg0),
            claim_amount      : 1000000000,
            server_pubkey     : 0x1::vector::empty<u8>(),
            enabled           : false,
            paused            : false,
            used_nonces       : 0x2::table::new<vector<u8>, bool>(arg0),
            claimed_users     : 0x2::table::new<address, bool>(arg0),
            total_minted      : 0,
            issuer            : v0,
            badge_name        : 0x1::string::utf8(b"Jelli Early Adopter"),
            badge_description : 0x1::string::utf8(b"Awarded for early participants to the Jellumi Galaxy"),
            badge_image_url   : 0x2::url::new_unsafe_from_bytes(b"https://images.jellumi.xyz/badges/early-adopter.png"),
            badge_creator     : 0x1::string::utf8(b"Jellumi Foundation"),
        };
        0x2::transfer::transfer<BadgeAdminCap>(v1, v0);
        0x2::transfer::share_object<BadgeConfig>(v2);
    }

    public fun is_locked(arg0: &SoulboundBadge) : bool {
        true
    }

    public fun is_nonce_used(arg0: &BadgeConfig, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg1)
    }

    public fun is_revoked(arg0: &SoulboundBadge) : bool {
        arg0.is_revoked
    }

    public fun revoke_badge(arg0: &BadgeAdminCap, arg1: &mut SoulboundBadge, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.is_revoked, 6);
        arg1.is_revoked = true;
        let v0 = BadgeRevoked{
            badge_id   : 0x2::object::id<SoulboundBadge>(arg1),
            token_id   : arg1.token_id,
            owner      : arg1.owner,
            revoked_by : 0x2::tx_context::sender(arg3),
            reason     : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<BadgeRevoked>(v0);
    }

    public fun set_badge_metadata(arg0: &BadgeAdminCap, arg1: &mut BadgeConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        arg1.badge_name = 0x1::string::utf8(arg2);
        arg1.badge_description = 0x1::string::utf8(arg3);
        arg1.badge_image_url = 0x2::url::new_unsafe_from_bytes(arg4);
        arg1.badge_creator = 0x1::string::utf8(arg5);
    }

    public fun set_claim_amount(arg0: &BadgeAdminCap, arg1: &mut BadgeConfig, arg2: u64) {
        arg1.claim_amount = arg2;
        let v0 = ConfigUpdated{
            claim_amount : arg2,
            enabled      : arg1.enabled,
            paused       : arg1.paused,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_enabled(arg0: &BadgeAdminCap, arg1: &mut BadgeConfig, arg2: bool) {
        if (arg2) {
            assert!(0x1::vector::length<u8>(&arg1.server_pubkey) == 32, 5);
        };
        arg1.enabled = arg2;
        let v0 = ConfigUpdated{
            claim_amount : arg1.claim_amount,
            enabled      : arg2,
            paused       : arg1.paused,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_issuer(arg0: &BadgeAdminCap, arg1: &mut BadgeConfig, arg2: address) {
        arg1.issuer = arg2;
    }

    public fun set_paused(arg0: &BadgeAdminCap, arg1: &mut BadgeConfig, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ConfigUpdated{
            claim_amount : arg1.claim_amount,
            enabled      : arg1.enabled,
            paused       : arg2,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_server_pubkey(arg0: &BadgeAdminCap, arg1: &mut BadgeConfig, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 5);
        let v0 = if (0x1::vector::length<u8>(&arg1.server_pubkey) > 0) {
            0x2::hash::blake2b256(&arg1.server_pubkey)
        } else {
            0x1::vector::empty<u8>()
        };
        arg1.server_pubkey = arg2;
        let v1 = PubkeyRotated{
            old_pubkey_hash : v0,
            new_pubkey_hash : 0x2::hash::blake2b256(&arg2),
        };
        0x2::event::emit<PubkeyRotated>(v1);
    }

    public fun transfer_admin(arg0: BadgeAdminCap, arg1: address) {
        0x2::transfer::transfer<BadgeAdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

