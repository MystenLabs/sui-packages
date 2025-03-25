module 0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::gas_station {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GasStation has store, key {
        id: 0x2::object::UID,
        gas_whitelist: 0x2::table::Table<0x2::object::ID, address>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        once_refuel_amount: u64,
        daily_refuel_limit: u64,
        max_gas_amount: u64,
        daily_refuel_tracker: 0x2::table::Table<0x2::object::ID, DailyRefuelInfo>,
    }

    struct DailyRefuelInfo has copy, store {
        amount_today: u64,
        last_refuel_day: u64,
        total_amount: u64,
    }

    struct InitEvent has copy, drop, store {
        gas_station_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct RefuelEvent has copy, drop, store {
        amount: u64,
        timestamp: u64,
        gas_object: 0x2::object::ID,
        gas_owner: address,
    }

    struct SetDailyLimitEvent has copy, drop, store {
        old_limit: u64,
        new_limit: u64,
        admin: address,
    }

    struct SetOnceRefuelAmountEvent has copy, drop, store {
        old_amount: u64,
        new_amount: u64,
        admin: address,
    }

    struct SetMaxGasAmountEvent has copy, drop, store {
        old_amount: u64,
        new_amount: u64,
        admin: address,
    }

    struct AddGasObjectToWhitelistEvent has copy, drop, store {
        gas_object: 0x2::object::ID,
        admin: address,
    }

    struct RemoveGasObjectFromWhitelistEvent has copy, drop, store {
        gas_object: 0x2::object::ID,
        admin: address,
    }

    struct AddBalanceEvent has copy, drop, store {
        amount: u64,
        admin: address,
    }

    struct WithdrawBalanceEvent has copy, drop, store {
        amount: u64,
        admin: address,
    }

    public fun add_gas_object_to_whitelist(arg0: &AdminCap, arg1: &mut GasStation, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_from_bytes(arg2);
        if (!0x2::table::contains<0x2::object::ID, address>(&arg1.gas_whitelist, v0)) {
            0x2::table::add<0x2::object::ID, address>(&mut arg1.gas_whitelist, v0, arg3);
            let v1 = AddGasObjectToWhitelistEvent{
                gas_object : v0,
                admin      : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<AddGasObjectToWhitelistEvent>(v1);
        };
    }

    fun check_and_update_daily_refuel(arg0: &mut GasStation, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        let v0 = get_day_timestamp(arg2);
        if (!0x2::table::contains<0x2::object::ID, DailyRefuelInfo>(&arg0.daily_refuel_tracker, arg1)) {
            let v1 = DailyRefuelInfo{
                amount_today    : arg0.once_refuel_amount,
                last_refuel_day : v0,
                total_amount    : arg0.once_refuel_amount,
            };
            0x2::table::add<0x2::object::ID, DailyRefuelInfo>(&mut arg0.daily_refuel_tracker, arg1, v1);
            return true
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, DailyRefuelInfo>(&mut arg0.daily_refuel_tracker, arg1);
        if (v2.last_refuel_day != v0) {
            v2.amount_today = 0;
            v2.last_refuel_day = v0;
        };
        if (v2.amount_today + arg0.once_refuel_amount > arg0.daily_refuel_limit) {
            return false
        };
        v2.amount_today = v2.amount_today + arg0.once_refuel_amount;
        true
    }

    public fun deposit(arg0: &mut GasStation, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = AddBalanceEvent{
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            admin  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AddBalanceEvent>(v0);
    }

    public fun get_balance(arg0: &GasStation) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_daily_refuel_limit(arg0: &GasStation) : u64 {
        arg0.daily_refuel_limit
    }

    fun get_day_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 86400000
    }

    public fun get_gas_whitelist(arg0: &GasStation) : &0x2::table::Table<0x2::object::ID, address> {
        &arg0.gas_whitelist
    }

    public fun get_max_gas_amount(arg0: &GasStation) : u64 {
        arg0.max_gas_amount
    }

    public fun get_once_refuel_amount(arg0: &GasStation) : u64 {
        arg0.once_refuel_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GasStation{
            id                   : 0x2::object::new(arg0),
            gas_whitelist        : 0x2::table::new<0x2::object::ID, address>(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            once_refuel_amount   : 10000000000,
            daily_refuel_limit   : 50000000000,
            max_gas_amount       : 10000000000,
            daily_refuel_tracker : 0x2::table::new<0x2::object::ID, DailyRefuelInfo>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = InitEvent{
            gas_station_id : 0x2::object::id<GasStation>(&v0),
            admin_cap_id   : 0x2::object::id<AdminCap>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GasStation>(v0);
    }

    public fun is_gas_object_whitelisted(arg0: &GasStation, arg1: &0x2::coin::Coin<0x2::sui::SUI>) : bool {
        0x2::table::contains<0x2::object::ID, address>(&arg0.gas_whitelist, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1))
    }

    public fun refuel(arg0: &mut GasStation, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, address>(&arg0.gas_whitelist, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1))) {
            0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::error::gas_object_not_whitelisted();
        };
        if (0x2::coin::value<0x2::sui::SUI>(arg1) > arg0.max_gas_amount) {
            0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::error::exceed_max_gas_amount();
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < arg0.once_refuel_amount) {
            0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::error::insufficient_balance();
        };
        let v0 = 0x2::tx_context::sender(arg3);
        if (&v0 != 0x2::table::borrow<0x2::object::ID, address>(&arg0.gas_whitelist, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1))) {
            0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::error::gas_owner_mismatch();
        };
        let v1 = check_and_update_daily_refuel(arg0, 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1), arg2);
        if (!v1) {
            0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::error::exceed_daily_refuel_limit();
        };
        0x2::coin::join<0x2::sui::SUI>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg0.once_refuel_amount), arg3));
        let v2 = RefuelEvent{
            amount     : arg0.once_refuel_amount,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
            gas_object : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(arg1),
            gas_owner  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RefuelEvent>(v2);
    }

    public fun remove_gas_object_from_whitelist(arg0: &AdminCap, arg1: &mut GasStation, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_from_bytes(arg2);
        if (0x2::table::contains<0x2::object::ID, address>(&arg1.gas_whitelist, v0)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg1.gas_whitelist, v0);
            let v1 = RemoveGasObjectFromWhitelistEvent{
                gas_object : v0,
                admin      : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<RemoveGasObjectFromWhitelistEvent>(v1);
        };
    }

    public fun set_daily_refuel_limit(arg0: &AdminCap, arg1: &mut GasStation, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.daily_refuel_limit = arg2;
        let v0 = SetDailyLimitEvent{
            old_limit : arg1.daily_refuel_limit,
            new_limit : arg2,
            admin     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetDailyLimitEvent>(v0);
    }

    public fun set_max_gas_amount(arg0: &AdminCap, arg1: &mut GasStation, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_gas_amount = arg2;
        let v0 = SetMaxGasAmountEvent{
            old_amount : arg1.max_gas_amount,
            new_amount : arg2,
            admin      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetMaxGasAmountEvent>(v0);
    }

    public fun set_once_refuel_amount(arg0: &AdminCap, arg1: &mut GasStation, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.once_refuel_amount = arg2;
        let v0 = SetOnceRefuelAmountEvent{
            old_amount : arg1.once_refuel_amount,
            new_amount : arg2,
            admin      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SetOnceRefuelAmountEvent>(v0);
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut GasStation, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = WithdrawBalanceEvent{
            amount : arg2,
            admin  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WithdrawBalanceEvent>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

