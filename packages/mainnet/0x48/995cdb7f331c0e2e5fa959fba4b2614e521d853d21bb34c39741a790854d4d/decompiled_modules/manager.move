module 0x48995cdb7f331c0e2e5fa959fba4b2614e521d853d21bb34c39741a790854d4d::manager {
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
        minters: vector<address>,
    }

    struct GalxeTable has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        treasurer: address,
    }

    struct MintChallenge has drop {
        claim_to: address,
        amount: u64,
        sid: u64,
        dummy_id: u64,
        version: u64,
        fee: u64,
    }

    struct MintChallenges has drop {
        users: vector<address>,
        amounts: vector<u64>,
        sid: u64,
        dummy_ids: vector<u64>,
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

    struct IncreasePoints has copy, drop {
        amounts: vector<u64>,
        users: vector<address>,
        dummy_ids: vector<u64>,
        sid: u64,
        sender: address,
        fee: u64,
    }

    struct DecreasePoints has copy, drop {
        amounts: vector<u64>,
        users: vector<address>,
        dummy_ids: vector<u64>,
        sid: u64,
        sender: address,
        fee: u64,
    }

    struct SpaceInfo has copy, drop {
        sender: address,
        sid: u64,
        admin: address,
        paused: bool,
        transferable: bool,
        minters: vector<address>,
        name: 0x1::ascii::String,
    }

    struct ActiveEvent has copy, drop {
        uid: address,
        sid: u64,
        admin: address,
        paused: bool,
        transferable: bool,
        space_name: 0x1::ascii::String,
        minters: vector<address>,
    }

    struct PointTransferEvent has copy, drop {
        sid: u64,
        from: address,
        to: address,
        amount: u64,
    }

    entry fun transfer(arg0: &mut SpacePoint, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.transferable, 13906835437064028165);
        let v0 = 0x2::table::borrow_mut<address, Point>(&mut arg0.balances, 0x2::tx_context::sender(arg3));
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 13906835449948667905);
        assert!(v0.amount >= arg2, 13906835454244290571);
        v0.amount = v0.amount - arg2;
        let v1 = &mut arg0.balances;
        add_point(v1, arg1, arg2, arg3);
        let v2 = PointTransferEvent{
            sid    : arg0.sid,
            from   : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<PointTransferEvent>(v2);
    }

    public fun active(arg0: &mut GalxeTable, arg1: u64, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ActiveChallenge{
            admin      : 0x2::tx_context::sender(arg4),
            sid        : arg1,
            space_name : arg2,
            version    : 0,
        };
        let v1 = 0x2::bcs::to_bytes<ActiveChallenge>(&v0);
        consume_signature(arg0, &v1, &arg3);
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, 0x2::tx_context::sender(arg4));
        let v4 = SpacePoint{
            id           : v2,
            sid          : arg1,
            admin        : 0x2::tx_context::sender(arg4),
            paused       : false,
            transferable : false,
            name         : arg2,
            balances     : 0x2::table::new<address, Point>(arg4),
            has_claimed  : 0x2::table::new<u64, bool>(arg4),
            minters      : v3,
        };
        0x2::transfer::share_object<SpacePoint>(v4);
        let v5 = ActiveEvent{
            uid          : 0x2::object::uid_to_address(&v2),
            sid          : arg1,
            admin        : 0x2::tx_context::sender(arg4),
            paused       : false,
            transferable : false,
            space_name   : arg2,
            minters      : v3,
        };
        0x2::event::emit<ActiveEvent>(v5);
    }

    entry fun add_minter(arg0: &mut SpacePoint, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.minters, arg1);
    }

    fun add_point(arg0: &mut 0x2::table::Table<address, Point>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, Point>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Point>(arg0, arg1);
            v0.amount = v0.amount + arg2;
        } else {
            let v1 = Point{
                id     : 0x2::object::new(arg3),
                amount : arg2,
                owner  : arg1,
            };
            0x2::table::add<address, Point>(arg0, arg1, v1);
        };
    }

    entry fun balance_of(arg0: &SpacePoint, arg1: address) : u64 {
        0x2::table::borrow<address, Point>(&arg0.balances, arg1).amount
    }

    fun check_permission(arg0: &SpacePoint, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0 || v0 == @0x945150d87519d70ac7392b4c04d3e8c0bdb2ebf814ba1259cf22b0d0e91bb3a5, 13906836227337748481);
    }

    fun consume_signature(arg0: &GalxeTable, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x2::hash::keccak256(arg1);
        let v1 = arg0.public_key;
        assert!(0x2::ed25519::ed25519_verify(arg2, &v1, &v0), 13906836253108076553);
    }

    entry fun decreasePoint(arg0: &GalxeTable, arg1: &mut SpacePoint, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        if (!is_minter(arg1, 0x2::tx_context::sender(arg7))) {
            let v1 = MintChallenge{
                claim_to : arg4,
                amount   : arg2,
                sid      : arg1.sid,
                dummy_id : (arg3 as u64),
                version  : 0,
                fee      : v0,
            };
            let v2 = 0x2::bcs::to_bytes<MintChallenge>(&v1);
            consume_signature(arg0, &v2, &arg5);
        };
        assert!(!arg1.paused, 13906835342574747653);
        assert!(!0x2::table::contains<u64, bool>(&arg1.has_claimed, arg3), 13906835346869583875);
        assert!(arg5 != 0x1::vector::empty<u8>(), 13906835351164813319);
        0x2::table::add<u64, bool>(&mut arg1.has_claimed, arg3, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasurer);
        let v3 = 0x2::table::borrow_mut<address, Point>(&mut arg1.balances, arg4);
        assert!(v3.amount >= arg2, 13906835385524813835);
        v3.amount = v3.amount - arg2;
        let v4 = DecreasePoint{
            amount   : arg2,
            to       : arg4,
            dummy_id : arg3,
            fee      : v0,
        };
        0x2::event::emit<DecreasePoint>(v4);
    }

    entry fun decreasePoints(arg0: &GalxeTable, arg1: &mut SpacePoint, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<address>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 13906836034064482309);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        if (!is_minter(arg1, 0x2::tx_context::sender(arg7))) {
            let v1 = MintChallenges{
                users     : arg4,
                amounts   : arg2,
                sid       : arg1.sid,
                dummy_ids : arg3,
                version   : 0,
                fee       : v0,
            };
            let v2 = 0x2::bcs::to_bytes<MintChallenges>(&v1);
            consume_signature(arg0, &v2, &arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasurer);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg2)) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            0x2::table::add<u64, bool>(&mut arg1.has_claimed, *0x1::vector::borrow<u64>(&arg3, v3), true);
            let v5 = 0x2::table::borrow_mut<address, Point>(&mut arg1.balances, *0x1::vector::borrow<address>(&arg4, v3));
            assert!(v5.amount >= v4, 13906836145734025227);
            v5.amount = v5.amount - v4;
            v3 = v3 + 1;
        };
        let v6 = DecreasePoints{
            amounts   : arg2,
            users     : arg4,
            dummy_ids : arg3,
            sid       : arg1.sid,
            sender    : 0x2::tx_context::sender(arg7),
            fee       : v0,
        };
        0x2::event::emit<DecreasePoints>(v6);
    }

    fun emit_update_space_point_event(arg0: &SpacePoint, arg1: &0x2::tx_context::TxContext) {
        let v0 = SpaceInfo{
            sender       : 0x2::tx_context::sender(arg1),
            sid          : arg0.sid,
            admin        : arg0.admin,
            paused       : arg0.paused,
            transferable : arg0.transferable,
            minters      : arg0.minters,
            name         : arg0.name,
        };
        0x2::event::emit<SpaceInfo>(v0);
    }

    public entry fun get_space(arg0: &SpacePoint) : SpaceInfo {
        SpaceInfo{
            sender       : arg0.admin,
            sid          : arg0.sid,
            admin        : arg0.admin,
            paused       : arg0.paused,
            transferable : arg0.transferable,
            minters      : arg0.minters,
            name         : arg0.name,
        }
    }

    public entry fun has_claimed(arg0: &SpacePoint, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.has_claimed, arg1)
    }

    entry fun increasePoint(arg0: &GalxeTable, arg1: &mut SpacePoint, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        if (!0x1::vector::contains<address>(&arg1.minters, &v1)) {
            let v2 = MintChallenge{
                claim_to : arg4,
                amount   : arg2,
                sid      : arg1.sid,
                dummy_id : (arg3 as u64),
                version  : 0,
                fee      : v0,
            };
            let v3 = 0x2::bcs::to_bytes<MintChallenge>(&v2);
            consume_signature(arg0, &v3, &arg5);
        };
        assert!(!arg1.paused, 13906835166481088517);
        assert!(!0x2::table::contains<u64, bool>(&arg1.has_claimed, arg3), 13906835170775924739);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasurer);
        0x2::table::add<u64, bool>(&mut arg1.has_claimed, arg3, true);
        let v4 = &mut arg1.balances;
        add_point(v4, arg4, arg2, arg7);
        let v5 = IncreasePoint{
            amount   : arg2,
            to       : arg4,
            dummy_id : arg3,
            fee      : v0,
        };
        0x2::event::emit<IncreasePoint>(v5);
    }

    entry fun increasePoints(arg0: &GalxeTable, arg1: &mut SpacePoint, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<address>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 13906835819316117509);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        if (!0x1::vector::contains<address>(&arg1.minters, &v1)) {
            let v2 = MintChallenges{
                users     : arg4,
                amounts   : arg2,
                sid       : arg1.sid,
                dummy_ids : arg3,
                version   : 0,
                fee       : v0,
            };
            let v3 = 0x2::bcs::to_bytes<MintChallenges>(&v2);
            consume_signature(arg0, &v3, &arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.treasurer);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg2)) {
            0x2::table::add<u64, bool>(&mut arg1.has_claimed, *0x1::vector::borrow<u64>(&arg3, v4), true);
            let v5 = &mut arg1.balances;
            add_point(v5, *0x1::vector::borrow<address>(&arg4, v4), *0x1::vector::borrow<u64>(&arg2, v4), arg7);
            v4 = v4 + 1;
        };
        let v6 = IncreasePoints{
            amounts   : arg2,
            users     : arg4,
            dummy_ids : arg3,
            sid       : arg1.sid,
            sender    : 0x2::tx_context::sender(arg7),
            fee       : v0,
        };
        0x2::event::emit<IncreasePoints>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GalxeTable{
            id         : 0x2::object::new(arg0),
            public_key : x"cb03e66922db33468bb2be36080edff9622327ec0fa05fd2c6056ac2752bd794",
            treasurer  : @0x945150d87519d70ac7392b4c04d3e8c0bdb2ebf814ba1259cf22b0d0e91bb3a5,
        };
        0x2::transfer::share_object<GalxeTable>(v1);
    }

    public entry fun is_minter(arg0: &SpacePoint, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.minters, &arg1)
    }

    entry fun remove_minter(arg0: &mut SpacePoint, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        let (_, v1) = 0x1::vector::index_of<address>(&arg0.minters, &arg1);
        0x1::vector::remove<address>(&mut arg0.minters, (v1 as u64));
    }

    entry fun update_admin(arg0: &mut SpacePoint, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.admin = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    entry fun update_name(arg0: &mut SpacePoint, arg1: 0x1::ascii::String, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.name = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    entry fun update_pause(arg0: &mut SpacePoint, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.paused = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    entry fun update_public_key(arg0: &mut AdminCap, arg1: &mut GalxeTable, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    entry fun update_transferable(arg0: &mut SpacePoint, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_permission(arg0, arg2);
        arg0.transferable = arg1;
        emit_update_space_point_event(arg0, arg2);
    }

    entry fun update_treasurer(arg0: &mut AdminCap, arg1: &mut GalxeTable, arg2: address) {
        arg1.treasurer = arg2;
    }

    // decompiled from Move bytecode v6
}

