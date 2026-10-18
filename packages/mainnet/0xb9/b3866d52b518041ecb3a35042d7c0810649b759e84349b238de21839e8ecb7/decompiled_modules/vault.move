module 0x1bcdd543a7850ea81f01981671c66a11bd3f94a1ef08d297a2fb90d8ef5d8cc5::vault {
    struct AssetConfig has copy, drop, store {
        stable: 0x1::type_name::TypeName,
        source_name: 0x1::string::String,
        source_type: 0x1::type_name::TypeName,
        asset_index: u8,
        market: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        admin: address,
        fee_wallet: address,
        stables: vector<AssetConfig>,
        total_vaults: u64,
        paused: bool,
    }

    struct Slice has copy, drop, store {
        amount: u64,
        unlock_ms: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        retired: bool,
        target_type: 0x1::type_name::TypeName,
        cetus_pool: 0x2::object::ID,
        pool: 0x2::balance::Balance<T0>,
        interest_available: u64,
        deposits: vector<Slice>,
        last_harvest_ms: u64,
        principal_total: u64,
        withdrawn_total: u64,
        total_interest: u64,
        total_keeper_fees: u64,
        total_service_fees: u64,
        swap_count: u64,
        asset: AssetConfig,
        ctokens: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>,
        principal_in_market: u64,
        circuit_broken: bool,
        break_reason: 0x1::string::String,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        target_type: 0x1::type_name::TypeName,
        initial_deposit: u64,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        unlock_ms: u64,
    }

    struct InterestReceived has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        interest: u64,
        keeper_fee: u64,
        fee: u64,
        keeper: address,
    }

    struct SwapSettled has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        target_type: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct InterestWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        remaining: u64,
    }

    struct VaultRetired has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct CircuitBroken has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        reason: 0x1::string::String,
    }

    struct CircuitCleared has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct TargetChanged has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        new_target: 0x1::type_name::TypeName,
    }

    struct CetusPoolChanged has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        new_pool: 0x2::object::ID,
    }

    struct FeeWalletUpdated has copy, drop {
        old: address,
        new: address,
    }

    struct AdminTransferred has copy, drop {
        old: address,
        new: address,
    }

    struct PauseToggled has copy, drop {
        paused: bool,
    }

    struct StableAdded has copy, drop {
        stable: 0x1::type_name::TypeName,
        source_name: 0x1::string::String,
        source_type: 0x1::type_name::TypeName,
        asset_index: u8,
        market: 0x2::object::ID,
    }

    struct ContactRequest has copy, drop {
        from: address,
        message: 0x1::string::String,
        at_ms: u64,
    }

    public fun accounting_of<T0>(arg0: &Vault<T0>) : (u64, u64, u64, u64, u64) {
        (arg0.principal_total, arg0.withdrawn_total, arg0.total_interest, arg0.total_keeper_fees, arg0.total_service_fees)
    }

    public fun add_stable<T0>(arg0: &mut Registry, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::type_name::TypeName, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(arg4 != v0, 17);
        let v1 = 0;
        while (v1 < 0x1::vector::length<AssetConfig>(&arg0.stables)) {
            assert!(0x1::vector::borrow<AssetConfig>(&arg0.stables, v1).stable != v0, 16);
            v1 = v1 + 1;
        };
        let v2 = 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg1);
        let v3 = AssetConfig{
            stable      : v0,
            source_name : arg3,
            source_type : arg4,
            asset_index : arg2,
            market      : v2,
        };
        0x1::vector::push_back<AssetConfig>(&mut arg0.stables, v3);
        let v4 = StableAdded{
            stable      : v0,
            source_name : arg3,
            source_type : arg4,
            asset_index : arg2,
            market      : v2,
        };
        0x2::event::emit<StableAdded>(v4);
    }

    public fun admin_of(arg0: &Registry) : address {
        arg0.admin
    }

    fun apply_withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg1 <= arg2) {
            arg1
        } else {
            arg2
        };
        if (v0 > 0) {
            let v1 = &mut arg0.deposits;
            consume_unlocked(v1, v0, arg3);
            arg0.withdrawn_total = arg0.withdrawn_total + v0;
        };
        let v2 = arg1 - v0;
        if (v2 > 0) {
            arg0.interest_available = arg0.interest_available - v2;
        };
    }

    fun assert_admin(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        let v0 = arg0.admin;
        assert!(v0 != @0x0 && 0x2::tx_context::sender(arg1) == v0, 0);
    }

    fun assert_market(arg0: &AssetConfig, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        assert!(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(arg1) == arg0.market, 32);
    }

    fun assert_stable<T0>(arg0: &Registry) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AssetConfig>(&arg0.stables)) {
            if (0x1::vector::borrow<AssetConfig>(&arg0.stables, v0).stable == 0x1::type_name::with_defining_ids<T0>()) {
                return
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun asset_config<T0>(arg0: &Registry) : AssetConfig {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AssetConfig>(&arg0.stables)) {
            let v1 = 0x1::vector::borrow<AssetConfig>(&arg0.stables, v0);
            if (v1.stable == 0x1::type_name::with_defining_ids<T0>()) {
                return *v1
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun asset_config_of<T0>(arg0: &Vault<T0>) : AssetConfig {
        arg0.asset
    }

    public fun cetus_pool_of<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.cetus_pool
    }

    public fun circuit_break<T0>(arg0: &Registry, arg1: &mut Vault<T0>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.retired, 26);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.owner || v0 == arg0.admin, 23);
        assert!(!arg1.circuit_broken, 3);
        arg1.circuit_broken = true;
        arg1.break_reason = arg2;
        let v1 = CircuitBroken{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            owner    : arg1.owner,
            reason   : arg2,
        };
        0x2::event::emit<CircuitBroken>(v1);
    }

    public fun circuit_status_of<T0>(arg0: &Vault<T0>) : (bool, 0x1::string::String) {
        (arg0.circuit_broken, arg0.break_reason)
    }

    public fun clear_circuit<T0>(arg0: &Registry, arg1: &mut Vault<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_stable<T0>(arg0);
        assert!(!arg1.retired, 26);
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 5);
        assert!(arg1.circuit_broken, 22);
        arg1.circuit_broken = false;
        arg1.break_reason = 0x1::string::utf8(b"");
        let v0 = CircuitCleared{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            owner    : arg1.owner,
        };
        0x2::event::emit<CircuitCleared>(v0);
    }

    fun compact_unlocked(arg0: &mut vector<Slice>, arg1: u64) {
        let v0 = 0x1::vector::length<Slice>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<Slice>(arg0, v1);
            if (v3.unlock_ms > arg1) {
                break
            };
            v2 = v2 + v3.amount;
            v1 = v1 + 1;
        };
        if (v1 <= 1) {
            return
        };
        let v4 = 0;
        if (v0 > 0) {
            v4 = 0x1::vector::borrow<Slice>(arg0, 0).unlock_ms;
        };
        let v5 = 0x1::vector::empty<Slice>();
        let v6 = v1;
        while (v6 < v0) {
            0x1::vector::push_back<Slice>(&mut v5, *0x1::vector::borrow<Slice>(arg0, v6));
            v6 = v6 + 1;
        };
        while (!0x1::vector::is_empty<Slice>(arg0)) {
            0x1::vector::pop_back<Slice>(arg0);
        };
        let v7 = Slice{
            amount    : v2,
            unlock_ms : v4,
        };
        0x1::vector::push_back<Slice>(arg0, v7);
        0x1::vector::append<Slice>(arg0, v5);
    }

    fun consume_unlocked(arg0: &mut vector<Slice>, arg1: u64, arg2: u64) {
        let v0 = arg1;
        while (v0 > 0 && !0x1::vector::is_empty<Slice>(arg0)) {
            let v1 = *0x1::vector::borrow<Slice>(arg0, 0);
            if (v1.unlock_ms > arg2) {
                break
            };
            if (v1.amount <= v0) {
                0x1::vector::remove<Slice>(arg0, 0);
                v0 = v0 - v1.amount;
                continue
            };
            0x1::vector::borrow_mut<Slice>(arg0, 0).amount = v1.amount - v0;
            v0 = 0;
        };
    }

    public fun contact_request(arg0: &Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 15);
        assert!(0x1::string::length(&arg2) <= 200, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_wallet);
        let v0 = ContactRequest{
            from    : 0x2::tx_context::sender(arg4),
            message : arg2,
            at_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ContactRequest>(v0);
    }

    public fun create_vault<T0>(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::type_name::TypeName, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        let v0 = asset_config<T0>(arg0);
        assert_market(&v0, arg2);
        assert!(arg4 != v0.stable, 13);
        assert!(arg5 != 0x2::object::id_from_address(@0x0), 21);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 > 0, 4);
        let v3 = 0x2::clock::timestamp_ms(arg1);
        let v4 = v3 + 604800000;
        let v5 = Slice{
            amount    : v2,
            unlock_ms : v4,
        };
        let v6 = 0x1::vector::empty<Slice>();
        0x1::vector::push_back<Slice>(&mut v6, v5);
        let v7 = Vault<T0>{
            id                  : 0x2::object::new(arg6),
            owner               : v1,
            retired             : false,
            target_type         : arg4,
            cetus_pool          : arg5,
            pool                : 0x2::balance::zero<T0>(),
            interest_available  : 0,
            deposits            : v6,
            last_harvest_ms     : v3,
            principal_total     : v2,
            withdrawn_total     : 0,
            total_interest      : 0,
            total_keeper_fees   : 0,
            total_service_fees  : 0,
            swap_count          : 0,
            asset               : v0,
            ctokens             : 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg2, ext_u8_to_u64(v0.asset_index), arg1, arg3, arg6)),
            principal_in_market : v2,
            circuit_broken      : false,
            break_reason        : 0x1::string::utf8(b""),
        };
        let v8 = 0x2::object::uid_to_inner(&v7.id);
        0x2::transfer::share_object<Vault<T0>>(v7);
        arg0.total_vaults = arg0.total_vaults + 1;
        let v9 = VaultCreated{
            vault_id        : v8,
            owner           : v1,
            target_type     : arg4,
            initial_deposit : v2,
        };
        0x2::event::emit<VaultCreated>(v9);
        let v10 = Deposited{
            vault_id  : v8,
            owner     : v1,
            amount    : v2,
            unlock_ms : v4,
        };
        0x2::event::emit<Deposited>(v10);
    }

    fun credit_interest<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 8);
        let v1 = 0x2::tx_context::sender(arg4);
        if (v1 != arg2.owner) {
            assert!(v0 >= 1000000, 8);
        };
        let v2 = 0;
        let v3 = (((v0 as u128) * (50 as u128) / (10000 as u128)) as u64);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v1);
            v2 = v3;
        };
        let v4 = (((0x2::coin::value<T0>(&arg3) as u128) * (50 as u128) / (10000 as u128)) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v4, arg4), arg0.fee_wallet);
        };
        let v5 = 0x2::coin::value<T0>(&arg3);
        assert!(v5 > 0, 8);
        0x2::balance::join<T0>(&mut arg2.pool, 0x2::coin::into_balance<T0>(arg3));
        arg2.interest_available = arg2.interest_available + v5;
        arg2.total_interest = arg2.total_interest + v0;
        arg2.total_keeper_fees = arg2.total_keeper_fees + v2;
        arg2.total_service_fees = arg2.total_service_fees + v4;
        arg2.last_harvest_ms = 0x2::clock::timestamp_ms(arg1);
        let v6 = InterestReceived{
            vault_id   : 0x2::object::uid_to_inner(&arg2.id),
            owner      : arg2.owner,
            interest   : v0,
            keeper_fee : v2,
            fee        : v4,
            keeper     : v1,
        };
        0x2::event::emit<InterestReceived>(v6);
    }

    public fun ctokens_of<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&arg0.ctokens)
    }

    public fun deposit<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        assert_stable<T0>(arg0);
        assert!(!arg2.retired, 26);
        assert!(0x2::tx_context::sender(arg5) == arg2.owner, 5);
        assert!(!arg2.circuit_broken, 3);
        assert_market(&arg2.asset, arg3);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = &mut arg2.deposits;
        ensure_slice_room(v2, v1);
        let v3 = v1 + 604800000;
        0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&mut arg2.ctokens, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, ext_u8_to_u64(arg2.asset.asset_index), arg1, arg4, arg5)));
        let v4 = Slice{
            amount    : v0,
            unlock_ms : v3,
        };
        0x1::vector::push_back<Slice>(&mut arg2.deposits, v4);
        arg2.principal_total = arg2.principal_total + v0;
        arg2.principal_in_market = arg2.principal_in_market + v0;
        let v5 = Deposited{
            vault_id  : 0x2::object::uid_to_inner(&arg2.id),
            owner     : arg2.owner,
            amount    : v0,
            unlock_ms : v3,
        };
        0x2::event::emit<Deposited>(v5);
    }

    public fun destroy_vault<T0>(arg0: &mut Registry, arg1: &mut Vault<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_stable<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 5);
        assert!(!arg1.retired, 26);
        assert!(arg1.principal_total == arg1.withdrawn_total, 10);
        assert!(0x1::vector::is_empty<Slice>(&arg1.deposits), 10);
        assert!(0x2::balance::value<T0>(&arg1.pool) == 0, 10);
        assert!(arg1.interest_available == 0, 10);
        assert!(arg1.principal_in_market == 0, 10);
        assert!(0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&arg1.ctokens) == 0, 10);
        arg1.retired = true;
        arg0.total_vaults = arg0.total_vaults - 1;
        let v0 = VaultRetired{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            owner    : arg1.owner,
        };
        0x2::event::emit<VaultRetired>(v0);
    }

    fun do_swap<T0, T1>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_stable<T0>(arg0);
        assert!(!arg2.retired, 26);
        assert!(!arg2.circuit_broken, 3);
        assert!(!arg0.paused, 9);
        assert!(arg2.target_type == 0x1::type_name::with_defining_ids<T1>(), 7);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5) == arg2.cetus_pool, 31);
        if ((0x2::tx_context::sender(arg6) == arg2.owner || 0x2::clock::timestamp_ms(arg1) >= arg2.last_harvest_ms + 3600000) && arg2.principal_in_market > 0) {
            harvest_market<T0>(arg0, arg1, arg2, arg3, arg6);
        };
        if (0x2::balance::value<T0>(&arg2.pool) < arg2.interest_available && arg2.principal_in_market > 0) {
            let v0 = arg2.principal_in_market;
            settle_and_redeposit<T0>(arg0, arg1, arg2, arg3, v0, true, arg6);
            if (0x2::balance::value<T0>(&arg2.pool) < arg2.interest_available) {
                let v1 = arg2.principal_in_market;
                settle_and_redeposit<T0>(arg0, arg1, arg2, arg3, v1, false, arg6);
            };
        };
        let v2 = 0x2::balance::value<T0>(&arg2.pool);
        let v3 = if (arg2.interest_available < v2) {
            arg2.interest_available
        } else {
            v2
        };
        assert!(v3 > 0, 8);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, true, true, v3);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4);
        assert!(v5 > 0, 20);
        let v6 = (((v5 as u128) * ((10000 - 200) as u128) / (10000 as u128)) as u64);
        assert!(v6 > 0, 20);
        let v7 = 0x2::balance::split<T0>(&mut arg2.pool, v3);
        let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg5, true, true, v3, 0, arg1);
        let v11 = v10;
        let v12 = v9;
        0x2::balance::destroy_zero<T0>(v8);
        assert!(0x2::balance::value<T1>(&v12) >= v6, 20);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v11);
        assert!(v13 <= 0x2::balance::value<T0>(&v7), 8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg5, 0x2::balance::split<T0>(&mut v7, v13), 0x2::balance::zero<T1>(), v11);
        0x2::balance::join<T0>(&mut arg2.pool, v7);
        let v14 = 0x2::balance::value<T0>(&arg2.pool) - 0x2::balance::value<T0>(&arg2.pool);
        assert!(v14 <= arg2.interest_available, 12);
        arg2.interest_available = arg2.interest_available - v14;
        arg2.swap_count = arg2.swap_count + 1;
        let v15 = SwapSettled{
            vault_id    : 0x2::object::uid_to_inner(&arg2.id),
            owner       : arg2.owner,
            target_type : arg2.target_type,
            amount_in   : v14,
            amount_out  : 0x2::balance::value<T1>(&v12),
        };
        0x2::event::emit<SwapSettled>(v15);
        0x2::coin::from_balance<T1>(v12, arg6)
    }

    fun ensure_slice_room(arg0: &mut vector<Slice>, arg1: u64) {
        if (0x1::vector::length<Slice>(arg0) < 64) {
            return
        };
        compact_unlocked(arg0, arg1);
        assert!(0x1::vector::length<Slice>(arg0) < 64, 18);
    }

    fun ext_u8_to_u64(arg0: u8) : u64 {
        (arg0 as u64)
    }

    public fun fee_bps() : u64 {
        50
    }

    public fun fee_wallet_of(arg0: &Registry) : address {
        arg0.fee_wallet
    }

    public fun harvest_and_swap<T0, T1>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(do_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    public fun harvest_and_swap_to<T0, T1>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg6) == arg2.owner, 5);
        do_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun harvest_interval_ms() : u64 {
        0
    }

    public fun harvest_market<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 9);
        assert_stable<T0>(arg0);
        assert!(!arg2.retired, 26);
        assert!(!arg2.circuit_broken, 3);
        assert_market(&arg2.asset, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        if (v0 != arg2.owner) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg2.last_harvest_ms + 3600000, 34);
        };
        let v1 = arg2.principal_in_market;
        let v2 = settle_and_redeposit<T0>(arg0, arg1, arg2, arg3, v1, true, arg4);
        arg2.last_harvest_ms = 0x2::clock::timestamp_ms(arg1);
        if (v0 != arg2.owner) {
            assert!(v2 >= 1000000, 35);
        };
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Registry{
            id           : 0x2::object::new(arg0),
            admin        : v0,
            fee_wallet   : v0,
            stables      : 0x1::vector::empty<AssetConfig>(),
            total_vaults : 0,
            paused       : false,
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun interest_available_of<T0>(arg0: &Vault<T0>) : u64 {
        arg0.interest_available
    }

    public fun is_admin_renounced(arg0: &Registry) : bool {
        arg0.admin == @0x0
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun is_retired<T0>(arg0: &Vault<T0>) : bool {
        arg0.retired
    }

    public fun is_stable<T0>(arg0: &Registry) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AssetConfig>(&arg0.stables)) {
            if (0x1::vector::borrow<AssetConfig>(&arg0.stables, v0).stable == 0x1::type_name::with_defining_ids<T0>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun keeper_fee_bps() : u64 {
        50
    }

    public fun last_harvest_at<T0>(arg0: &Vault<T0>) : u64 {
        arg0.last_harvest_ms
    }

    public fun liabilities_of<T0>(arg0: &Vault<T0>) : u64 {
        arg0.principal_total - arg0.withdrawn_total + arg0.interest_available
    }

    public fun lock_ms() : u64 {
        604800000
    }

    fun locked_amount(arg0: &vector<Slice>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Slice>(arg0)) {
            let v2 = 0x1::vector::borrow<Slice>(arg0, v1);
            if (v2.unlock_ms > arg1) {
                v0 = v0 + v2.amount;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun locked_of<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        locked_amount(&arg0.deposits, arg1)
    }

    public fun market_of<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.asset.market
    }

    public fun max_slices() : u64 {
        64
    }

    public fun min_interest_to_harvest() : u64 {
        1000000
    }

    public fun min_settle_interval_ms() : u64 {
        3600000
    }

    fun normalize_hex(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0;
        let v2 = if (v0 >= 2) {
            if (*0x1::vector::borrow<u8>(&arg0, 0) == 48) {
                *0x1::vector::borrow<u8>(&arg0, 1) == 120 || *0x1::vector::borrow<u8>(&arg0, 1) == 88
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            v1 = 2;
        };
        while (v1 < v0 && *0x1::vector::borrow<u8>(&arg0, v1) == 48) {
            v1 = v1 + 1;
        };
        let v3 = b"";
        while (v1 < v0) {
            let v4 = *0x1::vector::borrow<u8>(&arg0, v1);
            let v5 = if (v4 >= 65 && v4 <= 70) {
                v4 + 32
            } else {
                v4
            };
            0x1::vector::push_back<u8>(&mut v3, v5);
            v1 = v1 + 1;
        };
        v3
    }

    public fun owner_of<T0>(arg0: &Vault<T0>) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut Registry, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.paused = arg1;
        let v0 = PauseToggled{paused: arg1};
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun pool_of<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun principal_in_market_of<T0>(arg0: &Vault<T0>) : u64 {
        arg0.principal_in_market
    }

    public fun receive_interest<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        assert_stable<T0>(arg0);
        assert!(!arg2.retired, 26);
        assert!(!arg2.circuit_broken, 3);
        credit_interest<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun redeem_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert_market(&arg0.asset, arg1);
        let v0 = 0x2::balance::withdraw_all<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&mut arg0.ctokens);
        if (0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v0) == 0) {
            0x2::balance::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v0);
            return 0
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, ext_u8_to_u64(arg0.asset.asset_index), arg2, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(v0, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg3);
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(v1));
        arg0.principal_in_market = 0;
        0x2::coin::value<T0>(&v1)
    }

    fun redeposit<T0>(arg0: &mut Vault<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 0) {
            return
        };
        assert_market(&arg0.asset, arg1);
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg3, 12);
        0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&mut arg0.ctokens, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg1, ext_u8_to_u64(arg0.asset.asset_index), arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg3), arg4), arg4)));
        arg0.principal_in_market = arg0.principal_in_market + arg3;
    }

    fun redeposit_remaining<T0>(arg0: &mut Vault<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.principal_total - arg0.withdrawn_total;
        let v1 = 0x2::balance::value<T0>(&arg0.pool);
        let v2 = arg0.interest_available;
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v4 = if (v0 < v3) {
            v0
        } else {
            v3
        };
        redeposit<T0>(arg0, arg1, arg2, v4, arg3);
    }

    public fun renounce_admin(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(!arg0.paused, 9);
        arg0.admin = @0x0;
        let v0 = AdminTransferred{
            old : arg0.admin,
            new : @0x0,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    fun same_coin_type(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : bool {
        let (v0, v1) = split_coin_type(0x1::ascii::into_bytes(arg0));
        let (v2, v3) = split_coin_type(0x1::ascii::into_bytes(arg1));
        v1 == v3 && same_hex_addr(v0, v2)
    }

    fun same_hex_addr(arg0: vector<u8>, arg1: vector<u8>) : bool {
        normalize_hex(arg0) == normalize_hex(arg1)
    }

    public fun set_cetus_pool<T0>(arg0: &Registry, arg1: &mut Vault<T0>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_stable<T0>(arg0);
        assert!(!arg1.retired, 26);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 5);
        assert!(arg2 != 0x2::object::id_from_address(@0x0), 21);
        assert!(arg2 != arg1.cetus_pool, 13);
        arg1.cetus_pool = arg2;
        let v0 = CetusPoolChanged{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            owner    : arg1.owner,
            new_pool : arg2,
        };
        0x2::event::emit<CetusPoolChanged>(v0);
    }

    public fun set_fee_wallet(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 21);
        arg0.fee_wallet = arg1;
        let v0 = FeeWalletUpdated{
            old : arg0.fee_wallet,
            new : arg1,
        };
        0x2::event::emit<FeeWalletUpdated>(v0);
    }

    public fun set_target<T0>(arg0: &Registry, arg1: &mut Vault<T0>, arg2: 0x1::type_name::TypeName, arg3: &0x2::tx_context::TxContext) {
        assert_stable<T0>(arg0);
        assert!(!arg1.retired, 26);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 5);
        assert!(arg2 != arg1.asset.stable, 13);
        assert!(arg2 != arg1.target_type, 13);
        arg1.target_type = arg2;
        let v0 = TargetChanged{
            vault_id   : 0x2::object::uid_to_inner(&arg1.id),
            owner      : arg1.owner,
            new_target : arg2,
        };
        0x2::event::emit<TargetChanged>(v0);
    }

    fun settle_and_redeposit<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = redeem_all<T0>(arg2, arg3, arg1, arg6);
        assert!(v0 >= arg4, 30);
        let v1 = v0 - arg4;
        if (v1 > 0) {
            let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool, v1), arg6);
            credit_interest<T0>(arg0, arg1, arg2, v2, arg6);
        };
        if (arg5) {
            redeposit_remaining<T0>(arg2, arg3, arg1, arg6);
        };
        v1
    }

    public fun slice_count_of<T0>(arg0: &Vault<T0>) : u64 {
        0x1::vector::length<Slice>(&arg0.deposits)
    }

    fun split_coin_type(arg0: vector<u8>) : (vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = v0;
        let v2 = 0;
        while (v2 + 1 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v2) == 58 && *0x1::vector::borrow<u8>(&arg0, v2 + 1) == 58) {
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        let v3 = b"";
        let v4 = b"";
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&arg0, v5));
            v5 = v5 + 1;
        };
        while (v5 < v0) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&arg0, v5));
            v5 = v5 + 1;
        };
        (v3, v4)
    }

    public fun stables_of(arg0: &Registry) : vector<AssetConfig> {
        arg0.stables
    }

    public fun swap_count_of<T0>(arg0: &Vault<T0>) : u64 {
        arg0.swap_count
    }

    public fun target_of<T0>(arg0: &Vault<T0>) : 0x1::type_name::TypeName {
        arg0.target_type
    }

    public fun total_assets_of<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool) + arg0.principal_in_market
    }

    public fun total_vaults_of(arg0: &Registry) : u64 {
        arg0.total_vaults
    }

    public fun transfer_admin(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 21);
        arg0.admin = arg1;
        let v0 = AdminTransferred{
            old : arg0.admin,
            new : arg1,
        };
        0x2::event::emit<AdminTransferred>(v0);
    }

    public fun type_name_of<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    fun unlocked_amount(arg0: &vector<Slice>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Slice>(arg0)) {
            let v2 = 0x1::vector::borrow<Slice>(arg0, v1);
            if (v2.unlock_ms <= arg1) {
                v0 = v0 + v2.amount;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun unlocked_of<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        unlocked_amount(&arg0.deposits, arg1)
    }

    public fun withdraw<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_stable<T0>(arg0);
        assert!(!arg2.retired, 26);
        assert!(0x2::tx_context::sender(arg4) == arg2.owner, 5);
        assert!(arg3 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = unlocked_amount(&arg2.deposits, v0);
        assert!(arg3 <= v1 + arg2.interest_available, 1);
        let v2 = 0x2::balance::value<T0>(&arg2.pool);
        assert!(v2 >= arg3, 29);
        apply_withdraw<T0>(arg2, arg3, v1, v0);
        let v3 = arg2.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool, arg3), arg4), v3);
        let v4 = Withdrawn{
            vault_id  : 0x2::object::uid_to_inner(&arg2.id),
            owner     : v3,
            amount    : arg3,
            remaining : v2 - arg3,
        };
        0x2::event::emit<Withdrawn>(v4);
    }

    public fun withdraw_interest<T0>(arg0: &Registry, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.pool) >= arg2, 29);
        assert_stable<T0>(arg0);
        assert!(!arg1.retired, 26);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 5);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= arg1.interest_available, 8);
        arg1.interest_available = arg1.interest_available - arg2;
        let v0 = arg1.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), v0);
        let v1 = InterestWithdrawn{
            vault_id : 0x2::object::uid_to_inner(&arg1.id),
            owner    : v0,
            amount   : arg2,
        };
        0x2::event::emit<InterestWithdrawn>(v1);
    }

    public fun withdraw_interest_with_market<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg2.pool) < arg4) {
            let v0 = arg2.principal_in_market;
            settle_and_redeposit<T0>(arg0, arg1, arg2, arg3, v0, false, arg5);
        };
        withdraw_interest<T0>(arg0, arg2, arg4, arg5);
        redeposit_remaining<T0>(arg2, arg3, arg1, arg5);
    }

    public fun withdraw_to<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_stable<T0>(arg0);
        assert!(!arg2.retired, 26);
        assert!(0x2::tx_context::sender(arg4) == arg2.owner, 5);
        assert!(arg3 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = unlocked_amount(&arg2.deposits, v0);
        assert!(arg3 <= v1 + arg2.interest_available, 1);
        assert!(0x2::balance::value<T0>(&arg2.pool) >= arg3, 29);
        apply_withdraw<T0>(arg2, arg3, v1, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool, arg3), arg4)
    }

    public fun withdraw_to_with_market<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::balance::value<T0>(&arg2.pool) < arg4) {
            let v0 = arg2.principal_in_market;
            settle_and_redeposit<T0>(arg0, arg1, arg2, arg3, v0, false, arg5);
        };
        let v1 = withdraw_to<T0>(arg0, arg1, arg2, arg4, arg5);
        redeposit_remaining<T0>(arg2, arg3, arg1, arg5);
        v1
    }

    public fun withdraw_with_market<T0>(arg0: &Registry, arg1: &0x2::clock::Clock, arg2: &mut Vault<T0>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg2.pool) < arg4) {
            let v0 = arg2.principal_in_market;
            settle_and_redeposit<T0>(arg0, arg1, arg2, arg3, v0, false, arg5);
        };
        withdraw<T0>(arg0, arg1, arg2, arg4, arg5);
        redeposit_remaining<T0>(arg2, arg3, arg1, arg5);
    }

    // decompiled from Move bytecode v7
}

