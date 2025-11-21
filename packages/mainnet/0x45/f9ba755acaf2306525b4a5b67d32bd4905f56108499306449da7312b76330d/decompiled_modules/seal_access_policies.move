module 0x45f9ba755acaf2306525b4a5b67d32bd4905f56108499306449da7312b76330d::seal_access_policies {
    struct SealType has copy, drop, store {
        is_public: bool,
    }

    struct AccessPolicy has store, key {
        id: 0x2::object::UID,
        entry_nft_id: 0x2::object::ID,
        owner: address,
        seal_type: SealType,
        authorized_addresses: vector<address>,
    }

    struct PolicyRegistry has key {
        id: 0x2::object::UID,
    }

    struct PolicyCreatedEvent has copy, drop {
        entry_nft_id: 0x2::object::ID,
        owner: address,
        is_public: bool,
    }

    struct AccessGrantedEvent has copy, drop {
        entry_nft_id: 0x2::object::ID,
        grantee: address,
        granted_by: address,
    }

    struct AccessRevokedEvent has copy, drop {
        entry_nft_id: 0x2::object::ID,
        grantee: address,
        revoked_by: address,
    }

    public entry fun create_policy(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: &mut PolicyRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_with_type<0x2::object::ID, AccessPolicy>(&arg3.id, arg0), 3);
        let v0 = SealType{is_public: arg2};
        let v1 = AccessPolicy{
            id                   : 0x2::object::new(arg4),
            entry_nft_id         : arg0,
            owner                : arg1,
            seal_type            : v0,
            authorized_addresses : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_field::add<0x2::object::ID, AccessPolicy>(&mut arg3.id, arg0, v1);
        let v2 = PolicyCreatedEvent{
            entry_nft_id : arg0,
            owner        : arg1,
            is_public    : arg2,
        };
        0x2::event::emit<PolicyCreatedEvent>(v2);
    }

    public fun get_authorized_addresses(arg0: 0x2::object::ID, arg1: &PolicyRegistry) : vector<address> {
        if (!0x2::dynamic_field::exists_with_type<0x2::object::ID, AccessPolicy>(&arg1.id, arg0)) {
            return 0x1::vector::empty<address>()
        };
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, AccessPolicy>(&arg1.id, arg0);
        if (v0.seal_type.is_public) {
            return 0x1::vector::empty<address>()
        };
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.authorized_addresses)) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(&v0.authorized_addresses, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_policy_owner(arg0: 0x2::object::ID, arg1: &PolicyRegistry) : address {
        if (!0x2::dynamic_field::exists_with_type<0x2::object::ID, AccessPolicy>(&arg1.id, arg0)) {
            return @0x0
        };
        0x2::dynamic_field::borrow<0x2::object::ID, AccessPolicy>(&arg1.id, arg0).owner
    }

    public entry fun grant_access(arg0: 0x2::object::ID, arg1: address, arg2: &mut PolicyRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AccessPolicy>(&mut arg2.id, arg0);
        assert!(v0 == v1.owner, 1);
        assert!(!v1.seal_type.is_public, 5);
        assert!(!0x1::vector::contains<address>(&v1.authorized_addresses, &arg1), 3);
        0x1::vector::push_back<address>(&mut v1.authorized_addresses, arg1);
        let v2 = AccessGrantedEvent{
            entry_nft_id : arg0,
            grantee      : arg1,
            granted_by   : v0,
        };
        0x2::event::emit<AccessGrantedEvent>(v2);
    }

    public fun has_access(arg0: 0x2::object::ID, arg1: address, arg2: &PolicyRegistry) : bool {
        if (!0x2::dynamic_field::exists_with_type<0x2::object::ID, AccessPolicy>(&arg2.id, arg0)) {
            return false
        };
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, AccessPolicy>(&arg2.id, arg0);
        if (v0.seal_type.is_public) {
            return true
        };
        if (arg1 == v0.owner) {
            return true
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0.authorized_addresses)) {
            if (*0x1::vector::borrow<address>(&v0.authorized_addresses, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PolicyRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PolicyRegistry>(v0);
    }

    public fun is_public_seal(arg0: 0x2::object::ID, arg1: &PolicyRegistry) : bool {
        if (!0x2::dynamic_field::exists_with_type<0x2::object::ID, AccessPolicy>(&arg1.id, arg0)) {
            return false
        };
        0x2::dynamic_field::borrow<0x2::object::ID, AccessPolicy>(&arg1.id, arg0).seal_type.is_public
    }

    public fun policy_exists(arg0: 0x2::object::ID, arg1: &PolicyRegistry) : bool {
        0x2::dynamic_field::exists_with_type<0x2::object::ID, AccessPolicy>(&arg1.id, arg0)
    }

    public entry fun revoke_access(arg0: 0x2::object::ID, arg1: address, arg2: &mut PolicyRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AccessPolicy>(&mut arg2.id, arg0);
        assert!(v0 == v1.owner, 1);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<address>(&v1.authorized_addresses)) {
            if (*0x1::vector::borrow<address>(&v1.authorized_addresses, v2) == arg1) {
                0x1::vector::remove<address>(&mut v1.authorized_addresses, v2);
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v3, 4);
        let v4 = AccessRevokedEvent{
            entry_nft_id : arg0,
            grantee      : arg1,
            revoked_by   : v0,
        };
        0x2::event::emit<AccessRevokedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

