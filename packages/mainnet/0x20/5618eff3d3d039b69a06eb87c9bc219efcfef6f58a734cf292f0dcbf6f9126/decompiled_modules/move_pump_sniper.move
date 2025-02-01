module 0x205618eff3d3d039b69a06eb87c9bc219efcfef6f58a734cf292f0dcbf6f9126::move_pump_sniper {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SniperContract has key {
        id: 0x2::object::UID,
        owner: address,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        active: bool,
        positions: 0x2::table::Table<vector<u8>, Position>,
        emergency_threshold: u64,
    }

    struct Position has store {
        token_type: 0x1::string::String,
        amount: u64,
        pool_id: address,
        verified_token_id: address,
        timestamp: u64,
    }

    struct TokenPurchased has copy, drop {
        token_type: 0x1::string::String,
        amount: u64,
        sui_spent: u64,
        pool_id: address,
        token_id: address,
    }

    struct TokenSold has copy, drop {
        token_type: 0x1::string::String,
        amount: u64,
        sui_received: u64,
    }

    struct EmergencySale has copy, drop {
        token_type: 0x1::string::String,
        reason: 0x1::string::String,
    }

    public fun deposit(arg0: &mut SniperContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_balance(arg0: &SniperContract) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_emergency_threshold(arg0: &SniperContract) : u64 {
        arg0.emergency_threshold
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SniperContract{
            id                  : 0x2::object::new(arg0),
            owner               : 0x2::tx_context::sender(arg0),
            sui_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            active              : true,
            positions           : 0x2::table::new<vector<u8>, Position>(arg0),
            emergency_threshold : 98,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<SniperContract>(v1);
    }

    public fun is_active(arg0: &SniperContract) : bool {
        arg0.active
    }

    public entry fun prepare_buy_and_send(arg0: &mut SniperContract, arg1: u64, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg4), arg2);
    }

    public entry fun record_purchase(arg0: &mut SniperContract, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        0x2::object::delete(v0);
        let v1 = Position{
            token_type        : 0x1::string::utf8(b"T"),
            amount            : arg1,
            pool_id           : arg3,
            verified_token_id : arg4,
            timestamp         : 0x2::tx_context::epoch(arg6),
        };
        0x2::table::add<vector<u8>, Position>(&mut arg0.positions, 0x2::object::uid_to_bytes(&v0), v1);
        let v2 = TokenPurchased{
            token_type : 0x1::string::utf8(b"T"),
            amount     : arg1,
            sui_spent  : arg2,
            pool_id    : arg3,
            token_id   : arg4,
        };
        0x2::event::emit<TokenPurchased>(v2);
    }

    public entry fun record_sale(arg0: &mut SniperContract, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        assert!(0x2::table::contains<vector<u8>, Position>(&arg0.positions, arg1), 3);
        let Position {
            token_type        : v0,
            amount            : v1,
            pool_id           : _,
            verified_token_id : _,
            timestamp         : _,
        } = 0x2::table::remove<vector<u8>, Position>(&mut arg0.positions, arg1);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v5);
        let v6 = TokenSold{
            token_type   : v0,
            amount       : v1,
            sui_received : 0x2::balance::value<0x2::sui::SUI>(&v5),
        };
        0x2::event::emit<TokenSold>(v6);
    }

    public entry fun toggle_active(arg0: &mut SniperContract, arg1: &AdminCap) {
        arg0.active = !arg0.active;
    }

    public entry fun update_emergency_threshold(arg0: &mut SniperContract, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 > 0 && arg1 <= 100, 2);
        arg0.emergency_threshold = arg1;
    }

    public entry fun withdraw_sui(arg0: &mut SniperContract, arg1: u64, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

