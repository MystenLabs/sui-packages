module 0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::active_vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        signers: vector<vector<u8>>,
        threshold: u64,
        treasuries: vector<address>,
        freezed_caps: 0x2::table::Table<address, bool>,
    }

    struct ActiveVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<T0>,
        config: ActiveVaultConfig,
    }

    struct ActiveVaultConfig has store {
        deposit_enable: bool,
        withdraw_enable: bool,
        max_vault_balance: u64,
        deposit_minimum_balance: u64,
        withdraw_minimum_balance: u64,
        order_id_counter: u64,
        used_hashes: 0x2::table::Table<vector<u8>, bool>,
        deposit_order_ids: 0x2::table::Table<u256, u64>,
        withdrawal_order_ids: 0x2::table::Table<u256, u64>,
        withdraw_security_period: vector<SecurityPeriod>,
    }

    struct SecurityPeriod has store, key {
        id: 0x2::object::UID,
        enable: bool,
        duration: u64,
        limit: u64,
        period_amount: 0x2::table::Table<u64, u64>,
    }

    struct ActiveVaultCreated has copy, drop {
        sender: address,
        vault: address,
    }

    struct OwnerCapCreated has copy, drop {
        sender: address,
        owner_cap: address,
    }

    struct PauseCapCreated has copy, drop {
        sender: address,
        pause_cap: address,
    }

    struct Deposited has copy, drop {
        user: address,
        amount: u64,
        vault_id: address,
        order_id: u64,
    }

    struct DirectDeposited has copy, drop {
        user: address,
        amount: u64,
        vault_id: address,
    }

    struct Withdrawn has copy, drop {
        order_id: u256,
        order_time: u64,
        caller: address,
        recipient: address,
        amount: u64,
        vault_id: address,
    }

    struct DirectWithdrawn has copy, drop {
        user: address,
        amount: u64,
        vault_id: address,
    }

    struct SignerAdded has copy, drop {
        signer: vector<u8>,
        threshold: u64,
    }

    struct SignerRemoved has copy, drop {
        signer: vector<u8>,
        threshold: u64,
    }

    struct SignerReset has copy, drop {
        signers: vector<vector<u8>>,
        threshold: u64,
    }

    struct ConfigUpdatedU64 has copy, drop {
        config_field: vector<u8>,
        value: u64,
    }

    struct ConfigUpdatedBool has copy, drop {
        config_field: vector<u8>,
        value: bool,
    }

    struct SecurityPeriodUpdated has copy, drop {
        period_id: address,
        duration: u64,
        limit: u64,
        enable: bool,
    }

    struct PauseCapFreezeSet has copy, drop {
        cap_id: address,
        disable: bool,
    }

    public(friend) fun active_vault_version_migrate<T0>(arg0: &mut ActiveVault<T0>) {
        assert!(arg0.version < 0, 10005);
        arg0.version = 0;
    }

    public fun active_vault_version_verification<T0>(arg0: &ActiveVault<T0>) {
        assert!(arg0.version == 0, 10005);
    }

    public(friend) fun add_security_period<T0>(arg0: &mut ActiveVault<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        active_vault_version_verification<T0>(arg0);
        let v0 = SecurityPeriod{
            id            : 0x2::object::new(arg3),
            enable        : true,
            duration      : arg1,
            limit         : arg2,
            period_amount : 0x2::table::new<u64, u64>(arg3),
        };
        let v1 = SecurityPeriodUpdated{
            period_id : 0x2::object::uid_to_address(&v0.id),
            duration  : v0.duration,
            limit     : v0.limit,
            enable    : v0.enable,
        };
        0x2::event::emit<SecurityPeriodUpdated>(v1);
        0x1::vector::push_back<SecurityPeriod>(&mut arg0.config.withdraw_security_period, v0);
    }

    public(friend) fun add_signer(arg0: &mut Config, arg1: vector<u8>, arg2: u64) {
        version_verification(arg0);
        assert!(!0x1::vector::contains<vector<u8>>(&arg0.signers, &arg1), 10000);
        assert!(arg2 > 0 && arg2 <= 0x1::vector::length<vector<u8>>(&arg0.signers) + 1, 10002);
        0x1::vector::push_back<vector<u8>>(&mut arg0.signers, arg1);
        arg0.threshold = arg2;
        let v0 = SignerAdded{
            signer    : arg1,
            threshold : arg2,
        };
        0x2::event::emit<SignerAdded>(v0);
    }

    public fun balance_value<T0>(arg0: &ActiveVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun create_owner_cap(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        let v1 = OwnerCapCreated{
            sender    : 0x2::tx_context::sender(arg0),
            owner_cap : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<OwnerCapCreated>(v1);
        v0
    }

    public(friend) fun create_pause_cap(arg0: &mut 0x2::tx_context::TxContext) : PauseCap {
        let v0 = PauseCap{id: 0x2::object::new(arg0)};
        let v1 = PauseCapCreated{
            sender    : 0x2::tx_context::sender(arg0),
            pause_cap : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<PauseCapCreated>(v1);
        v0
    }

    public(friend) fun create_vault<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut Config, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : ActiveVault<T0> {
        version_verification(arg1);
        when_not_paused(arg1);
        let v0 = ActiveVaultConfig{
            deposit_enable           : true,
            withdraw_enable          : true,
            max_vault_balance        : 0,
            deposit_minimum_balance  : arg2,
            withdraw_minimum_balance : arg3,
            order_id_counter         : 0,
            used_hashes              : 0x2::table::new<vector<u8>, bool>(arg4),
            deposit_order_ids        : 0x2::table::new<u256, u64>(arg4),
            withdrawal_order_ids     : 0x2::table::new<u256, u64>(arg4),
            withdraw_security_period : 0x1::vector::empty<SecurityPeriod>(),
        };
        let v1 = ActiveVault<T0>{
            id      : 0x2::object::new(arg4),
            version : 0,
            balance : 0x2::balance::zero<T0>(),
            config  : v0,
        };
        0x1::vector::push_back<address>(&mut arg1.treasuries, 0x2::object::uid_to_address(&v1.id));
        let v2 = ActiveVaultCreated{
            sender : 0x2::tx_context::sender(arg4),
            vault  : 0x2::object::uid_to_address(&v1.id),
        };
        0x2::event::emit<ActiveVaultCreated>(v2);
        v1
    }

    public(friend) fun deposit<T0>(arg0: &mut ActiveVault<T0>, arg1: &Config, arg2: &mut 0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::secure_vault::SecureVault<T0>, arg3: address, arg4: 0x2::balance::Balance<T0>) {
        when_not_paused(arg1);
        when_deposit_not_disabled<T0>(arg0);
        version_verification(arg1);
        active_vault_version_verification<T0>(arg0);
        0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::secure_vault::secure_vault_version_verification<T0>(arg2);
        let v0 = 0x2::balance::value<T0>(&arg4);
        assert!(v0 >= arg0.config.deposit_minimum_balance, 10006);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        if (arg0.config.max_vault_balance != 0 && 0x2::balance::value<T0>(&arg0.balance) + v0 > arg0.config.max_vault_balance) {
            0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::secure_vault::deposit_secure_vault<T0>(arg2, arg4);
            v1 = 0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::secure_vault::to_address<T0>(arg2);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, arg4);
        };
        let v2 = arg0.config.order_id_counter;
        0x2::table::add<u256, u64>(&mut arg0.config.deposit_order_ids, (v2 as u256), v0);
        arg0.config.order_id_counter = arg0.config.order_id_counter + 1;
        let v3 = Deposited{
            user     : arg3,
            amount   : v0,
            vault_id : v1,
            order_id : v2,
        };
        0x2::event::emit<Deposited>(v3);
    }

    public(friend) fun direct_deposit<T0>(arg0: &mut ActiveVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        active_vault_version_verification<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        let v0 = DirectDeposited{
            user     : 0x2::tx_context::sender(arg2),
            amount   : 0x2::balance::value<T0>(&arg1),
            vault_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<DirectDeposited>(v0);
    }

    public(friend) fun direct_withdraw<T0>(arg0: &mut ActiveVault<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        active_vault_version_verification<T0>(arg0);
        let v0 = DirectWithdrawn{
            user     : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            vault_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<DirectWithdrawn>(v0);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    fun find_security_period<T0>(arg0: &mut ActiveVault<T0>, arg1: address) : &mut SecurityPeriod {
        active_vault_version_verification<T0>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<SecurityPeriod>(&arg0.config.withdraw_security_period)) {
            if (0x2::object::uid_to_address(&0x1::vector::borrow<SecurityPeriod>(&arg0.config.withdraw_security_period, v0).id) == arg1) {
                return 0x1::vector::borrow_mut<SecurityPeriod>(&mut arg0.config.withdraw_security_period, v0)
            };
            v0 = v0 + 1;
        };
        abort 10013
    }

    public(friend) fun freeze_pause_cap(arg0: &mut Config, arg1: address, arg2: bool) {
        version_verification(arg0);
        if (0x2::table::contains<address, bool>(&arg0.freezed_caps, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.freezed_caps, arg1) = arg2;
        } else {
            0x2::table::add<address, bool>(&mut arg0.freezed_caps, arg1, arg2);
        };
        let v0 = PauseCapFreezeSet{
            cap_id  : arg1,
            disable : arg2,
        };
        0x2::event::emit<PauseCapFreezeSet>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id           : 0x2::object::new(arg0),
            version      : 0,
            paused       : false,
            signers      : 0x1::vector::empty<vector<u8>>(),
            threshold    : 0,
            treasuries   : 0x1::vector::empty<address>(),
            freezed_caps : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::public_share_object<Config>(v1);
    }

    public fun keccak_message<T0>(arg0: u256, arg1: u64, arg2: address, arg3: u64, arg4: address, arg5: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"mainnet");
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg3 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(arg0)));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg1 as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public(friend) fun remove_signer(arg0: &mut Config, arg1: vector<u8>, arg2: u64) {
        version_verification(arg0);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.signers, &arg1);
        assert!(v0, 10001);
        assert!(arg2 > 0 && arg2 <= 0x1::vector::length<vector<u8>>(&arg0.signers) - 1, 10002);
        0x1::vector::remove<vector<u8>>(&mut arg0.signers, v1);
        arg0.threshold = arg2;
        let v2 = SignerRemoved{
            signer    : arg1,
            threshold : arg2,
        };
        0x2::event::emit<SignerRemoved>(v2);
    }

    public(friend) fun reset_signers(arg0: &mut Config, arg1: vector<vector<u8>>, arg2: u64) {
        version_verification(arg0);
        assert!(arg2 > 0 && arg2 <= 0x1::vector::length<vector<u8>>(&arg1), 10002);
        arg0.signers = arg1;
        arg0.threshold = arg2;
        let v0 = SignerReset{
            signers   : arg1,
            threshold : arg2,
        };
        0x2::event::emit<SignerReset>(v0);
    }

    fun security_update<T0>(arg0: &mut ActiveVault<T0>, arg1: &0x2::clock::Clock, arg2: u64) {
        active_vault_version_verification<T0>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<SecurityPeriod>(&arg0.config.withdraw_security_period)) {
            let v1 = 0x1::vector::borrow_mut<SecurityPeriod>(&mut arg0.config.withdraw_security_period, v0);
            if (v1.enable) {
                let v2 = 0x2::clock::timestamp_ms(arg1) / v1.duration;
                let v3 = 0;
                if (0x2::table::contains<u64, u64>(&v1.period_amount, v2)) {
                    v3 = 0x2::table::remove<u64, u64>(&mut v1.period_amount, v2);
                };
                let v4 = arg2 + v3;
                assert!(v4 <= v1.limit, 10011);
                0x2::table::add<u64, u64>(&mut v1.period_amount, v2, v4);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_deposit_enable<T0>(arg0: &mut ActiveVault<T0>, arg1: bool) {
        active_vault_version_verification<T0>(arg0);
        arg0.config.deposit_enable = arg1;
        let v0 = ConfigUpdatedBool{
            config_field : b"deposit_enable",
            value        : arg1,
        };
        0x2::event::emit<ConfigUpdatedBool>(v0);
    }

    public(friend) fun set_enable_security_period<T0>(arg0: &mut ActiveVault<T0>, arg1: address, arg2: bool) {
        active_vault_version_verification<T0>(arg0);
        let v0 = find_security_period<T0>(arg0, arg1);
        v0.enable = arg2;
        let v1 = SecurityPeriodUpdated{
            period_id : arg1,
            duration  : v0.duration,
            limit     : v0.limit,
            enable    : v0.enable,
        };
        0x2::event::emit<SecurityPeriodUpdated>(v1);
    }

    public(friend) fun set_max_vault_balance<T0>(arg0: &mut ActiveVault<T0>, arg1: u64) {
        active_vault_version_verification<T0>(arg0);
        arg0.config.max_vault_balance = arg1;
        let v0 = ConfigUpdatedU64{
            config_field : b"max_vault_balance",
            value        : arg1,
        };
        0x2::event::emit<ConfigUpdatedU64>(v0);
    }

    public(friend) fun set_minimum_deposit<T0>(arg0: &mut ActiveVault<T0>, arg1: u64) {
        active_vault_version_verification<T0>(arg0);
        arg0.config.deposit_minimum_balance = arg1;
        let v0 = ConfigUpdatedU64{
            config_field : b"deposit_minimum_balance",
            value        : arg1,
        };
        0x2::event::emit<ConfigUpdatedU64>(v0);
    }

    public(friend) fun set_minimum_withdraw<T0>(arg0: &mut ActiveVault<T0>, arg1: u64) {
        active_vault_version_verification<T0>(arg0);
        arg0.config.withdraw_minimum_balance = arg1;
        let v0 = ConfigUpdatedU64{
            config_field : b"withdraw_minimum_balance",
            value        : arg1,
        };
        0x2::event::emit<ConfigUpdatedU64>(v0);
    }

    public(friend) fun set_pause(arg0: &mut Config, arg1: bool) {
        version_verification(arg0);
        arg0.paused = arg1;
    }

    public(friend) fun set_withdraw_enable<T0>(arg0: &mut ActiveVault<T0>, arg1: bool) {
        active_vault_version_verification<T0>(arg0);
        arg0.config.withdraw_enable = arg1;
        let v0 = ConfigUpdatedBool{
            config_field : b"withdraw_enable",
            value        : arg1,
        };
        0x2::event::emit<ConfigUpdatedBool>(v0);
    }

    public fun signer_length(arg0: &Config) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.signers)
    }

    public fun signers(arg0: &Config) : &vector<vector<u8>> {
        &arg0.signers
    }

    public fun threshold(arg0: &Config) : u64 {
        arg0.threshold
    }

    public(friend) fun update_security_period<T0>(arg0: &mut ActiveVault<T0>, arg1: address, arg2: u64, arg3: u64) {
        active_vault_version_verification<T0>(arg0);
        let v0 = find_security_period<T0>(arg0, arg1);
        v0.duration = arg2;
        v0.limit = arg3;
        let v1 = SecurityPeriodUpdated{
            period_id : arg1,
            duration  : v0.duration,
            limit     : v0.limit,
            enable    : v0.enable,
        };
        0x2::event::emit<SecurityPeriodUpdated>(v1);
    }

    public(friend) fun version_migrate(arg0: &mut Config) {
        assert!(arg0.version < 0, 10005);
        arg0.version = 0;
    }

    public fun version_verification(arg0: &Config) {
        assert!(arg0.version == 0, 10005);
    }

    public fun when_deposit_not_disabled<T0>(arg0: &ActiveVault<T0>) {
        assert!(arg0.config.deposit_enable, 10004);
    }

    public fun when_not_expired(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg0), 10012);
    }

    public fun when_not_freezed_cap(arg0: &Config, arg1: &PauseCap) {
        assert!(!0x2::table::contains<address, bool>(&arg0.freezed_caps, 0x2::object::uid_to_address(&arg1.id)) || !*0x2::table::borrow<address, bool>(&arg0.freezed_caps, 0x2::object::uid_to_address(&arg1.id)), 10003);
    }

    public fun when_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 10003);
    }

    public fun when_withdraw_not_disabled<T0>(arg0: &ActiveVault<T0>) {
        assert!(arg0.config.withdraw_enable, 10004);
    }

    public(friend) fun withdraw<T0>(arg0: &mut ActiveVault<T0>, arg1: &0x2::clock::Clock, arg2: &Config, arg3: u256, arg4: u64, arg5: address, arg6: u64, arg7: address, arg8: vector<vector<u8>>, arg9: vector<u8>) : 0x2::balance::Balance<T0> {
        when_not_paused(arg2);
        when_withdraw_not_disabled<T0>(arg0);
        when_not_expired(arg1, arg4);
        version_verification(arg2);
        active_vault_version_verification<T0>(arg0);
        security_update<T0>(arg0, arg1, arg6);
        assert!(0x1::vector::length<vector<u8>>(&arg8) >= arg2.threshold, 10008);
        assert!(0x1::vector::length<vector<u8>>(&arg8) <= 0x1::vector::length<vector<u8>>(&arg2.signers), 10008);
        assert!(arg6 >= arg0.config.withdraw_minimum_balance, 10007);
        let v0 = keccak_message<T0>(arg3, arg4, arg5, arg6, arg7, arg9);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.config.used_hashes, v0), 10009);
        0x2::table::add<vector<u8>, bool>(&mut arg0.config.used_hashes, v0, true);
        assert!(!0x2::table::contains<u256, u64>(&arg0.config.withdrawal_order_ids, arg3), 10014);
        0x2::table::add<u256, u64>(&mut arg0.config.withdrawal_order_ids, arg3, arg6);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2.signers)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg2.signers, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<vector<u8>>(&arg8)) {
                let v5 = 0x1::vector::borrow<vector<u8>>(&arg8, v4);
                assert!(0x1::vector::length<u8>(v5) == 64, 10008);
                if (0x2::ed25519::ed25519_verify(v5, v3, &v0)) {
                    v2 = v2 + 1;
                    break
                };
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(v2 >= arg2.threshold, 10010);
        let v6 = Withdrawn{
            order_id   : arg3,
            order_time : arg4,
            caller     : arg5,
            recipient  : arg7,
            amount     : arg6,
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<Withdrawn>(v6);
        0x2::balance::split<T0>(&mut arg0.balance, arg6)
    }

    // decompiled from Move bytecode v6
}

