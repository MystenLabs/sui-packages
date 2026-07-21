module 0x157f90abc99771e97ac12de9d319a868e978c3cad6d17f18f97bd6da1df3b3c2::core {
    struct RouteKey has copy, drop, store {
        chain: vector<u8>,
        asset: vector<u8>,
    }

    struct AssetInfo has store {
        symbol: vector<u8>,
        swaplock_asset_id: u64,
        precision: u8,
        source_decimals: u8,
        scale: u256,
        max_withdrawal: u64,
        status: u8,
    }

    struct RouteConfig has store {
        per_withdrawal_cap: u64,
        threshold_amount: u64,
        min_below: u64,
        min_above: u64,
    }

    struct Attestation has store {
        route: RouteKey,
        withdrawal_id: vector<u8>,
        amount: u64,
        message: vector<u8>,
        attestors: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct PendingWithdrawal has store {
        route: RouteKey,
        amount: u64,
        message: vector<u8>,
    }

    struct BridgeCore has key {
        id: 0x2::object::UID,
        routes: 0x2::table::Table<RouteKey, RouteConfig>,
        attestations: 0x2::table::Table<vector<u8>, Attestation>,
        used_deposits: 0x2::table::Table<vector<u8>, bool>,
        withdrawals: 0x2::table::Table<vector<u8>, PendingWithdrawal>,
        used_withdrawals: 0x2::table::Table<vector<u8>, bool>,
        route_set: 0x2::vec_set::VecSet<RouteKey>,
        assets: 0x2::table::Table<RouteKey, AssetInfo>,
        assets_by_id: 0x2::table::Table<u64, RouteKey>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
        route: RouteKey,
    }

    struct ReserveCap has store, key {
        id: 0x2::object::UID,
        route: RouteKey,
    }

    public fun asset_info(arg0: &BridgeCore, arg1: vector<u8>, arg2: vector<u8>) : (vector<u8>, u64, u8, u8, u256, u64, u8) {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        let v1 = 0x2::table::borrow<RouteKey, AssetInfo>(&arg0.assets, v0);
        (v1.symbol, v1.swaplock_asset_id, v1.precision, v1.source_decimals, v1.scale, v1.max_withdrawal, v1.status)
    }

    public fun asset_is_active(arg0: &BridgeCore, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        0x2::table::contains<RouteKey, AssetInfo>(&arg0.assets, v0) && 0x2::table::borrow<RouteKey, AssetInfo>(&arg0.assets, v0).status == 1
    }

    public fun asset_scale(arg0: &BridgeCore, arg1: vector<u8>, arg2: vector<u8>) : u256 {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        0x2::table::borrow<RouteKey, AssetInfo>(&arg0.assets, v0).scale
    }

    public fun asset_status_active() : u8 {
        1
    }

    public fun asset_status_frozen() : u8 {
        2
    }

    public fun asset_status_pending() : u8 {
        0
    }

    public fun attestation_count(arg0: &BridgeCore, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, Attestation>(&arg0.attestations, arg1)) {
            0x2::vec_set::size<0x2::object::ID>(&0x2::table::borrow<vector<u8>, Attestation>(&arg0.attestations, arg1).attestors)
        } else {
            0
        }
    }

    public fun confirm_asset_active(arg0: &mut BridgeCore, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        let v0 = RouteKey{
            chain : arg2,
            asset : arg3,
        };
        assert!(0x2::table::contains<RouteKey, AssetInfo>(&arg0.assets, v0), 10);
        assert!(!0x2::table::contains<u64, RouteKey>(&arg0.assets_by_id, arg4), 9);
        let v1 = 0x2::table::borrow_mut<RouteKey, AssetInfo>(&mut arg0.assets, v0);
        assert!(v1.status == 0, 11);
        v1.swaplock_asset_id = arg4;
        v1.status = 1;
        0x2::table::add<u64, RouteKey>(&mut arg0.assets_by_id, arg4, v0);
    }

    public fun consume_withdrawal(arg0: &mut BridgeCore, arg1: &ReserveCap, arg2: vector<u8>) : (u64, vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, PendingWithdrawal>(&arg0.withdrawals, arg2), 3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_withdrawals, arg2), 2);
        let PendingWithdrawal {
            route   : v0,
            amount  : v1,
            message : v2,
        } = 0x2::table::remove<vector<u8>, PendingWithdrawal>(&mut arg0.withdrawals, arg2);
        assert!(v0 == arg1.route, 6);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_withdrawals, arg2, true);
        (v1, v2)
    }

    public fun deposit_used(arg0: &BridgeCore, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_deposits, arg1)
    }

    public fun freeze_asset(arg0: &mut BridgeCore, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = RouteKey{
            chain : arg2,
            asset : arg3,
        };
        assert!(0x2::table::contains<RouteKey, AssetInfo>(&arg0.assets, v0), 10);
        0x2::table::borrow_mut<RouteKey, AssetInfo>(&mut arg0.assets, v0).status = 2;
    }

    public fun has_asset(arg0: &BridgeCore, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        0x2::table::contains<RouteKey, AssetInfo>(&arg0.assets, v0)
    }

    public fun has_asset_by_id(arg0: &BridgeCore, arg1: u64) : bool {
        0x2::table::contains<u64, RouteKey>(&arg0.assets_by_id, arg1)
    }

    public fun has_route(arg0: &BridgeCore, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        0x2::vec_set::contains<RouteKey>(&arg0.route_set, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeCore{
            id               : 0x2::object::new(arg0),
            routes           : 0x2::table::new<RouteKey, RouteConfig>(arg0),
            attestations     : 0x2::table::new<vector<u8>, Attestation>(arg0),
            used_deposits    : 0x2::table::new<vector<u8>, bool>(arg0),
            withdrawals      : 0x2::table::new<vector<u8>, PendingWithdrawal>(arg0),
            used_withdrawals : 0x2::table::new<vector<u8>, bool>(arg0),
            route_set        : 0x2::vec_set::empty<RouteKey>(),
            assets           : 0x2::table::new<RouteKey, AssetInfo>(arg0),
            assets_by_id     : 0x2::table::new<u64, RouteKey>(arg0),
        };
        0x2::transfer::share_object<BridgeCore>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun issue_reserve_cap(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : ReserveCap {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        ReserveCap{
            id    : 0x2::object::new(arg3),
            route : v0,
        }
    }

    public fun issue_verifier_cap(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : VerifierCap {
        let v0 = RouteKey{
            chain : arg1,
            asset : arg2,
        };
        VerifierCap{
            id    : 0x2::object::new(arg3),
            route : v0,
        }
    }

    public fun register_asset(arg0: &mut BridgeCore, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u8, arg7: u256, arg8: u64) {
        let v0 = RouteKey{
            chain : arg2,
            asset : arg3,
        };
        assert!(!0x2::table::contains<RouteKey, AssetInfo>(&arg0.assets, v0), 9);
        let v1 = AssetInfo{
            symbol            : arg4,
            swaplock_asset_id : 0,
            precision         : arg5,
            source_decimals   : arg6,
            scale             : arg7,
            max_withdrawal    : arg8,
            status            : 0,
        };
        0x2::table::add<RouteKey, AssetInfo>(&mut arg0.assets, v0, v1);
    }

    public fun register_route(arg0: &mut BridgeCore, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = RouteKey{
            chain : arg2,
            asset : arg3,
        };
        assert!(!0x2::vec_set::contains<RouteKey>(&arg0.route_set, &v0), 5);
        let v1 = RouteConfig{
            per_withdrawal_cap : arg4,
            threshold_amount   : arg5,
            min_below          : arg6,
            min_above          : arg7,
        };
        0x2::table::add<RouteKey, RouteConfig>(&mut arg0.routes, v0, v1);
        0x2::vec_set::insert<RouteKey>(&mut arg0.route_set, v0);
    }

    public fun route_by_asset_id(arg0: &BridgeCore, arg1: u64) : (vector<u8>, vector<u8>) {
        let v0 = 0x2::table::borrow<u64, RouteKey>(&arg0.assets_by_id, arg1);
        (v0.chain, v0.asset)
    }

    public fun submit_verified_deposit(arg0: &mut BridgeCore, arg1: &VerifierCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        assert!(0x2::vec_set::contains<RouteKey>(&arg0.route_set, &arg1.route), 7);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_deposits, arg2), 2);
        let v0 = 0x2::table::borrow<RouteKey, RouteConfig>(&arg0.routes, arg1.route);
        assert!(arg4 <= v0.per_withdrawal_cap, 4);
        let v1 = if (arg4 > v0.threshold_amount) {
            v0.min_above
        } else {
            v0.min_below
        };
        let v2 = 0x2::object::id<VerifierCap>(arg1);
        if (!0x2::table::contains<vector<u8>, Attestation>(&arg0.attestations, arg2)) {
            let v3 = 0x2::vec_set::empty<0x2::object::ID>();
            0x2::vec_set::insert<0x2::object::ID>(&mut v3, v2);
            let v4 = Attestation{
                route         : arg1.route,
                withdrawal_id : arg3,
                amount        : arg4,
                message       : arg5,
                attestors     : v3,
            };
            0x2::table::add<vector<u8>, Attestation>(&mut arg0.attestations, arg2, v4);
        } else {
            let v5 = 0x2::table::borrow_mut<vector<u8>, Attestation>(&mut arg0.attestations, arg2);
            let v6 = if (v5.route == arg1.route) {
                if (v5.amount == arg4) {
                    if (v5.withdrawal_id == arg3) {
                        v5.message == arg5
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 8);
            if (!0x2::vec_set::contains<0x2::object::ID>(&v5.attestors, &v2)) {
                0x2::vec_set::insert<0x2::object::ID>(&mut v5.attestors, v2);
            };
        };
        if (0x2::vec_set::size<0x2::object::ID>(&0x2::table::borrow<vector<u8>, Attestation>(&arg0.attestations, arg2).attestors) >= v1) {
            let Attestation {
                route         : v7,
                withdrawal_id : v8,
                amount        : v9,
                message       : v10,
                attestors     : _,
            } = 0x2::table::remove<vector<u8>, Attestation>(&mut arg0.attestations, arg2);
            0x2::table::add<vector<u8>, bool>(&mut arg0.used_deposits, arg2, true);
            let v12 = PendingWithdrawal{
                route   : v7,
                amount  : v9,
                message : v10,
            };
            0x2::table::add<vector<u8>, PendingWithdrawal>(&mut arg0.withdrawals, v8, v12);
        };
    }

    public fun unfreeze_asset(arg0: &mut BridgeCore, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = RouteKey{
            chain : arg2,
            asset : arg3,
        };
        assert!(0x2::table::contains<RouteKey, AssetInfo>(&arg0.assets, v0), 10);
        let v1 = 0x2::table::borrow_mut<RouteKey, AssetInfo>(&mut arg0.assets, v0);
        assert!(v1.status == 2, 11);
        v1.status = 1;
    }

    public fun update_route(arg0: &mut BridgeCore, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = RouteKey{
            chain : arg2,
            asset : arg3,
        };
        assert!(0x2::vec_set::contains<RouteKey>(&arg0.route_set, &v0), 7);
        let v1 = 0x2::table::borrow_mut<RouteKey, RouteConfig>(&mut arg0.routes, v0);
        v1.per_withdrawal_cap = arg4;
        v1.threshold_amount = arg5;
        v1.min_below = arg6;
        v1.min_above = arg7;
    }

    public fun withdrawal_pending(arg0: &BridgeCore, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, PendingWithdrawal>(&arg0.withdrawals, arg1)
    }

    // decompiled from Move bytecode v7
}

