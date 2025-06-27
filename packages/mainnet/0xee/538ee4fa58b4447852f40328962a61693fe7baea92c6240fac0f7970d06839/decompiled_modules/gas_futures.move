module 0xee538ee4fa58b4447852f40328962a61693fe7baea92c6240fac0f7970d06839::gas_futures {
    struct GasVoucher has store, key {
        id: 0x2::object::UID,
        owner: address,
        credits: u64,
        original_credits: u64,
        expiry: u64,
        created_at: u64,
        redeemed_amount: u64,
        active: bool,
    }

    struct SuiGasOracle has key {
        id: 0x2::object::UID,
        current_gas_price: u64,
        congestion_level: u8,
        validator_fees: 0x2::table::Table<address, u64>,
        last_update: u64,
        update_frequency: u64,
        admin: address,
    }

    struct GasFuturesContract has store, key {
        id: 0x2::object::UID,
        owner: address,
        gas_credits: u64,
        purchase_price: u64,
        expiry_timestamp: u64,
        duration_days: u64,
        status: u8,
        created_at: u64,
        congestion_at_purchase: u8,
        actual_delivery: bool,
        voucher_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct GasFuturesRegistry has key {
        id: 0x2::object::UID,
        contracts: 0x2::table::Table<address, vector<0x2::object::ID>>,
        vouchers: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_contracts: u64,
        total_volume: u64,
        total_gas_reserved: u64,
        gas_reserve_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        oracle_id: 0x1::option::Option<0x2::object::ID>,
        emergency_mode: bool,
        physical_delivery_enabled: bool,
    }

    struct ContractPurchased has copy, drop {
        contract_id: 0x2::object::ID,
        owner: address,
        gas_credits: u64,
        purchase_price: u64,
        expiry_timestamp: u64,
        duration_days: u64,
        physical_delivery: bool,
        congestion_level: u8,
    }

    struct GasVoucherCreated has copy, drop {
        voucher_id: 0x2::object::ID,
        owner: address,
        credits: u64,
        expiry: u64,
        contract_id: 0x2::object::ID,
    }

    struct GasVoucherUsed has copy, drop {
        voucher_id: 0x2::object::ID,
        owner: address,
        gas_amount: u64,
        remaining_credits: u64,
        transaction_cost_saved: u64,
    }

    struct ContractRedeemed has copy, drop {
        contract_id: 0x2::object::ID,
        owner: address,
        gas_credits: u64,
        redemption_amount: u64,
        physical_delivery: bool,
        voucher_created: 0x1::option::Option<0x2::object::ID>,
    }

    struct ContractExpired has copy, drop {
        contract_id: 0x2::object::ID,
        owner: address,
        gas_credits: u64,
    }

    struct OraclePriceUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        congestion_level: u8,
        timestamp: u64,
    }

    fun calculate_dynamic_premium(arg0: u64, arg1: u64, arg2: u8) : u64 {
        let v0 = if (arg1 == 30) {
            2500
        } else if (arg1 == 60) {
            5000
        } else {
            assert!(arg1 == 90, 1);
            8300
        };
        let v1 = if (arg2 == 3) {
            15000
        } else if (arg2 == 2) {
            10000
        } else {
            5000
        };
        arg0 + arg0 * (v0 + v1) / 10000
    }

    fun calculate_premium(arg0: u64, arg1: u64) : u64 {
        calculate_dynamic_premium(arg0, arg1, 1)
    }

    public fun get_contract_info(arg0: &GasFuturesContract) : (address, u64, u64, u64, u64, u8, u64, bool, 0x1::option::Option<0x2::object::ID>) {
        (arg0.owner, arg0.gas_credits, arg0.purchase_price, arg0.expiry_timestamp, arg0.duration_days, arg0.status, arg0.created_at, arg0.actual_delivery, arg0.voucher_id)
    }

    public fun get_oracle_info(arg0: &SuiGasOracle) : (u64, u8, u64) {
        (arg0.current_gas_price, arg0.congestion_level, arg0.last_update)
    }

    public fun get_registry_stats(arg0: &GasFuturesRegistry) : (u64, u64, u64, bool, bool) {
        (arg0.total_contracts, arg0.total_volume, arg0.total_gas_reserved, arg0.emergency_mode, arg0.physical_delivery_enabled)
    }

    public fun get_voucher_info(arg0: &GasVoucher) : (address, u64, u64, u64, u64, bool) {
        (arg0.owner, arg0.credits, arg0.original_credits, arg0.expiry, arg0.redeemed_amount, arg0.active)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GasFuturesRegistry{
            id                        : 0x2::object::new(arg0),
            contracts                 : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            vouchers                  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_contracts           : 0,
            total_volume              : 0,
            total_gas_reserved        : 0,
            gas_reserve_pool          : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                     : 0x2::tx_context::sender(arg0),
            oracle_id                 : 0x1::option::none<0x2::object::ID>(),
            emergency_mode            : false,
            physical_delivery_enabled : true,
        };
        let v1 = SuiGasOracle{
            id                : 0x2::object::new(arg0),
            current_gas_price : 1000,
            congestion_level  : 1,
            validator_fees    : 0x2::table::new<address, u64>(arg0),
            last_update       : 0,
            update_frequency  : 300000,
            admin             : 0x2::tx_context::sender(arg0),
        };
        v0.oracle_id = 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::share_object<GasFuturesRegistry>(v0);
        0x2::transfer::share_object<SuiGasOracle>(v1);
    }

    public entry fun purchase_gas_futures(arg0: &mut GasFuturesRegistry, arg1: &SuiGasOracle, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_mode, 5);
        let v0 = if (arg4 == 30) {
            true
        } else if (arg4 == 60) {
            true
        } else {
            arg4 == 90
        };
        assert!(v0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = calculate_dynamic_premium(arg3 * arg1.current_gas_price, arg4, arg1.congestion_level);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 2);
        let v3 = v1 + arg4 * 24 * 60 * 60 * 1000;
        let v4 = GasFuturesContract{
            id                     : 0x2::object::new(arg7),
            owner                  : 0x2::tx_context::sender(arg7),
            gas_credits            : arg3,
            purchase_price         : v2,
            expiry_timestamp       : v3,
            duration_days          : arg4,
            status                 : 0,
            created_at             : v1,
            congestion_at_purchase : arg1.congestion_level,
            actual_delivery        : arg5,
            voucher_id             : 0x1::option::none<0x2::object::ID>(),
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        arg0.total_contracts = arg0.total_contracts + 1;
        arg0.total_volume = arg0.total_volume + v2;
        if (arg5) {
            arg0.total_gas_reserved = arg0.total_gas_reserved + arg3;
        };
        let v6 = 0x2::tx_context::sender(arg7);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.contracts, v6)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.contracts, v6, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.contracts, v6), v5);
        if (arg5) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_reserve_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x0);
        };
        let v7 = ContractPurchased{
            contract_id       : v5,
            owner             : v6,
            gas_credits       : arg3,
            purchase_price    : v2,
            expiry_timestamp  : v3,
            duration_days     : arg4,
            physical_delivery : arg5,
            congestion_level  : arg1.congestion_level,
        };
        0x2::event::emit<ContractPurchased>(v7);
        0x2::transfer::transfer<GasFuturesContract>(v4, v6);
    }

    public entry fun redeem_gas_credits(arg0: &mut GasFuturesRegistry, arg1: GasFuturesContract, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 5);
        assert!(arg1.status == 0, 6);
        assert!(v0 <= arg1.expiry_timestamp, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::object::uid_to_inner(&arg1.id);
        let v3 = if (arg1.actual_delivery && arg0.physical_delivery_enabled) {
            let v4 = GasVoucher{
                id               : 0x2::object::new(arg3),
                owner            : v1,
                credits          : arg1.gas_credits,
                original_credits : arg1.gas_credits,
                expiry           : arg1.expiry_timestamp,
                created_at       : v0,
                redeemed_amount  : 0,
                active           : true,
            };
            let v5 = 0x2::object::uid_to_inner(&v4.id);
            if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.vouchers, v1)) {
                0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.vouchers, v1, 0x1::vector::empty<0x2::object::ID>());
            };
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.vouchers, v1), v5);
            arg1.voucher_id = 0x1::option::some<0x2::object::ID>(v5);
            let v6 = GasVoucherCreated{
                voucher_id  : v5,
                owner       : v1,
                credits     : arg1.gas_credits,
                expiry      : arg1.expiry_timestamp,
                contract_id : v2,
            };
            0x2::event::emit<GasVoucherCreated>(v6);
            0x2::transfer::transfer<GasVoucher>(v4, v1);
            0x1::option::some<0x2::object::ID>(v5)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.gas_reserve_pool, arg1.gas_credits * 1000, arg3), v1);
            0x1::option::none<0x2::object::ID>()
        };
        arg1.status = 1;
        let v7 = if (arg1.actual_delivery) {
            0
        } else {
            arg1.gas_credits * 1000
        };
        let v8 = ContractRedeemed{
            contract_id       : v2,
            owner             : arg1.owner,
            gas_credits       : arg1.gas_credits,
            redemption_amount : v7,
            physical_delivery : arg1.actual_delivery,
            voucher_created   : v3,
        };
        0x2::event::emit<ContractRedeemed>(v8);
        0x2::transfer::transfer<GasFuturesContract>(arg1, v1);
    }

    public entry fun toggle_emergency_mode(arg0: &mut GasFuturesRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
        arg0.emergency_mode = !arg0.emergency_mode;
    }

    public entry fun toggle_physical_delivery(arg0: &mut GasFuturesRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 5);
        arg0.physical_delivery_enabled = !arg0.physical_delivery_enabled;
    }

    public entry fun update_gas_oracle(arg0: &mut SuiGasOracle, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.last_update + arg0.update_frequency, 5);
        arg0.current_gas_price = arg1;
        arg0.congestion_level = arg2;
        arg0.last_update = v0;
        let v1 = OraclePriceUpdated{
            oracle_id        : 0x2::object::uid_to_inner(&arg0.id),
            old_price        : arg0.current_gas_price,
            new_price        : arg1,
            congestion_level : arg2,
            timestamp        : v0,
        };
        0x2::event::emit<OraclePriceUpdated>(v1);
    }

    public entry fun use_gas_voucher(arg0: &mut GasFuturesRegistry, arg1: &mut GasVoucher, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 5);
        assert!(arg1.active, 6);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.expiry, 8);
        assert!(arg1.credits >= arg2, 7);
        assert!(arg2 > 0, 9);
        arg1.credits = arg1.credits - arg2;
        arg1.redeemed_amount = arg1.redeemed_amount + arg2;
        if (arg1.credits == 0) {
            arg1.active = false;
        };
        let v0 = arg2 * 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.gas_reserve_pool, v0, arg4), 0x2::tx_context::sender(arg4));
        let v1 = GasVoucherUsed{
            voucher_id             : 0x2::object::uid_to_inner(&arg1.id),
            owner                  : arg1.owner,
            gas_amount             : arg2,
            remaining_credits      : arg1.credits,
            transaction_cost_saved : v0,
        };
        0x2::event::emit<GasVoucherUsed>(v1);
    }

    // decompiled from Move bytecode v6
}

