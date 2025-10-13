module 0xf4499cde8aa865c64cb9a85f528e909a906bb3f78e95bd0fe3a620ef556c76be::seal_authority {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SealAuthorityCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapsBag has key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct SealViewerCap has key {
        id: 0x2::object::UID,
        sealed_for: 0x1::option::Option<0x2::object::ID>,
    }

    struct SealAuthorityCapIssuedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct SealAuthorityCapRevokedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct SealViewerCapIssuedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
        viewer_address: address,
        sealed_for: 0x1::option::Option<0x2::object::ID>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OperatorCapsBag{
            id   : 0x2::object::new(arg0),
            caps : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::share_object<OperatorCapsBag>(v1);
    }

    public(friend) fun is_authorized_cap(arg0: &SealAuthorityCap, arg1: &OperatorCapsBag) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<SealAuthorityCap>(arg0)), 2);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<SealAuthorityCap>(arg0)), 3);
    }

    entry fun issue_authority_cap(arg0: &AdminCap, arg1: &mut OperatorCapsBag, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SealAuthorityCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<SealAuthorityCap>(&v0);
        0x2::transfer::public_transfer<SealAuthorityCap>(v0, arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.caps, v1, true);
        let v2 = SealAuthorityCapIssuedEvent{
            cap_id    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SealAuthorityCapIssuedEvent>(v2);
    }

    entry fun issue_viewer_cap(arg0: &AdminCap, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SealViewerCap{
            id         : 0x2::object::new(arg4),
            sealed_for : arg2,
        };
        0x2::transfer::transfer<SealViewerCap>(v0, 0x2::tx_context::sender(arg4));
        let v1 = SealViewerCapIssuedEvent{
            cap_id         : 0x2::object::id<SealViewerCap>(&v0),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
            viewer_address : arg1,
            sealed_for     : arg2,
        };
        0x2::event::emit<SealViewerCapIssuedEvent>(v1);
    }

    entry fun revoke_authority_cap(arg0: &AdminCap, arg1: &mut OperatorCapsBag, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, arg3), 1);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.caps, arg3) = false;
        let v0 = SealAuthorityCapRevokedEvent{
            cap_id    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SealAuthorityCapRevokedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

