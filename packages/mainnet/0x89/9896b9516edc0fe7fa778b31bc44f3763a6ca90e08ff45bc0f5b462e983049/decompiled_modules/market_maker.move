module 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::market_maker {
    struct MMAdminCap has store, key {
        id: 0x2::object::UID,
        market_maker_id: 0x2::object::ID,
    }

    struct MarketMaker has key {
        id: 0x2::object::UID,
        mm_name: 0x1::string::String,
        admin_cap_id: 0x2::object::ID,
        acl: 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::ACL,
        paused: bool,
        fee_override: 0x1::option::Option<u16>,
        pools: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>,
        created_at_ms: u64,
    }

    struct MmRegisteredEvent has copy, drop {
        mm_id: 0x2::object::ID,
        mm_name: 0x1::string::String,
        admin_cap_id: 0x2::object::ID,
        mm_admin_addr: address,
    }

    struct MmDeregisteredEvent has copy, drop {
        mm_id: 0x2::object::ID,
        orphaned_admin_cap_id: 0x2::object::ID,
    }

    struct MmPausedEvent has copy, drop {
        mm_id: 0x2::object::ID,
        paused: bool,
    }

    struct MmAclRoleAddedEvent has copy, drop {
        mm_id: 0x2::object::ID,
        member: address,
        role: u8,
    }

    struct MmAclRoleRemovedEvent has copy, drop {
        mm_id: 0x2::object::ID,
        member: address,
        role: u8,
    }

    struct MmAclMemberRemovedEvent has copy, drop {
        mm_id: 0x2::object::ID,
        member: address,
    }

    public fun has_role(arg0: &MarketMaker, arg1: address, arg2: u8) : bool {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::has_role(&arg0.acl, arg1, arg2)
    }

    public(friend) fun assert_not_paused(arg0: &MarketMaker) {
        assert!(!arg0.paused, 1);
    }

    public(friend) fun add_pool_id(arg0: &mut MarketMaker, arg1: 0x2::object::ID) {
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.pools, arg1), 9);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut arg0.pools, arg1, true);
    }

    public fun admin_cap_id(arg0: &MarketMaker) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    fun assert_cap_matches(arg0: &MMAdminCap, arg1: &MarketMaker) {
        assert!(arg0.market_maker_id == 0x2::object::id<MarketMaker>(arg1), 2);
    }

    public(friend) fun assert_role(arg0: &MarketMaker, arg1: address, arg2: u8) {
        assert!(0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::has_role(&arg0.acl, arg1, arg2), 3);
    }

    public fun burn(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: MMAdminCap, arg2: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::Registry) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert!(!0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::contains_mm(arg2, arg1.market_maker_id), 8);
        let MMAdminCap {
            id              : v0,
            market_maker_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun contains_pool(arg0: &MarketMaker, arg1: 0x2::object::ID) : bool {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.pools, arg1)
    }

    public fun created_at_ms(arg0: &MarketMaker) : u64 {
        arg0.created_at_ms
    }

    public fun deregister_mm(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::admin_cap::SuperAdminCap, arg2: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::Registry, arg3: MarketMaker) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, bool>(&arg3.pools) == 0, 4);
        let v0 = 0x2::object::id<MarketMaker>(&arg3);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::remove_mm(arg2, v0);
        let v1 = MmDeregisteredEvent{
            mm_id                 : v0,
            orphaned_admin_cap_id : arg3.admin_cap_id,
        };
        0x2::event::emit<MmDeregisteredEvent>(v1);
        let MarketMaker {
            id            : v2,
            mm_name       : _,
            admin_cap_id  : _,
            acl           : v5,
            paused        : _,
            fee_override  : _,
            pools         : v8,
            created_at_ms : _,
        } = arg3;
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::destroy_acl(v5);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::drop<0x2::object::ID, bool>(v8);
        0x2::object::delete(v2);
    }

    public fun fee_override(arg0: &MarketMaker) : &0x1::option::Option<u16> {
        &arg0.fee_override
    }

    public fun market_maker_id(arg0: &MMAdminCap) : 0x2::object::ID {
        arg0.market_maker_id
    }

    public fun mm_acl_add_role(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &MMAdminCap, arg2: &mut MarketMaker, arg3: address, arg4: u8) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_cap_matches(arg1, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::add_role(&mut arg2.acl, arg3, arg4);
        let v0 = MmAclRoleAddedEvent{
            mm_id  : 0x2::object::id<MarketMaker>(arg2),
            member : arg3,
            role   : arg4,
        };
        0x2::event::emit<MmAclRoleAddedEvent>(v0);
    }

    public fun mm_acl_remove_member(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &MMAdminCap, arg2: &mut MarketMaker, arg3: address) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_cap_matches(arg1, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::remove_member(&mut arg2.acl, arg3);
        let v0 = MmAclMemberRemovedEvent{
            mm_id  : 0x2::object::id<MarketMaker>(arg2),
            member : arg3,
        };
        0x2::event::emit<MmAclMemberRemovedEvent>(v0);
    }

    public fun mm_acl_remove_role(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &MMAdminCap, arg2: &mut MarketMaker, arg3: address, arg4: u8) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_cap_matches(arg1, arg2);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::remove_role(&mut arg2.acl, arg3, arg4);
        let v0 = MmAclRoleRemovedEvent{
            mm_id  : 0x2::object::id<MarketMaker>(arg2),
            member : arg3,
            role   : arg4,
        };
        0x2::event::emit<MmAclRoleRemovedEvent>(v0);
    }

    public fun mm_name(arg0: &MarketMaker) : &0x1::string::String {
        &arg0.mm_name
    }

    public fun pause_mm(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut MarketMaker, arg2: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_role(arg1, 0x2::tx_context::sender(arg2), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_pauser());
        arg1.paused = true;
        let v0 = MmPausedEvent{
            mm_id  : 0x2::object::id<MarketMaker>(arg1),
            paused : true,
        };
        0x2::event::emit<MmPausedEvent>(v0);
    }

    public fun paused(arg0: &MarketMaker) : bool {
        arg0.paused
    }

    public fun pool_count(arg0: &MarketMaker) : u64 {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, bool>(&arg0.pools)
    }

    public fun register_mm(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::GlobalConfig, arg2: &mut 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::Registry, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_not_paused(arg1);
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::config::assert_mm_registrar(arg1, 0x2::tx_context::sender(arg6));
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = MMAdminCap{
            id              : 0x2::object::new(arg6),
            market_maker_id : v1,
        };
        let v3 = 0x2::object::id<MMAdminCap>(&v2);
        let v4 = MarketMaker{
            id            : v0,
            mm_name       : arg3,
            admin_cap_id  : v3,
            acl           : 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::acl::new(arg6),
            paused        : false,
            fee_override  : 0x1::option::none<u16>(),
            pools         : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg6),
            created_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::registry::add_mm(arg2, v1);
        let v5 = MmRegisteredEvent{
            mm_id         : v1,
            mm_name       : v4.mm_name,
            admin_cap_id  : v3,
            mm_admin_addr : arg4,
        };
        0x2::event::emit<MmRegisteredEvent>(v5);
        0x2::transfer::public_transfer<MMAdminCap>(v2, arg4);
        0x2::transfer::share_object<MarketMaker>(v4);
    }

    public(friend) fun remove_pool_id(arg0: &mut MarketMaker, arg1: 0x2::object::ID) {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.pools, arg1), 7);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, bool>(&mut arg0.pools, arg1);
    }

    public(friend) fun set_fee_override(arg0: &mut MarketMaker, arg1: 0x1::option::Option<u16>) {
        arg0.fee_override = arg1;
    }

    public fun unpause_mm(arg0: &0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::Versioned, arg1: &mut MarketMaker, arg2: &0x2::tx_context::TxContext) {
        0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::versioned::check_version(arg0);
        assert_role(arg1, 0x2::tx_context::sender(arg2), 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles::mm_role_pause_recovery());
        arg1.paused = false;
        let v0 = MmPausedEvent{
            mm_id  : 0x2::object::id<MarketMaker>(arg1),
            paused : false,
        };
        0x2::event::emit<MmPausedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

