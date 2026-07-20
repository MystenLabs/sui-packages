module 0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::protocol_member {
    struct ProtocolWalletWhitelistUpdated has copy, drop {
        wallets: vector<address>,
        whitelisted: bool,
    }

    struct ProtocolMemberCreated has copy, drop {
        protocol_member_id: 0x2::object::ID,
        wallet: address,
        publication_ids: vector<0x2::object::ID>,
        permissions_scope: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::MemberPermission>,
        expires_at: u64,
    }

    struct ProtocolMemberDeleted has copy, drop {
        protocol_member_id: 0x2::object::ID,
    }

    struct ProtocolWalletWhitelist has key {
        id: 0x2::object::UID,
        whitelisted_wallets: 0x2::table::Table<address, bool>,
    }

    struct ProtocolWalletWhitelistCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolMember has key {
        id: 0x2::object::UID,
        publication_ids: vector<0x2::object::ID>,
        permissions_scope: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::MemberPermission>,
        expires_at: u64,
    }

    public fun assert_valid_for_publication(arg0: &ProtocolMember, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(arg0.expires_at > 0x2::clock::timestamp_ms(arg2) / 1000, 3);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.publication_ids, &arg1), 4);
    }

    public fun create_protocol_member(arg0: &ProtocolWalletWhitelist, arg1: vector<0x2::object::ID>, arg2: vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::MemberPermission>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 1 && arg3 <= 900, 1);
        assert!(is_protocol_wallet_whitelisted(arg0, 0x2::tx_context::sender(arg5)), 2);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000 + arg3;
        let v1 = ProtocolMember{
            id                : 0x2::object::new(arg5),
            publication_ids   : arg1,
            permissions_scope : arg2,
            expires_at        : v0,
        };
        let v2 = ProtocolMemberCreated{
            protocol_member_id : 0x2::object::id<ProtocolMember>(&v1),
            wallet             : 0x2::tx_context::sender(arg5),
            publication_ids    : arg1,
            permissions_scope  : arg2,
            expires_at         : v0,
        };
        0x2::event::emit<ProtocolMemberCreated>(v2);
        0x2::transfer::transfer<ProtocolMember>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun delete_protocol_member(arg0: ProtocolMember) {
        let ProtocolMember {
            id                : v0,
            publication_ids   : _,
            permissions_scope : _,
            expires_at        : _,
        } = arg0;
        let v4 = v0;
        let v5 = ProtocolMemberDeleted{protocol_member_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<ProtocolMemberDeleted>(v5);
        0x2::object::delete(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolWalletWhitelist{
            id                  : 0x2::object::new(arg0),
            whitelisted_wallets : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = ProtocolWalletWhitelistCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ProtocolWalletWhitelist>(v0);
        0x2::transfer::transfer<ProtocolWalletWhitelistCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_protocol_member_valid_for_publication(arg0: &ProtocolMember, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        arg0.expires_at > 0x2::clock::timestamp_ms(arg2) / 1000 && 0x1::vector::contains<0x2::object::ID>(&arg0.publication_ids, &arg1)
    }

    public fun is_protocol_wallet_whitelisted(arg0: &ProtocolWalletWhitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted_wallets, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelisted_wallets, arg1)
    }

    public fun protocol_member_expires_at(arg0: &ProtocolMember) : u64 {
        arg0.expires_at
    }

    public fun protocol_member_id(arg0: &ProtocolMember) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun protocol_member_permissions_scope(arg0: &ProtocolMember) : vector<0xc46e18cb6d2e0d1846037f14161376af3dc997bbc47491893ad87d5ccb0878a::member_permission::MemberPermission> {
        arg0.permissions_scope
    }

    public fun protocol_member_publication_ids(arg0: &ProtocolMember) : vector<0x2::object::ID> {
        arg0.publication_ids
    }

    public fun protocol_wallet_whitelist_cap_id(arg0: &ProtocolWalletWhitelistCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun protocol_wallet_whitelist_id(arg0: &ProtocolWalletWhitelist) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun set_protocol_wallet_whitelisted(arg0: &mut ProtocolWalletWhitelist, arg1: &ProtocolWalletWhitelistCap, arg2: vector<address>, arg3: bool) {
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (arg3) {
                if (0x2::table::contains<address, bool>(&arg0.whitelisted_wallets, v1)) {
                    *0x2::table::borrow_mut<address, bool>(&mut arg0.whitelisted_wallets, v1) = true;
                } else {
                    0x2::table::add<address, bool>(&mut arg0.whitelisted_wallets, v1, true);
                };
            } else if (0x2::table::contains<address, bool>(&arg0.whitelisted_wallets, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.whitelisted_wallets, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        let v2 = ProtocolWalletWhitelistUpdated{
            wallets     : arg2,
            whitelisted : arg3,
        };
        0x2::event::emit<ProtocolWalletWhitelistUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

