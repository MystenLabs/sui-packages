module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router {
    struct Farm has copy, drop, store {
        id: u64,
        venue: vector<u8>,
        pool_id: 0x2::object::ID,
        fee_bps: u64,
        active: bool,
    }

    struct Router has key {
        id: 0x2::object::UID,
        operations_wallet: address,
        paused: bool,
        next_farm_id: u64,
        farms: vector<Farm>,
    }

    struct RouterCreated has copy, drop {
        operations_wallet: address,
    }

    struct FarmListed has copy, drop {
        farm_id: u64,
        venue: vector<u8>,
        pool_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct FarmStatusChanged has copy, drop {
        farm_id: u64,
        active: bool,
    }

    struct RouterPaused has copy, drop {
        paused: bool,
    }

    struct OperationsWalletChanged has copy, drop {
        previous: address,
        next: address,
    }

    public fun assert_active_farm_pool(arg0: &Router, arg1: u64, arg2: 0x2::object::ID) {
        assert!(!arg0.paused, 1);
        let v0 = farm(arg0, arg1);
        assert!(v0.active && v0.pool_id == arg2, 3);
    }

    public fun assert_route(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 2);
    }

    fun borrow_farm_mut(arg0: &mut Router, arg1: u64) : &mut Farm {
        0x1::vector::borrow_mut<Farm>(&mut arg0.farms, farm_index(&arg0.farms, arg1))
    }

    fun contains_pool(arg0: &vector<Farm>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Farm>(arg0)) {
            if (0x1::vector::borrow<Farm>(arg0, v0).pool_id == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun create_router(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 4);
        let v0 = Router{
            id                : 0x2::object::new(arg2),
            operations_wallet : arg1,
            paused            : false,
            next_farm_id      : 0,
            farms             : 0x1::vector::empty<Farm>(),
        };
        0x2::transfer::share_object<Router>(v0);
        let v1 = RouterCreated{operations_wallet: arg1};
        0x2::event::emit<RouterCreated>(v1);
    }

    public fun farm(arg0: &Router, arg1: u64) : Farm {
        *0x1::vector::borrow<Farm>(&arg0.farms, farm_index(&arg0.farms, arg1))
    }

    public fun farm_count(arg0: &Router) : u64 {
        0x1::vector::length<Farm>(&arg0.farms)
    }

    fun farm_index(arg0: &vector<Farm>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Farm>(arg0)) {
            if (0x1::vector::borrow<Farm>(arg0, v0).id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    fun fee_for_bps(arg0: u64, arg1: u64) : u64 {
        arg0 / 10000 * arg1 + arg0 % 10000 * arg1 / 10000
    }

    public fun is_farm_active(arg0: &Router, arg1: u64) : bool {
        let v0 = farm(arg0, arg1);
        v0.active
    }

    public fun is_paused(arg0: &Router) : bool {
        arg0.paused
    }

    public entry fun list_farm(arg0: &mut Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: u64) {
        assert!(!arg0.paused, 1);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 3);
        assert!(!contains_pool(&arg0.farms, &arg3), 5);
        let v0 = arg0.next_farm_id;
        arg0.next_farm_id = v0 + 1;
        let v1 = Farm{
            id      : v0,
            venue   : arg2,
            pool_id : arg3,
            fee_bps : arg4,
            active  : true,
        };
        0x1::vector::push_back<Farm>(&mut arg0.farms, v1);
        let v2 = *0x1::vector::borrow<Farm>(&arg0.farms, 0x1::vector::length<Farm>(&arg0.farms) - 1);
        let v3 = FarmListed{
            farm_id : v0,
            venue   : v2.venue,
            pool_id : v2.pool_id,
            fee_bps : arg4,
        };
        0x2::event::emit<FarmListed>(v3);
    }

    public fun lumi_claim_fee(arg0: u64) : u64 {
        fee_for_bps(arg0, 50)
    }

    public fun lumi_claim_fee_bps() : u64 {
        50
    }

    public fun native_reward_fees(arg0: u64) : (u64, u64) {
        (fee_for_bps(arg0, 50), fee_for_bps(arg0, 200))
    }

    public fun native_total_fee_bps() : u64 {
        250
    }

    public fun operations_fee_bps() : u64 {
        50
    }

    public fun operations_wallet(arg0: &Router) : address {
        arg0.operations_wallet
    }

    public fun protocol_liquidity_fee_bps() : u64 {
        200
    }

    public fun route_lumi_claim() : u8 {
        1
    }

    public fun route_native() : u8 {
        0
    }

    public entry fun set_farm_active(arg0: &mut Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: u64, arg3: bool) {
        borrow_farm_mut(arg0, arg2).active = arg3;
        let v0 = FarmStatusChanged{
            farm_id : arg2,
            active  : arg3,
        };
        0x2::event::emit<FarmStatusChanged>(v0);
    }

    public entry fun set_operations_wallet(arg0: &mut Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: address) {
        assert!(arg2 != @0x0, 4);
        arg0.operations_wallet = arg2;
        let v0 = OperationsWalletChanged{
            previous : arg0.operations_wallet,
            next     : arg2,
        };
        0x2::event::emit<OperationsWalletChanged>(v0);
    }

    public entry fun set_paused(arg0: &mut Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = RouterPaused{paused: arg2};
        0x2::event::emit<RouterPaused>(v0);
    }

    // decompiled from Move bytecode v7
}

