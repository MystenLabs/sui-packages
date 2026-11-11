module 0xddd369c98dfe27b63f80e6bc87b9deeee6d20f89f7bb9df1eaf29d5ff6b52c29::vault {
    struct VaultShare<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        idle: 0x2::balance::Balance<T0>,
        shares: 0x2::balance::Supply<VaultShare<T0>>,
        allocations: 0x2::table::Table<0x1::type_name::TypeName, Allocation>,
        market_order: vector<0x1::type_name::TypeName>,
        deposit_cap: u64,
        perf_fee_bps: u64,
        fee_recipient: address,
        hwm_price: u128,
        deposits_paused: bool,
        withdrawals_paused: bool,
        allocations_paused: bool,
        allocators: 0x2::vec_set::VecSet<0x2::object::ID>,
        guardians: 0x2::vec_set::VecSet<0x2::object::ID>,
        nonce: u64,
    }

    struct Allocation has store {
        market_id: 0x2::object::ID,
        cap: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap,
        supply_cap: u64,
        min_alloc: u64,
        rate_ceiling_bps: u64,
        enabled: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AllocatorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct NavReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        nonce: u64,
        seen: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        total: u64,
    }

    struct WithdrawTicket<phantom T0> {
        vault_id: 0x2::object::ID,
        owed: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
    }

    struct MarketAdded has copy, drop {
        vault_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
    }

    struct MarketRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
    }

    struct MarketConfigured has copy, drop {
        vault_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
        supply_cap: u64,
        min_alloc: u64,
        rate_ceiling_bps: u64,
        enabled: bool,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        assets: u64,
        shares: u64,
        total_assets: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
        assets: u64,
        shares: u64,
        total_assets: u64,
    }

    struct Supplied has copy, drop {
        vault_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
        amount: u64,
        position_after: u64,
    }

    struct Pulled has copy, drop {
        vault_id: 0x2::object::ID,
        market: 0x1::type_name::TypeName,
        amount: u64,
        position_after: u64,
    }

    struct FeeAccrued has copy, drop {
        vault_id: 0x2::object::ID,
        fee_shares: u64,
        price: u128,
    }

    struct PauseChanged has copy, drop {
        vault_id: 0x2::object::ID,
        deposits: bool,
        withdrawals: bool,
        allocations: bool,
    }

    fun accrue_fee<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares);
        if (v0 == 0) {
            return arg1
        };
        let v1 = (arg1 as u128) * 1000000000000000000 / (v0 as u128);
        if (v1 <= arg0.hwm_price) {
            return arg1
        };
        if (arg0.perf_fee_bps > 0) {
            let v2 = mul_div((((v1 - arg0.hwm_price) * (v0 as u128) / 1000000000000000000) as u64), arg0.perf_fee_bps, 10000);
            if (v2 > 0 && v2 < arg1) {
                let v3 = mul_div(v2, v0, arg1 - v2);
                if (v3 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<VaultShare<T0>>>(0x2::coin::from_balance<VaultShare<T0>>(0x2::balance::increase_supply<VaultShare<T0>>(&mut arg0.shares, v3), arg2), arg0.fee_recipient);
                    arg0.nonce = arg0.nonce + 1;
                    let v4 = FeeAccrued{
                        vault_id   : 0x2::object::id<Vault<T0>>(arg0),
                        fee_shares : v3,
                        price      : v1,
                    };
                    0x2::event::emit<FeeAccrued>(v4);
                };
            };
        };
        arg0.hwm_price = (arg1 as u128) * 1000000000000000000 / (0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares) as u128);
        arg1
    }

    public fun add_market<T0, T1>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0), 8);
        let v1 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::enter_market::enter_market_return<T1>(arg2, arg3, arg7);
        let v2 = 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>>(arg3);
        let v3 = Allocation{
            market_id        : v2,
            cap              : v1,
            supply_cap       : arg4,
            min_alloc        : arg5,
            rate_ceiling_bps : arg6,
            enabled          : true,
        };
        0x2::table::add<0x1::type_name::TypeName, Allocation>(&mut arg0.allocations, v0, v3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.market_order, v0);
        arg0.nonce = arg0.nonce + 1;
        let v4 = MarketAdded{
            vault_id      : 0x2::object::id<Vault<T0>>(arg0),
            market        : v0,
            market_id     : v2,
            obligation_id : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&v1),
        };
        0x2::event::emit<MarketAdded>(v4);
        let v5 = MarketConfigured{
            vault_id         : 0x2::object::id<Vault<T0>>(arg0),
            market           : v0,
            supply_cap       : arg4,
            min_alloc        : arg5,
            rate_ceiling_bps : arg6,
            enabled          : true,
        };
        0x2::event::emit<MarketConfigured>(v5);
    }

    public fun add_market_nav<T0, T1>(arg0: &Vault<T0>, arg1: &mut NavReceipt<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg3: &0x2::clock::Clock) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 0);
        assert!(arg1.nonce == arg0.nonce, 19);
        let v0 = checked_key<T0, T1>(arg0, arg2);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.market_order, &v0), 21);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.seen, &v0), 6);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.seen, v0);
        arg1.total = arg1.total + position_value<T0, T1>(arg0, arg2, arg3);
    }

    fun assert_allocator<T0>(arg0: &Vault<T0>, arg1: &AllocatorCap) {
        let v0 = if (arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0)) {
            let v1 = 0x2::object::id<AllocatorCap>(arg1);
            0x2::vec_set::contains<0x2::object::ID>(&arg0.allocators, &v1)
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun assert_guardian<T0>(arg0: &Vault<T0>, arg1: &GuardianCap) {
        let v0 = if (arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0)) {
            let v1 = 0x2::object::id<GuardianCap>(arg1);
            0x2::vec_set::contains<0x2::object::ID>(&arg0.guardians, &v1)
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun assert_owner<T0>(arg0: &Vault<T0>, arg1: &OwnerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 1);
    }

    fun checked_key<T0, T1>(arg0: &Vault<T0>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0), 7);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0).market_id == 0x2::object::id<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>>(arg1), 9);
        v0
    }

    public fun complete_withdraw<T0>(arg0: &mut Vault<T0>, arg1: WithdrawTicket<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawTicket {
            vault_id : v0,
            owed     : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 0);
        assert!(0x2::balance::value<T0>(&arg0.idle) >= v1, 12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle, v1), arg2)
    }

    public fun configure_market<T0, T1>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: u64, arg3: u64, arg4: u64, arg5: bool) {
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0), 7);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Allocation>(&mut arg0.allocations, v0);
        v1.supply_cap = arg2;
        v1.min_alloc = arg3;
        v1.rate_ceiling_bps = arg4;
        v1.enabled = arg5;
        let v2 = MarketConfigured{
            vault_id         : 0x2::object::id<Vault<T0>>(arg0),
            market           : v0,
            supply_cap       : arg2,
            min_alloc        : arg3,
            rate_ceiling_bps : arg4,
            enabled          : arg5,
        };
        0x2::event::emit<MarketConfigured>(v2);
    }

    fun consume_receipt<T0>(arg0: &Vault<T0>, arg1: NavReceipt<T0>) : u64 {
        let NavReceipt {
            vault_id : v0,
            nonce    : v1,
            seen     : v2,
            total    : v3,
        } = arg1;
        let v4 = v2;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 0);
        assert!(v1 == arg0.nonce, 19);
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&v4) == 0x1::vector::length<0x1::type_name::TypeName>(&arg0.market_order), 5);
        v3
    }

    public fun create_registry(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : (Registry, RegistryAdminCap) {
        let v0 = 0x2::package::upgrade_package(&arg0);
        assert!(0x2::object::id_to_address(&v0) == @0x0, 18);
        let v1 = Registry{
            id          : 0x2::object::new(arg1),
            assets      : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            upgrade_cap : arg0,
        };
        let v2 = RegistryAdminCap{
            id          : 0x2::object::new(arg1),
            registry_id : 0x2::object::id<Registry>(&v1),
        };
        (v1, v2)
    }

    public fun create_vault<T0>(arg0: &mut Registry, arg1: &RegistryAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (Vault<T0>, OwnerCap, AllocatorCap, GuardianCap) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.assets, &v0), 17);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.assets, v0);
        let v1 = VaultShare<T0>{dummy_field: false};
        let v2 = Vault<T0>{
            id                 : 0x2::object::new(arg3),
            idle               : 0x2::balance::zero<T0>(),
            shares             : 0x2::balance::create_supply<VaultShare<T0>>(v1),
            allocations        : 0x2::table::new<0x1::type_name::TypeName, Allocation>(arg3),
            market_order       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            deposit_cap        : 0,
            perf_fee_bps       : 0,
            fee_recipient      : arg2,
            hwm_price          : 1000000000000000000,
            deposits_paused    : false,
            withdrawals_paused : false,
            allocations_paused : false,
            allocators         : 0x2::vec_set::empty<0x2::object::ID>(),
            guardians          : 0x2::vec_set::empty<0x2::object::ID>(),
            nonce              : 0,
        };
        let v3 = 0x2::object::id<Vault<T0>>(&v2);
        let v4 = OwnerCap{
            id       : 0x2::object::new(arg3),
            vault_id : v3,
        };
        let v5 = AllocatorCap{
            id       : 0x2::object::new(arg3),
            vault_id : v3,
        };
        let v6 = GuardianCap{
            id       : 0x2::object::new(arg3),
            vault_id : v3,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut v2.allocators, 0x2::object::id<AllocatorCap>(&v5));
        0x2::vec_set::insert<0x2::object::ID>(&mut v2.guardians, 0x2::object::id<GuardianCap>(&v6));
        let v7 = VaultCreated{
            vault_id : v3,
            asset    : v0,
        };
        0x2::event::emit<VaultCreated>(v7);
        (v2, v4, v5, v6)
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: NavReceipt<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VaultShare<T0>> {
        assert!(!arg0.deposits_paused, 2);
        let v0 = consume_receipt<T0>(arg0, arg1);
        let v1 = accrue_fee<T0>(arg0, v0, arg3);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 14);
        assert!(arg0.deposit_cap == 0 || v1 + v2 <= arg0.deposit_cap, 15);
        let v3 = mul_div(v2, 0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares) + 1, v1 + 1);
        assert!(v3 > 0, 14);
        0x2::balance::join<T0>(&mut arg0.idle, 0x2::coin::into_balance<T0>(arg2));
        arg0.nonce = arg0.nonce + 1;
        let v4 = Deposited{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg3),
            assets       : v2,
            shares       : v3,
            total_assets : v1 + v2,
        };
        0x2::event::emit<Deposited>(v4);
        if (0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares) == 0) {
            arg0.hwm_price = ((v1 + v2) as u128) * 1000000000000000000 / (0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares) as u128);
        };
        0x2::coin::from_balance<VaultShare<T0>>(0x2::balance::increase_supply<VaultShare<T0>>(&mut arg0.shares, v3), arg3)
    }

    public fun deposit_cap<T0>(arg0: &Vault<T0>) : u64 {
        arg0.deposit_cap
    }

    public fun fee_config<T0>(arg0: &Vault<T0>) : (u64, address, u128) {
        (arg0.perf_fee_bps, arg0.fee_recipient, arg0.hwm_price)
    }

    public fun finish_nav<T0>(arg0: &Vault<T0>, arg1: NavReceipt<T0>) : (u64, u64) {
        (consume_receipt<T0>(arg0, arg1), 0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares))
    }

    public fun guardian_exit_market<T0, T1>(arg0: &mut Vault<T0>, arg1: &GuardianCap, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_guardian<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0), 7);
        0x2::table::borrow_mut<0x1::type_name::TypeName, Allocation>(&mut arg0.allocations, v0).supply_cap = 0;
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0);
        let v2 = MarketConfigured{
            vault_id         : 0x2::object::id<Vault<T0>>(arg0),
            market           : v0,
            supply_cap       : 0,
            min_alloc        : v1.min_alloc,
            rate_ceiling_bps : v1.rate_ceiling_bps,
            enabled          : v1.enabled,
        };
        0x2::event::emit<MarketConfigured>(v2);
        let v3 = position_value<T0, T1>(arg0, arg3, arg7);
        let v4 = if (arg6 > v3) {
            v3
        } else {
            arg6
        };
        if (v4 > 0) {
            pull_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, v4, arg7, arg8);
        };
    }

    public fun guardian_pause<T0>(arg0: &mut Vault<T0>, arg1: &GuardianCap) {
        assert_guardian<T0>(arg0, arg1);
        let v0 = arg0.withdrawals_paused;
        set_pause_flags<T0>(arg0, true, v0, true);
    }

    public fun idle<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle)
    }

    public fun market_config<T0, T1>(arg0: &Vault<T0>) : (0x2::object::ID, u64, u64, u64, bool) {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, 0x1::type_name::with_defining_ids<T1>());
        (v0.market_id, v0.supply_cap, v0.min_alloc, v0.rate_ceiling_bps, v0.enabled)
    }

    public fun markets<T0>(arg0: &Vault<T0>) : vector<0x1::type_name::TypeName> {
        arg0.market_order
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_allocator<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : AllocatorCap {
        assert_owner<T0>(arg0, arg1);
        let v0 = AllocatorCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allocators, 0x2::object::id<AllocatorCap>(&v0));
        v0
    }

    public fun new_guardian<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : GuardianCap {
        assert_owner<T0>(arg0, arg1);
        let v0 = GuardianCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.guardians, 0x2::object::id<GuardianCap>(&v0));
        v0
    }

    public fun nonce<T0>(arg0: &Vault<T0>) : u64 {
        arg0.nonce
    }

    public fun obligation_id<T0, T1>(arg0: &Vault<T0>) : 0x2::object::ID {
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, 0x1::type_name::with_defining_ids<T1>()).cap)
    }

    public fun owed<T0>(arg0: &WithdrawTicket<T0>) : u64 {
        arg0.owed
    }

    public fun paused<T0>(arg0: &Vault<T0>) : (bool, bool, bool) {
        (arg0.deposits_paused, arg0.withdrawals_paused, arg0.allocations_paused)
    }

    public fun position_ctokens<T0, T1>(arg0: &Vault<T0>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>) : u64 {
        let v0 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::borrow_obligation<T1>(arg1, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, checked_key<T0, T1>(arg0, arg1)).cap));
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::deposit_types<T1>(v0);
        if (0x1::vector::contains<0x1::type_name::TypeName>(&v2, &v1)) {
            0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ctoken_amount_by_coin<T1>(v0, v1)
        } else {
            0
        }
    }

    public fun position_value<T0, T1>(arg0: &Vault<T0>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = position_ctokens<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_query::get_asset_market_rates<T1>(arg1, 0x1::type_name::with_defining_ids<T0>(), arg2);
        let v2 = 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::int_mul(*0x1::vector::borrow<0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal>(&v1, 0), v0);
        if (v2 > 0) {
            v2 - 1
        } else {
            0
        }
    }

    public fun pull<T0, T1>(arg0: &mut Vault<T0>, arg1: &AllocatorCap, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_allocator<T0>(arg0, arg1);
        pull_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun pull_for_withdraw<T0, T1>(arg0: &mut Vault<T0>, arg1: &WithdrawTicket<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 0);
        let v0 = 0x2::balance::value<T0>(&arg0.idle);
        if (v0 >= arg1.owed) {
            return
        };
        let v1 = 0x1::u64::min(0x1::u64::min(arg6, arg1.owed - v0), position_value<T0, T1>(arg0, arg3, arg7));
        if (v1 > 0) {
            pull_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, v1, arg7, arg8);
        };
    }

    fun pull_internal<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg5 > 0, 14);
        let v0 = checked_key<T0, T1>(arg0, arg2);
        let v1 = position_ctokens<T0, T1>(arg0, arg2);
        let v2 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_query::get_asset_market_rates<T1>(arg2, 0x1::type_name::with_defining_ids<T0>(), arg6);
        let v3 = *0x1::vector::borrow<0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal>(&v2, 0);
        let v4 = 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::int_div(arg5, v3) + 1;
        let v5 = v4;
        if (0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::int_mul(v3, v4 - 1) < arg5) {
            v5 = v4 + 1;
        };
        if (v5 > v1) {
            v5 = v1;
        };
        assert!(v5 > 0, 14);
        let v6 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<T1, T0>(arg1, arg2, &0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0).cap, arg3, v5, arg4, arg6, arg7);
        let v7 = 0x2::coin::value<T0>(&v6);
        0x2::balance::join<T0>(&mut arg0.idle, 0x2::coin::into_balance<T0>(v6));
        arg0.nonce = arg0.nonce + 1;
        let v8 = Pulled{
            vault_id       : 0x2::object::id<Vault<T0>>(arg0),
            market         : v0,
            amount         : v7,
            position_after : position_value<T0, T1>(arg0, arg2, arg6),
        };
        0x2::event::emit<Pulled>(v8);
        v7
    }

    public fun remove_market<T0, T1>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>) : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap {
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0), 7);
        assert!(position_ctokens<T0, T1>(arg0, arg2) == 0, 13);
        let Allocation {
            market_id        : _,
            cap              : v2,
            supply_cap       : _,
            min_alloc        : _,
            rate_ceiling_bps : _,
            enabled          : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, Allocation>(&mut arg0.allocations, v0);
        let (v7, v8) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.market_order, &v0);
        if (v7) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.market_order, v8);
        };
        arg0.nonce = arg0.nonce + 1;
        let v9 = MarketRemoved{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            market   : v0,
        };
        0x2::event::emit<MarketRemoved>(v9);
        v2
    }

    public fun request_withdraw<T0>(arg0: &mut Vault<T0>, arg1: NavReceipt<T0>, arg2: 0x2::coin::Coin<VaultShare<T0>>, arg3: &mut 0x2::tx_context::TxContext) : WithdrawTicket<T0> {
        assert!(!arg0.withdrawals_paused, 3);
        let v0 = consume_receipt<T0>(arg0, arg1);
        let v1 = accrue_fee<T0>(arg0, v0, arg3);
        let v2 = 0x2::coin::value<VaultShare<T0>>(&arg2);
        assert!(v2 > 0, 14);
        let v3 = mul_div(v2, v1 + 1, 0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares) + 1);
        0x2::balance::decrease_supply<VaultShare<T0>>(&mut arg0.shares, 0x2::coin::into_balance<VaultShare<T0>>(arg2));
        arg0.nonce = arg0.nonce + 1;
        let v4 = Withdrawn{
            vault_id     : 0x2::object::id<Vault<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg3),
            assets       : v3,
            shares       : v2,
            total_assets : v1 - v3,
        };
        0x2::event::emit<Withdrawn>(v4);
        WithdrawTicket<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            owed     : v3,
        }
    }

    public fun restore_market<T0, T1>(arg0: &mut Vault<T0>, arg1: &OwnerCap) {
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0) && !0x1::vector::contains<0x1::type_name::TypeName>(&arg0.market_order, &v0), 7);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.market_order, v0);
        arg0.nonce = arg0.nonce + 1;
    }

    public fun revoke_role<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: 0x2::object::ID) {
        assert_owner<T0>(arg0, arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allocators, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allocators, &arg2);
        };
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.guardians, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.guardians, &arg2);
        };
    }

    public fun set_deposit_cap<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: u64) {
        assert_owner<T0>(arg0, arg1);
        arg0.deposit_cap = arg2;
    }

    public fun set_fee<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: NavReceipt<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, arg1);
        assert!(arg3 <= 3000, 16);
        let v0 = consume_receipt<T0>(arg0, arg2);
        accrue_fee<T0>(arg0, v0, arg5);
        arg0.perf_fee_bps = arg3;
        arg0.fee_recipient = arg4;
    }

    fun set_pause_flags<T0>(arg0: &mut Vault<T0>, arg1: bool, arg2: bool, arg3: bool) {
        arg0.deposits_paused = arg1;
        arg0.withdrawals_paused = arg2;
        arg0.allocations_paused = arg3;
        let v0 = PauseChanged{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            deposits    : arg1,
            withdrawals : arg2,
            allocations : arg3,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_paused<T0>(arg0: &mut Vault<T0>, arg1: &OwnerCap, arg2: bool, arg3: bool, arg4: bool) {
        assert_owner<T0>(arg0, arg1);
        set_pause_flags<T0>(arg0, arg2, arg3, arg4);
    }

    public fun share_registry(arg0: Registry) {
        0x2::transfer::share_object<Registry>(arg0);
    }

    public fun share_vault<T0>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun start_nav<T0>(arg0: &Vault<T0>) : NavReceipt<T0> {
        NavReceipt<T0>{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            nonce    : arg0.nonce,
            seen     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            total    : 0x2::balance::value<T0>(&arg0.idle),
        }
    }

    public fun supply<T0, T1>(arg0: &mut Vault<T0>, arg1: &AllocatorCap, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_allocator<T0>(arg0, arg1);
        assert!(!arg0.allocations_paused, 4);
        assert!(arg4 > 0, 14);
        assert!(0x2::balance::value<T0>(&arg0.idle) >= arg4, 12);
        let v0 = checked_key<T0, T1>(arg0, arg3);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0).enabled, 10);
        assert!(position_value<T0, T1>(arg0, arg3, arg5) + arg4 <= 0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0).supply_cap, 11);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::deposit::deposit<T1, T0>(arg2, arg3, &0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0).cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle, arg4), arg6), arg5, arg6);
        arg0.nonce = arg0.nonce + 1;
        assert!(position_ctokens<T0, T1>(arg0, arg3) > position_ctokens<T0, T1>(arg0, arg3), 20);
        let v1 = Supplied{
            vault_id       : 0x2::object::id<Vault<T0>>(arg0),
            market         : v0,
            amount         : arg4,
            position_after : position_value<T0, T1>(arg0, arg3, arg5),
        };
        0x2::event::emit<Supplied>(v1);
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::supply_value<VaultShare<T0>>(&arg0.shares)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: NavReceipt<T0>, arg2: 0x2::coin::Coin<VaultShare<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = request_withdraw<T0>(arg0, arg1, arg2, arg3);
        complete_withdraw<T0>(arg0, v0, arg3)
    }

    public fun withdraw_with_pull<T0, T1>(arg0: &mut Vault<T0>, arg1: NavReceipt<T0>, arg2: 0x2::coin::Coin<VaultShare<T0>>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T1>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = request_withdraw<T0>(arg0, arg1, arg2, arg8);
        pull_for_withdraw<T0, T1>(arg0, &v0, arg3, arg4, arg5, arg6, 18446744073709551615, arg7, arg8);
        complete_withdraw<T0>(arg0, v0, arg8)
    }

    public fun write_off_market<T0, T1>(arg0: &mut Vault<T0>, arg1: &OwnerCap) {
        assert_owner<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0), 7);
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.market_order, &v0);
        assert!(v1, 21);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.market_order, v2);
        0x2::table::borrow_mut<0x1::type_name::TypeName, Allocation>(&mut arg0.allocations, v0).enabled = false;
        arg0.nonce = arg0.nonce + 1;
        let v3 = 0x2::table::borrow<0x1::type_name::TypeName, Allocation>(&arg0.allocations, v0);
        let v4 = MarketConfigured{
            vault_id         : 0x2::object::id<Vault<T0>>(arg0),
            market           : v0,
            supply_cap       : v3.supply_cap,
            min_alloc        : v3.min_alloc,
            rate_ceiling_bps : v3.rate_ceiling_bps,
            enabled          : false,
        };
        0x2::event::emit<MarketConfigured>(v4);
    }

    // decompiled from Move bytecode v7
}

