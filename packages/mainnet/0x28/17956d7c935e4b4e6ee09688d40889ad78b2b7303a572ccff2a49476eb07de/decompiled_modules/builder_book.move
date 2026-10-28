module 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::builder_book {
    struct BuilderRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ApprovalKey has copy, drop, store {
        account_id: 0x2::object::ID,
        builder_id: u32,
    }

    struct Builder has drop, store {
        code: vector<u8>,
        payout: address,
        owner: address,
        status: u8,
        fee_bps: u16,
        self_serve: bool,
        revoke_open: bool,
        creator: address,
    }

    struct BuilderRegistry has store, key {
        id: 0x2::object::UID,
        next_id: u32,
        builders: 0x2::table::Table<u32, Builder>,
        by_code: 0x2::table::Table<vector<u8>, u32>,
        by_owner: 0x2::table::Table<address, vector<u32>>,
        created: 0x2::table::Table<address, u64>,
        reserved: 0x2::table::Table<vector<u8>, bool>,
        approvals: 0x2::table::Table<ApprovalKey, u16>,
        pending: 0x2::table::Table<address, u64>,
    }

    fun borrow(arg0: &0x2::object::UID, arg1: u32) : &Builder {
        0x2::table::borrow<u32, Builder>(&book(arg0).builders, arg1)
    }

    public fun active(arg0: &0x2::object::UID, arg1: u32) : bool {
        borrow(arg0, arg1).status == 0
    }

    public fun add_pending(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64) {
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg1)) {
            0x2::table::add<address, u64>(&mut v0.pending, arg1, arg2);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.pending, arg1);
            *v1 = *v1 + arg2;
        };
    }

    public fun approve(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u32, arg3: u16) {
        assert!(arg3 > 0, 13835059416787124230);
        assert_fee(arg3);
        let v0 = book_mut(arg0);
        let v1 = ApprovalKey{
            account_id : arg1,
            builder_id : arg2,
        };
        if (0x2::table::contains<ApprovalKey, u16>(&v0.approvals, v1)) {
            *0x2::table::borrow_mut<ApprovalKey, u16>(&mut v0.approvals, v1) = arg3;
        } else {
            0x2::table::add<ApprovalKey, u16>(&mut v0.approvals, v1, arg3);
        };
    }

    public fun approved_max(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: u32) : 0x1::option::Option<u16> {
        let v0 = book(arg0);
        let v1 = ApprovalKey{
            account_id : arg1,
            builder_id : arg2,
        };
        if (!0x2::table::contains<ApprovalKey, u16>(&v0.approvals, v1)) {
            0x1::option::none<u16>()
        } else {
            0x1::option::some<u16>(*0x2::table::borrow<ApprovalKey, u16>(&v0.approvals, v1))
        }
    }

    fun assert_fee(arg0: u16) {
        assert!((arg0 as u64) <= 100, 13835059670190194694);
    }

    public fun assign_owner(arg0: &mut 0x2::object::UID, arg1: u32, arg2: address) {
        assert!(arg2 != @0x0, 13835622190647148554);
        let v0 = book_mut(arg0);
        let v1 = 0x2::table::borrow<u32, Builder>(&v0.builders, arg1).owner;
        if (v1 == arg2) {
            return
        };
        detach_owner(v0, v1, arg1);
        attach_owner(v0, arg2, arg1);
        0x2::table::borrow_mut<u32, Builder>(&mut v0.builders, arg1).owner = arg2;
    }

    public fun attach(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BuilderRegistryKey{dummy_field: false};
        let v1 = BuilderRegistry{
            id        : 0x2::object::new(arg1),
            next_id   : 1,
            builders  : 0x2::table::new<u32, Builder>(arg1),
            by_code   : 0x2::table::new<vector<u8>, u32>(arg1),
            by_owner  : 0x2::table::new<address, vector<u32>>(arg1),
            created   : 0x2::table::new<address, u64>(arg1),
            reserved  : 0x2::table::new<vector<u8>, bool>(arg1),
            approvals : 0x2::table::new<ApprovalKey, u16>(arg1),
            pending   : 0x2::table::new<address, u64>(arg1),
        };
        0x2::dynamic_object_field::add<BuilderRegistryKey, BuilderRegistry>(arg0, v0, v1);
    }

    fun attach_owner(arg0: &mut BuilderRegistry, arg1: address, arg2: u32) {
        if (!0x2::table::contains<address, vector<u32>>(&arg0.by_owner, arg1)) {
            let v0 = 0x1::vector::empty<u32>();
            0x1::vector::push_back<u32>(&mut v0, arg2);
            0x2::table::add<address, vector<u32>>(&mut arg0.by_owner, arg1, v0);
        } else {
            0x1::vector::push_back<u32>(0x2::table::borrow_mut<address, vector<u32>>(&mut arg0.by_owner, arg1), arg2);
        };
    }

    fun book(arg0: &0x2::object::UID) : &BuilderRegistry {
        let v0 = BuilderRegistryKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<BuilderRegistryKey, BuilderRegistry>(arg0, v0)
    }

    fun book_mut(arg0: &mut 0x2::object::UID) : &mut BuilderRegistry {
        let v0 = BuilderRegistryKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BuilderRegistryKey, BuilderRegistry>(arg0, v0)
    }

    public fun code(arg0: &0x2::object::UID, arg1: u32) : vector<u8> {
        borrow(arg0, arg1).code
    }

    public fun code_ok(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= 1 && v0 <= 32
    }

    public fun code_reserved(arg0: &0x2::object::UID, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&book(arg0).reserved, *arg1)
    }

    public fun code_taken(arg0: &0x2::object::UID, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u32>(&book(arg0).by_code, *arg1)
    }

    public fun creator(arg0: &0x2::object::UID, arg1: u32) : address {
        borrow(arg0, arg1).creator
    }

    fun detach_owner(arg0: &mut BuilderRegistry, arg1: address, arg2: u32) {
        if (!0x2::table::contains<address, vector<u32>>(&arg0.by_owner, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<u32>>(&mut arg0.by_owner, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(v0)) {
            if (*0x1::vector::borrow<u32>(v0, v1) == arg2) {
                0x1::vector::remove<u32>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public fun exists(arg0: &0x2::object::UID, arg1: u32) : bool {
        0x2::table::contains<u32, Builder>(&book(arg0).builders, arg1)
    }

    public fun fee_bps(arg0: &0x2::object::UID, arg1: u32) : u16 {
        borrow(arg0, arg1).fee_bps
    }

    public fun id_for_code(arg0: &0x2::object::UID, arg1: &vector<u8>) : 0x1::option::Option<u32> {
        let v0 = book(arg0);
        if (!0x2::table::contains<vector<u8>, u32>(&v0.by_code, *arg1)) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(*0x2::table::borrow<vector<u8>, u32>(&v0.by_code, *arg1))
        }
    }

    public fun on_top_fee(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg1 >= 10000) {
            return arg0
        };
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        if (v0 > arg0) {
            arg0
        } else {
            v0
        }
    }

    public fun owner(arg0: &0x2::object::UID, arg1: u32) : address {
        borrow(arg0, arg1).owner
    }

    public fun payout(arg0: &0x2::object::UID, arg1: u32) : address {
        borrow(arg0, arg1).payout
    }

    public fun payouts_revoked(arg0: &0x2::object::UID, arg1: u32) : bool {
        if (!exists(arg0, arg1)) {
            return false
        };
        let v0 = borrow(arg0, arg1);
        v0.status == 3 || v0.status == 2 && v0.revoke_open
    }

    public fun pending(arg0: &0x2::object::UID, arg1: address) : u64 {
        let v0 = book(arg0);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&v0.pending, arg1)
        }
    }

    public fun register(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: address, arg3: address, arg4: u16, arg5: bool) : u32 {
        assert!(code_ok(&arg1), 13835903197472555020);
        assert!(arg2 != @0x0 && arg3 != @0x0, 13835621726790680586);
        assert_fee(arg4);
        let v0 = book_mut(arg0);
        let v1 = v0.next_id;
        v0.next_id = v1 + 1;
        let v2 = Builder{
            code        : arg1,
            payout      : arg2,
            owner       : arg3,
            status      : 0,
            fee_bps     : arg4,
            self_serve  : arg5,
            revoke_open : false,
            creator     : arg3,
        };
        0x2::table::add<u32, Builder>(&mut v0.builders, v1, v2);
        if (arg5) {
            if (!0x2::table::contains<address, u64>(&v0.created, arg3)) {
                0x2::table::add<address, u64>(&mut v0.created, arg3, 1);
            } else {
                let v3 = 0x2::table::borrow_mut<address, u64>(&mut v0.created, arg3);
                *v3 = *v3 + 1;
            };
        };
        0x2::table::add<vector<u8>, u32>(&mut v0.by_code, arg1, v1);
        attach_owner(v0, arg3, v1);
        v1
    }

    public fun release_code(arg0: &mut 0x2::object::UID, arg1: vector<u8>) {
        let v0 = book_mut(arg0);
        if (0x2::table::contains<vector<u8>, bool>(&v0.reserved, arg1)) {
            0x2::table::remove<vector<u8>, bool>(&mut v0.reserved, arg1);
        };
    }

    public fun reserve(arg0: &mut 0x2::object::UID, arg1: vector<u8>) {
        assert!(code_ok(&arg1), 13835903747228368908);
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<vector<u8>, bool>(&v0.reserved, arg1)) {
            0x2::table::add<vector<u8>, bool>(&mut v0.reserved, arg1, true);
        };
    }

    public fun revoke_approval(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u32) : bool {
        let v0 = book_mut(arg0);
        let v1 = ApprovalKey{
            account_id : arg1,
            builder_id : arg2,
        };
        if (!0x2::table::contains<ApprovalKey, u16>(&v0.approvals, v1)) {
            return false
        };
        0x2::table::remove<ApprovalKey, u16>(&mut v0.approvals, v1);
        true
    }

    public fun revoke_open(arg0: &0x2::object::UID, arg1: u32) : bool {
        borrow(arg0, arg1).revoke_open
    }

    public fun self_serve(arg0: &0x2::object::UID, arg1: u32) : bool {
        borrow(arg0, arg1).self_serve
    }

    public fun self_serve_code_ok(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 < 3 || v0 > 32) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = v2 >= 48 && v2 <= 57;
            let v4 = v2 >= 97 && v2 <= 122;
            let v5 = if (!v3) {
                if (!v4) {
                    if (v2 != 95) {
                        v2 != 45
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun self_serve_count(arg0: &0x2::object::UID, arg1: address) : u64 {
        let v0 = book(arg0);
        if (!0x2::table::contains<address, u64>(&v0.created, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&v0.created, arg1)
        }
    }

    public fun set_fee(arg0: &mut 0x2::object::UID, arg1: u32, arg2: u16) {
        assert_fee(arg2);
        0x2::table::borrow_mut<u32, Builder>(&mut book_mut(arg0).builders, arg1).fee_bps = arg2;
    }

    public fun set_payout(arg0: &mut 0x2::object::UID, arg1: u32, arg2: address) {
        assert!(arg2 != @0x0, 13835622246481723402);
        0x2::table::borrow_mut<u32, Builder>(&mut book_mut(arg0).builders, arg1).payout = arg2;
    }

    public fun set_revoke_open(arg0: &mut 0x2::object::UID, arg1: u32, arg2: bool) {
        0x2::table::borrow_mut<u32, Builder>(&mut book_mut(arg0).builders, arg1).revoke_open = arg2;
    }

    public fun set_status(arg0: &mut 0x2::object::UID, arg1: u32, arg2: u8) {
        assert!(arg2 <= 2, 13835340651245797384);
        let v0 = book_mut(arg0);
        assert!(0x2::table::borrow<u32, Builder>(&v0.builders, arg1).status != 3, 13836185089061224462);
        0x2::table::borrow_mut<u32, Builder>(&mut v0.builders, arg1).status = arg2;
    }

    public fun status(arg0: &0x2::object::UID, arg1: u32) : u8 {
        borrow(arg0, arg1).status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_admin_suspended() : u8 {
        2
    }

    public fun status_owner_paused() : u8 {
        1
    }

    public fun status_tombstoned() : u8 {
        3
    }

    public fun take_pending(arg0: &mut 0x2::object::UID, arg1: address) : u64 {
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg1)) {
            return 0
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.pending, arg1);
        *v1 = 0;
        *v1
    }

    public fun tombstone(arg0: &mut 0x2::object::UID, arg1: u32) {
        let v0 = book_mut(arg0);
        let v1 = 0x2::table::borrow<u32, Builder>(&v0.builders, arg1).code;
        assert!(0x2::table::borrow<u32, Builder>(&v0.builders, arg1).status != 3, 13836184938737369102);
        0x2::table::borrow_mut<u32, Builder>(&mut v0.builders, arg1).status = 3;
        0x2::table::borrow_mut<u32, Builder>(&mut v0.builders, arg1).revoke_open = true;
        let v2 = if (0x2::table::contains<vector<u8>, u32>(&v0.by_code, v1)) {
            *0x2::table::borrow<vector<u8>, u32>(&v0.by_code, v1)
        } else {
            0
        };
        if (v2 == arg1) {
            0x2::table::remove<vector<u8>, u32>(&mut v0.by_code, v1);
        };
        let v3 = 0x2::table::borrow<u32, Builder>(&v0.builders, arg1).owner;
        detach_owner(v0, v3, arg1);
        if (0x2::table::borrow<u32, Builder>(&v0.builders, arg1).self_serve) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut v0.created, 0x2::table::borrow<u32, Builder>(&v0.builders, arg1).creator);
            *v4 = *v4 - 1;
        };
    }

    public fun tombstoned(arg0: &0x2::object::UID, arg1: u32) : bool {
        exists(arg0, arg1) && borrow(arg0, arg1).status == 3
    }

    // decompiled from Move bytecode v7
}

