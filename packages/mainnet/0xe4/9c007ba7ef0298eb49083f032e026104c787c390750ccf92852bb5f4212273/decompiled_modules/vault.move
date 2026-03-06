module 0xe49c007ba7ef0298eb49083f032e026104c787c390750ccf92852bb5f4212273::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        heir: address,
        period_ms: u64,
        last_confirmed_at: u64,
        yield_strategy: u8,
        asset_kind: u8,
        principal_amount: u64,
        scallop_pool_id: 0x1::option::Option<u64>,
        settled_at: 0x1::option::Option<u64>,
        settled_by: 0x1::option::Option<address>,
        is_active: bool,
    }

    struct VaultOwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopCoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        heir: address,
        period_ms: u64,
        yield_strategy: u8,
        asset_kind: u8,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct HeartbeatConfirmed has copy, drop {
        vault_id: 0x2::object::ID,
        confirmed_at: u64,
        next_deadline: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct VaultSettled has copy, drop {
        vault_id: 0x2::object::ID,
        heir: address,
        triggered_by: address,
        principal_coin_type: vector<u8>,
        principal_amount: u64,
        reward_amount: u64,
        settled_at: u64,
    }

    struct VaultDeactivated has copy, drop {
        vault_id: 0x2::object::ID,
        reason: vector<u8>,
    }

    struct HeirUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_heir: address,
        new_heir: address,
    }

    struct PeriodUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_period_ms: u64,
        new_period_ms: u64,
    }

    struct VaultClosed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        closed_by: address,
    }

    fun assert_owner(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
    }

    fun assert_vault_asset_match<T0>(arg0: &Vault) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = if (arg0.asset_kind == 0 && v0 == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") {
            true
        } else if (arg0.asset_kind == 1 && v0 == b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL") {
            true
        } else if (arg0.asset_kind == 2 && v0 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC") {
            true
        } else {
            arg0.asset_kind == 3 && v0 == b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT"
        };
        assert!(v1, 9);
    }

    fun asset_kind_for_type<T0>() : u8 {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (v0 == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") {
            0
        } else if (v0 == b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL") {
            1
        } else if (v0 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC") {
            2
        } else {
            assert!(v0 == b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT", 8);
            3
        }
    }

    fun asset_type_name_for_kind(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"
        } else if (arg0 == 1) {
            b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL"
        } else if (arg0 == 2) {
            b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"
        } else {
            assert!(arg0 == 3, 8);
            b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT"
        }
    }

    public entry fun claim<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        settle<T0>(arg0, arg1, arg2);
    }

    fun claim_amount_no_yield<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 7);
        let v1 = 0x2::dynamic_field::remove<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), arg0.heir);
        arg0.principal_amount = 0;
        0x2::balance::value<T0>(&v1)
    }

    fun claim_amount_scallop<T0>(arg0: &mut Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = ScallopCoinKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ScallopCoinKey<T0>>(&arg0.id, v0)) {
            assert!(arg0.principal_amount == 0, 7);
            return 0
        };
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::remove<ScallopCoinKey<T0>, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v0), arg4), arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg0.heir);
        arg0.principal_amount = 0;
        0x2::coin::value<T0>(&v1)
    }

    public entry fun claim_with_yield<T0>(arg0: &mut Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        settle_with_yield<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun close_amount_no_yield<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::remove<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), arg0.owner);
            arg0.principal_amount = 0;
            0x2::balance::value<T0>(&v2)
        } else {
            arg0.principal_amount = 0;
            0
        }
    }

    fun close_amount_scallop<T0>(arg0: &mut Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = ScallopCoinKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ScallopCoinKey<T0>>(&arg0.id, v0)) {
            arg0.principal_amount = 0;
            return 0
        };
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::remove<ScallopCoinKey<T0>, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v0), arg4), arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg0.owner);
        arg0.principal_amount = 0;
        0x2::coin::value<T0>(&v1)
    }

    public entry fun close_vault<T0>(arg0: &mut Vault, arg1: VaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, &arg1, arg2);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 0, 5);
        let v0 = close_amount_no_yield<T0>(arg0, arg2);
        if (v0 > 0) {
            let v1 = Withdrawn{
                vault_id  : 0x2::object::id<Vault>(arg0),
                owner     : arg0.owner,
                coin_type : asset_type_name_for_kind(arg0.asset_kind),
                amount    : v0,
            };
            0x2::event::emit<Withdrawn>(v1);
        };
        arg0.is_active = false;
        arg0.settled_at = 0x1::option::none<u64>();
        arg0.settled_by = 0x1::option::none<address>();
        let v2 = VaultClosed{
            vault_id  : 0x2::object::id<Vault>(arg0),
            owner     : arg0.owner,
            closed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultClosed>(v2);
        let v3 = VaultDeactivated{
            vault_id : 0x2::object::id<Vault>(arg0),
            reason   : b"closed",
        };
        0x2::event::emit<VaultDeactivated>(v3);
        let VaultOwnerCap {
            id       : v4,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public entry fun close_vault_with_yield<T0>(arg0: &mut Vault, arg1: VaultOwnerCap, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, &arg1, arg5);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 1, 5);
        let v0 = close_amount_scallop<T0>(arg0, arg2, arg3, arg4, arg5);
        if (v0 > 0) {
            let v1 = Withdrawn{
                vault_id  : 0x2::object::id<Vault>(arg0),
                owner     : arg0.owner,
                coin_type : asset_type_name_for_kind(arg0.asset_kind),
                amount    : v0,
            };
            0x2::event::emit<Withdrawn>(v1);
        };
        arg0.is_active = false;
        arg0.settled_at = 0x1::option::none<u64>();
        arg0.settled_by = 0x1::option::none<address>();
        let v2 = VaultClosed{
            vault_id  : 0x2::object::id<Vault>(arg0),
            owner     : arg0.owner,
            closed_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<VaultClosed>(v2);
        let v3 = VaultDeactivated{
            vault_id : 0x2::object::id<Vault>(arg0),
            reason   : b"closed",
        };
        0x2::event::emit<VaultDeactivated>(v3);
        let VaultOwnerCap {
            id       : v4,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public entry fun create_vault<T0>(arg0: &mut 0xe49c007ba7ef0298eb49083f032e026104c787c390750ccf92852bb5f4212273::registry::Registry, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 60000, 4);
        assert!(is_supported_yield_strategy(arg3), 5);
        assert!(arg1 != @0x0, 6);
        let v0 = asset_kind_for_type<T0>();
        let v1 = if (arg3 == 1) {
            assert!(is_scallop_supported_asset_kind(v0), 10);
            0x1::option::some<u64>(scallop_pool_id_for_asset_kind(v0))
        } else {
            0x1::option::none<u64>()
        };
        let v2 = Vault{
            id                : 0x2::object::new(arg5),
            owner             : 0x2::tx_context::sender(arg5),
            heir              : arg1,
            period_ms         : arg2,
            last_confirmed_at : 0x2::clock::timestamp_ms(arg4),
            yield_strategy    : arg3,
            asset_kind        : v0,
            principal_amount  : 0,
            scallop_pool_id   : v1,
            settled_at        : 0x1::option::none<u64>(),
            settled_by        : 0x1::option::none<address>(),
            is_active         : true,
        };
        let v3 = 0x2::object::id<Vault>(&v2);
        0xe49c007ba7ef0298eb49083f032e026104c787c390750ccf92852bb5f4212273::registry::register_vault(arg0, v3, 0x2::tx_context::sender(arg5), arg1);
        let v4 = VaultOwnerCap{
            id       : 0x2::object::new(arg5),
            vault_id : v3,
        };
        0x2::transfer::share_object<Vault>(v2);
        0x2::transfer::transfer<VaultOwnerCap>(v4, 0x2::tx_context::sender(arg5));
        let v5 = VaultCreated{
            vault_id       : v3,
            owner          : 0x2::tx_context::sender(arg5),
            heir           : arg1,
            period_ms      : arg2,
            yield_strategy : arg3,
            asset_kind     : v0,
        };
        0x2::event::emit<VaultCreated>(v5);
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 0, 5);
        deposit_no_yield<T0>(arg0, arg2);
        let v0 = Deposited{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : asset_type_name_for_kind(arg0.asset_kind),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Deposited>(v0);
    }

    fun deposit_no_yield<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        arg0.principal_amount = arg0.principal_amount + 0x2::coin::value<T0>(&arg1);
    }

    fun deposit_scallop<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        store_scallop_balance<T0>(arg0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg1, arg4, arg5));
        arg0.principal_amount = arg0.principal_amount + 0x2::coin::value<T0>(&arg1);
    }

    public entry fun deposit_with_yield<T0>(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg6);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 1, 5);
        deposit_scallop<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
        let v0 = Deposited{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : asset_type_name_for_kind(arg0.asset_kind),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun get_asset_kind(arg0: &Vault) : u8 {
        arg0.asset_kind
    }

    public fun get_balance<T0>(arg0: &Vault) : u64 {
        assert_vault_asset_match<T0>(arg0);
        if (arg0.yield_strategy == 1) {
            arg0.principal_amount
        } else {
            let v1 = CoinKey<T0>{dummy_field: false};
            if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v1)) {
                0x2::balance::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1))
            } else {
                0
            }
        }
    }

    public fun get_heir(arg0: &Vault) : address {
        arg0.heir
    }

    public fun get_last_confirmed(arg0: &Vault) : u64 {
        arg0.last_confirmed_at
    }

    public fun get_owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun get_period(arg0: &Vault) : u64 {
        arg0.period_ms
    }

    public fun get_position_value<T0>(arg0: &Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) : u64 {
        assert_vault_asset_match<T0>(arg0);
        get_balance<T0>(arg0)
    }

    public fun get_principal_amount(arg0: &Vault) : u64 {
        arg0.principal_amount
    }

    public fun get_settled_at(arg0: &Vault) : u64 {
        0x1::option::get_with_default<u64>(&arg0.settled_at, 0)
    }

    public fun get_settled_by(arg0: &Vault) : address {
        0x1::option::get_with_default<address>(&arg0.settled_by, @0x0)
    }

    public fun get_vault_scallop_pool_id(arg0: &Vault) : u64 {
        0x1::option::get_with_default<u64>(&arg0.scallop_pool_id, 0)
    }

    public fun get_yield_strategy(arg0: &Vault) : u8 {
        arg0.yield_strategy
    }

    public fun has_scallop_coin<T0>(arg0: &Vault) : bool {
        let v0 = ScallopCoinKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<ScallopCoinKey<T0>>(&arg0.id, v0)
    }

    public entry fun heartbeat(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_confirmed_at = v0;
        let v1 = HeartbeatConfirmed{
            vault_id      : 0x2::object::id<Vault>(arg0),
            confirmed_at  : v0,
            next_deadline : v0 + arg0.period_ms,
        };
        0x2::event::emit<HeartbeatConfirmed>(v1);
    }

    public fun is_active(arg0: &Vault) : bool {
        arg0.is_active
    }

    public fun is_claimable(arg0: &Vault, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) - arg0.last_confirmed_at > arg0.period_ms
    }

    fun is_scallop_supported_asset_kind(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public fun is_settled(arg0: &Vault) : bool {
        0x1::option::is_some<u64>(&arg0.settled_at)
    }

    fun is_supported_yield_strategy(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    fun scallop_pool_id_for_asset_kind(arg0: u8) : u64 {
        if (arg0 == 2) {
            6
        } else if (arg0 == 3) {
            5
        } else {
            assert!(arg0 == 1, 10);
            7
        }
    }

    public entry fun settle<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 - arg0.last_confirmed_at > arg0.period_ms, 2);
        let v1 = claim_amount_no_yield<T0>(arg0, arg2);
        arg0.is_active = false;
        arg0.settled_at = 0x1::option::some<u64>(v0);
        arg0.settled_by = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        let v2 = VaultSettled{
            vault_id            : 0x2::object::id<Vault>(arg0),
            heir                : arg0.heir,
            triggered_by        : 0x2::tx_context::sender(arg2),
            principal_coin_type : asset_type_name_for_kind(arg0.asset_kind),
            principal_amount    : v1,
            reward_amount       : 0,
            settled_at          : v0,
        };
        0x2::event::emit<VaultSettled>(v2);
        let v3 = VaultDeactivated{
            vault_id : 0x2::object::id<Vault>(arg0),
            reason   : b"settled",
        };
        0x2::event::emit<VaultDeactivated>(v3);
    }

    public entry fun settle_with_yield<T0>(arg0: &mut Vault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 1, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_confirmed_at > arg0.period_ms, 2);
        let v1 = claim_amount_scallop<T0>(arg0, arg1, arg2, arg3, arg4);
        arg0.is_active = false;
        arg0.settled_at = 0x1::option::some<u64>(v0);
        arg0.settled_by = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        let v2 = VaultSettled{
            vault_id            : 0x2::object::id<Vault>(arg0),
            heir                : arg0.heir,
            triggered_by        : 0x2::tx_context::sender(arg4),
            principal_coin_type : asset_type_name_for_kind(arg0.asset_kind),
            principal_amount    : v1,
            reward_amount       : 0,
            settled_at          : v0,
        };
        0x2::event::emit<VaultSettled>(v2);
        let v3 = VaultDeactivated{
            vault_id : 0x2::object::id<Vault>(arg0),
            reason   : b"settled",
        };
        0x2::event::emit<VaultDeactivated>(v3);
    }

    fun store_scallop_balance<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>) {
        let v0 = ScallopCoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<ScallopCoinKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow_mut<ScallopCoinKey<T0>, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v0), 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1));
        } else {
            0x2::dynamic_field::add<ScallopCoinKey<T0>, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v0, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1));
        };
    }

    public entry fun update_heir(arg0: &mut 0xe49c007ba7ef0298eb49083f032e026104c787c390750ccf92852bb5f4212273::registry::Registry, arg1: &mut Vault, arg2: &VaultOwnerCap, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg1, arg2, arg4);
        assert!(arg1.is_active, 1);
        assert!(arg3 != @0x0, 6);
        let v0 = arg1.heir;
        arg1.heir = arg3;
        0xe49c007ba7ef0298eb49083f032e026104c787c390750ccf92852bb5f4212273::registry::reassign_heir(arg0, 0x2::object::id<Vault>(arg1), v0, arg3);
        let v1 = HeirUpdated{
            vault_id : 0x2::object::id<Vault>(arg1),
            old_heir : v0,
            new_heir : arg3,
        };
        0x2::event::emit<HeirUpdated>(v1);
    }

    public entry fun update_period(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert!(arg2 >= 60000, 4);
        arg0.period_ms = arg2;
        let v0 = PeriodUpdated{
            vault_id      : 0x2::object::id<Vault>(arg0),
            old_period_ms : arg0.period_ms,
            new_period_ms : arg2,
        };
        0x2::event::emit<PeriodUpdated>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 0, 5);
        withdraw_no_yield<T0>(arg0, arg2, arg3);
        let v0 = Withdrawn{
            vault_id  : 0x2::object::id<Vault>(arg0),
            owner     : 0x2::tx_context::sender(arg3),
            coin_type : asset_type_name_for_kind(arg0.asset_kind),
            amount    : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    fun withdraw_no_yield<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2), 0x2::tx_context::sender(arg2));
        arg0.principal_amount = arg0.principal_amount - arg1;
    }

    fun withdraw_scallop_principal<T0>(arg0: &mut Vault, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopCoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<ScallopCoinKey<T0>>(&arg0.id, v0), 3);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::remove<ScallopCoinKey<T0>, 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, v0), arg5), arg4, arg5);
        assert!(0x2::coin::value<T0>(&v1) >= arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, arg1, arg5), 0x2::tx_context::sender(arg5));
        if (0x2::coin::value<T0>(&v1) > 0) {
            store_scallop_balance<T0>(arg0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, v1, arg4, arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
    }

    public entry fun withdraw_with_yield<T0>(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg6);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(arg0.yield_strategy == 1, 5);
        assert!(arg2 <= arg0.principal_amount, 11);
        withdraw_scallop_principal<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
        arg0.principal_amount = arg0.principal_amount - arg2;
        let v0 = Withdrawn{
            vault_id  : 0x2::object::id<Vault>(arg0),
            owner     : 0x2::tx_context::sender(arg6),
            coin_type : asset_type_name_for_kind(arg0.asset_kind),
            amount    : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

