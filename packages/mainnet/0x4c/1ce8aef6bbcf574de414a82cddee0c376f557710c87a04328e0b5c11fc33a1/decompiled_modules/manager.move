module 0x4c1ce8aef6bbcf574de414a82cddee0c376f557710c87a04328e0b5c11fc33a1::manager {
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
        sid: u64,
        admin: address,
        paused: bool,
        transferable: bool,
        name: 0x1::ascii::String,
        balances: 0x2::table::Table<address, Point>,
        has_claimed: 0x2::table::Table<u64, bool>,
    }

    struct GalxeTable has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        treasurer: address,
        spaces: 0x2::table::Table<u64, SpacePoint>,
    }

    struct MintChallenge has drop {
        claim_to: address,
        amount: u64,
        sid: u64,
        dummy_id: u64,
        version: u64,
        fee: u64,
    }

    struct ActiveChallenge has drop {
        admin: address,
        sid: u64,
        space_name: 0x1::ascii::String,
        version: u64,
    }

    struct IncreasePoint has copy, drop {
        amount: u64,
        to: address,
        dummy_id: u64,
        fee: u64,
    }

    struct DecreasePoint has copy, drop {
        amount: u64,
        to: address,
        dummy_id: u64,
        fee: u64,
    }

    struct SpaceInfo has copy, drop {
        sender: address,
        sid: u64,
        admin: address,
        paused: bool,
        transferable: bool,
    }

    struct ActiveEvent has copy, drop {
        uid: 0x2::object::ID,
        sid: u64,
        admin: address,
        paused: bool,
        transferable: bool,
        space_name: 0x1::ascii::String,
    }

    struct PointTransferEvent has copy, drop {
        sid: u64,
        from: address,
        to: address,
        amount: u64,
    }

    public fun transfer(arg0: &mut GalxeTable, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, SpacePoint>(&mut arg0.spaces, arg1);
        assert!(v0.transferable, 13906835394114355205);
        let v1 = 0x2::table::borrow_mut<address, Point>(&mut v0.balances, 0x2::tx_context::sender(arg4));
        assert!(v1.owner == 0x2::tx_context::sender(arg4), 13906835406998994945);
        assert!(v1.amount >= arg3, 13906835411294617611);
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

    public fun active(arg0: &mut GalxeTable, arg1: u64, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ActiveChallenge{
            admin      : 0x2::tx_context::sender(arg4),
            sid        : arg1,
            space_name : arg2,
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
            has_claimed  : 0x2::table::new<u64, bool>(arg4),
        };
        0x2::table::add<u64, SpacePoint>(&mut arg0.spaces, arg1, v2);
        let v3 = ActiveEvent{
            uid          : 0x2::object::id<SpacePoint>(&v2),
            sid          : arg1,
            admin        : 0x2::tx_context::sender(arg4),
            paused       : false,
            transferable : false,
            space_name   : arg2,
        };
        0x2::event::emit<ActiveEvent>(v3);
    }

    fun check_permission(arg0: &SpacePoint, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0 || v0 == @0x8e5af77d009beba83288e6c9164f0f1b4dc05c2895941842eeec1677935bac20, 13906835321099649025);
    }

    fun consume_signature(arg0: &GalxeTable, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x2::hash::keccak256(arg1);
        let v1 = arg0.public_key;
        assert!(0x2::ed25519::ed25519_verify(arg2, &v1, &v0), 13906835346869977097);
    }

    public fun decreasePoint(arg0: &mut GalxeTable, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v1 = MintChallenge{
            claim_to : arg4,
            amount   : arg2,
            sid      : (arg1 as u64),
            dummy_id : (arg3 as u64),
            version  : 1,
            fee      : v0,
        };
        let v2 = 0x2::bcs::to_bytes<MintChallenge>(&v1);
        consume_signature(arg0, &v2, &arg5);
        let v3 = 0x2::table::borrow_mut<u64, SpacePoint>(&mut arg0.spaces, arg1);
        assert!(!v3.paused, 13906835222315663365);
        assert!(!0x2::table::contains<u64, bool>(&v3.has_claimed, arg3), 13906835226610499587);
        assert!(arg5 != 0x1::vector::empty<u8>(), 13906835230905729031);
        0x2::table::add<u64, bool>(&mut v3.has_claimed, arg3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasurer);
        let v4 = 0x2::table::borrow_mut<address, Point>(&mut v3.balances, arg4);
        assert!(v4.amount >= arg2, 13906835265265729547);
        v4.amount = v4.amount - arg2;
        let v5 = DecreasePoint{
            amount   : arg2,
            to       : arg4,
            dummy_id : arg3,
            fee      : v0,
        };
        0x2::event::emit<DecreasePoint>(v5);
    }

    fun emit_update_space_point_event(arg0: &SpacePoint, arg1: &0x2::tx_context::TxContext) {
        let v0 = SpaceInfo{
            sender       : 0x2::tx_context::sender(arg1),
            sid          : arg0.sid,
            admin        : arg0.admin,
            paused       : arg0.paused,
            transferable : arg0.transferable,
        };
        0x2::event::emit<SpaceInfo>(v0);
    }

    public fun get_balance(arg0: &GalxeTable, arg1: u64, arg2: address) : u64 {
        0x2::table::borrow<address, Point>(&0x2::table::borrow<u64, SpacePoint>(&arg0.spaces, arg1).balances, arg2).amount
    }

    public fun get_has_claimed(arg0: &GalxeTable, arg1: u64, arg2: u64) : bool {
        0x2::table::contains<u64, bool>(&0x2::table::borrow<u64, SpacePoint>(&arg0.spaces, arg1).has_claimed, arg2)
    }

    public fun get_space(arg0: &GalxeTable, arg1: u64) : SpaceInfo {
        let v0 = 0x2::table::borrow<u64, SpacePoint>(&arg0.spaces, arg1);
        SpaceInfo{
            sender       : v0.admin,
            sid          : v0.sid,
            admin        : v0.admin,
            paused       : v0.paused,
            transferable : v0.transferable,
        }
    }

    public fun increasePoint(arg0: &mut GalxeTable, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v1 = MintChallenge{
            claim_to : arg4,
            amount   : arg2,
            sid      : (arg1 as u64),
            dummy_id : (arg3 as u64),
            version  : 1,
            fee      : v0,
        };
        let v2 = 0x2::bcs::to_bytes<MintChallenge>(&v1);
        consume_signature(arg0, &v2, &arg5);
        let v3 = 0x2::table::borrow_mut<u64, SpacePoint>(&mut arg0.spaces, arg1);
        assert!(!v3.paused, 13906834994682396677);
        assert!(!0x2::table::contains<u64, bool>(&v3.has_claimed, arg3), 13906834998977232899);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasurer);
        0x2::table::add<u64, bool>(&mut v3.has_claimed, arg3, true);
        if (0x2::table::contains<address, Point>(&v3.balances, arg4)) {
            let v4 = 0x2::table::borrow_mut<address, Point>(&mut v3.balances, arg4);
            v4.amount = v4.amount + arg2;
        } else {
            let v5 = Point{
                id     : 0x2::object::new(arg7),
                amount : arg2,
                owner  : arg4,
            };
            0x2::table::add<address, Point>(&mut v3.balances, arg4, v5);
        };
        let v6 = IncreasePoint{
            amount   : arg2,
            to       : arg4,
            dummy_id : arg3,
            fee      : v0,
        };
        0x2::event::emit<IncreasePoint>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GalxeTable{
            id         : 0x2::object::new(arg0),
            public_key : x"8548724c5390cc9c73b4b418fc351400fdca61d043364fa8a7f0332d4121d256",
            treasurer  : @0x8e5af77d009beba83288e6c9164f0f1b4dc05c2895941842eeec1677935bac20,
            spaces     : 0x2::table::new<u64, SpacePoint>(arg0),
        };
        0x2::transfer::share_object<GalxeTable>(v1);
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

    public fun update_public_key(arg0: &mut AdminCap, arg1: &mut GalxeTable, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public fun update_transferable(arg0: &mut SpacePoint, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.transferable = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    public fun update_treasurer(arg0: &mut AdminCap, arg1: &mut GalxeTable, arg2: address) {
        arg1.treasurer = arg2;
    }

    // decompiled from Move bytecode v6
}

