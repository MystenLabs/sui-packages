module 0x4aaeef8a5a4de6d5eb8a3877767a561edeb28db32e5ef75a2b3b4f16d65e334c::manager {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Point has store, key {
        id: 0x2::object::UID,
        amount: u64,
        owner: address,
    }

    struct SpacePoint has store, key {
        id: 0x2::object::UID,
        sid: u256,
        admin: address,
        paused: bool,
        transferable: bool,
        name: 0x1::string::String,
        balances: 0x2::table::Table<address, Point>,
        has_claimed: 0x2::table::Table<u256, bool>,
    }

    struct GalxeTable has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        treasurer: address,
        spaces: 0x2::table::Table<u256, SpacePoint>,
    }

    struct MintChallenge has drop {
        claim_to: address,
        sid: u256,
        dummy_id: u256,
        version: u64,
    }

    struct ActiveChallenge has drop {
        sid: u256,
        space_name: 0x1::string::String,
        admin: address,
        version: u64,
    }

    struct IncreasePoint has copy, drop {
        amount: u64,
        to: address,
        dummy_id: u256,
    }

    struct DecreasePoint has copy, drop {
        amount: u64,
        to: address,
        dummy_id: u256,
    }

    struct UpdateSpacePointEvent has copy, drop {
        sender: address,
        sid: u256,
        admin: address,
        paused: bool,
        transferable: bool,
    }

    struct SpaceActiveEvent has copy, drop {
        sid: u256,
        admin: address,
        paused: bool,
        transferable: bool,
    }

    struct PointTransferEvent has copy, drop {
        sid: u256,
        from: address,
        to: address,
        amount: u64,
    }

    public fun transfer(arg0: &mut GalxeTable, arg1: u256, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u256, SpacePoint>(&mut arg0.spaces, arg1);
        assert!(v0.transferable, 13906835385524420613);
        let v1 = 0x2::table::borrow_mut<address, Point>(&mut v0.balances, 0x2::tx_context::sender(arg4));
        assert!(v1.owner == 0x2::tx_context::sender(arg4), 13906835398409060353);
        assert!(v1.amount >= arg3, 13906835402704814093);
        v1.amount = v1.amount - arg3;
        if (0x2::table::contains<address, Point>(&v0.balances, arg2)) {
            let v2 = 0x2::table::borrow_mut<address, Point>(&mut v0.balances, arg2);
            v2.amount = v2.amount + arg3;
        } else {
            let v3 = Point{
                id     : 0x2::object::new(arg4),
                amount : arg3,
                owner  : arg2,
            };
            0x2::table::add<address, Point>(&mut v0.balances, arg2, v3);
        };
        let v4 = PointTransferEvent{
            sid    : arg1,
            from   : 0x2::tx_context::sender(arg4),
            to     : arg2,
            amount : arg3,
        };
        0x2::event::emit<PointTransferEvent>(v4);
    }

    public fun active(arg0: &mut GalxeTable, arg1: u256, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ActiveChallenge{
            sid        : arg1,
            space_name : arg2,
            admin      : 0x2::tx_context::sender(arg4),
            version    : 1,
        };
        let v1 = 0x2::bcs::to_bytes<ActiveChallenge>(&v0);
        consume_signature(arg0, &v1, &arg3);
        let v2 = SpacePoint{
            id           : 0x2::object::new(arg4),
            sid          : arg1,
            admin        : 0x2::tx_context::sender(arg4),
            paused       : false,
            transferable : false,
            name         : arg2,
            balances     : 0x2::table::new<address, Point>(arg4),
            has_claimed  : 0x2::table::new<u256, bool>(arg4),
        };
        0x2::table::add<u256, SpacePoint>(&mut arg0.spaces, arg1, v2);
        let v3 = SpaceActiveEvent{
            sid          : arg1,
            admin        : 0x2::tx_context::sender(arg4),
            paused       : false,
            transferable : false,
        };
        0x2::event::emit<SpaceActiveEvent>(v3);
    }

    public fun burn(arg0: &mut GalxeTable, arg1: u256, arg2: address, arg3: u64, arg4: u256, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u256, SpacePoint>(&mut arg0.spaces, arg1);
        check_permission(v0, arg5);
        let v1 = 0x2::table::borrow_mut<address, Point>(&mut v0.balances, arg2);
        assert!(v1.amount >= arg3, 13906835308215533581);
        v1.amount = v1.amount - arg3;
        let v2 = DecreasePoint{
            amount   : arg3,
            to       : arg2,
            dummy_id : arg4,
        };
        0x2::event::emit<DecreasePoint>(v2);
    }

    fun check_permission(arg0: &SpacePoint, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0 || v0 == @0x8e5af77d009beba83288e6c9164f0f1b4dc05c2895941842eeec1677935bac20, 13906835089171415041);
    }

    fun consume_signature(arg0: &GalxeTable, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x2::hash::keccak256(arg1);
        let v1 = arg0.public_key;
        assert!(arg2 != &v0 && v1 != 0x1::vector::empty<u8>(), 13906835114941874187);
        assert!(0x2::ed25519::ed25519_verify(arg2, &v1, &v0), 13906835119236841483);
    }

    fun emit_update_space_point_event(arg0: &SpacePoint, arg1: &0x2::tx_context::TxContext) {
        let v0 = UpdateSpacePointEvent{
            sender       : 0x2::tx_context::sender(arg1),
            sid          : arg0.sid,
            admin        : arg0.admin,
            paused       : arg0.paused,
            transferable : arg0.transferable,
        };
        0x2::event::emit<UpdateSpacePointEvent>(v0);
    }

    public fun get_point(arg0: &GalxeTable, arg1: u256, arg2: address) : u64 {
        0x2::table::borrow<address, Point>(&0x2::table::borrow<u256, SpacePoint>(&arg0.spaces, arg1).balances, arg2).amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GalxeTable{
            id         : 0x2::object::new(arg0),
            public_key : x"8548724c5390cc9c73b4b418fc351400fdca61d043364fa8a7f0332d4121d256",
            treasurer  : @0x8e5af77d009beba83288e6c9164f0f1b4dc05c2895941842eeec1677935bac20,
            spaces     : 0x2::table::new<u256, SpacePoint>(arg0),
        };
        0x2::transfer::share_object<GalxeTable>(v1);
    }

    fun insert_all(arg0: &mut 0x2::table::Table<address, Point>, arg1: &vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 < 0x1::vector::length<address>(arg1)) {
            let v0 = *0x1::vector::borrow<address>(arg1, arg2);
            let v1 = Point{
                id     : 0x2::object::new(arg3),
                amount : arg2,
                owner  : v0,
            };
            0x2::table::add<address, Point>(arg0, v0, v1);
            insert_all(arg0, arg1, arg2 + 1, arg3);
        };
    }

    public fun mint(arg0: &mut GalxeTable, arg1: u256, arg2: u64, arg3: u256, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = MintChallenge{
            claim_to : arg4,
            sid      : arg1,
            dummy_id : arg3,
            version  : 1,
        };
        let v1 = 0x2::bcs::to_bytes<MintChallenge>(&v0);
        consume_signature(arg0, &v1, &arg5);
        let v2 = 0x2::table::borrow_mut<u256, SpacePoint>(&mut arg0.spaces, arg1);
        assert!(!v2.paused, 13906834947437756421);
        assert!(!0x2::table::contains<u256, bool>(&v2.has_claimed, arg3), 13906834951732592643);
        assert!(arg5 != 0x1::vector::empty<u8>(), 13906834956027953161);
        0x2::table::add<u256, bool>(&mut v2.has_claimed, arg3, true);
        if (0x2::table::contains<address, Point>(&v2.balances, arg4)) {
            let v3 = 0x2::table::borrow_mut<address, Point>(&mut v2.balances, arg4);
            v3.amount = v3.amount + arg2;
        } else {
            let v4 = Point{
                id     : 0x2::object::new(arg6),
                amount : arg2,
                owner  : arg4,
            };
            0x2::table::add<address, Point>(&mut v2.balances, arg4, v4);
        };
        let v5 = IncreasePoint{
            amount   : arg2,
            to       : arg4,
            dummy_id : arg3,
        };
        0x2::event::emit<IncreasePoint>(v5);
    }

    public fun tableTest(arg0: &mut GalxeTable, arg1: u256, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut 0x2::table::borrow_mut<u256, SpacePoint>(&mut arg0.spaces, arg1).balances;
        insert_all(v0, &arg2, 0, arg3);
    }

    public fun update_admin(arg0: &mut SpacePoint, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.admin = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    public fun update_pause(arg0: &mut SpacePoint, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.paused = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    public fun update_transferable(arg0: &mut SpacePoint, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.transferable = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

