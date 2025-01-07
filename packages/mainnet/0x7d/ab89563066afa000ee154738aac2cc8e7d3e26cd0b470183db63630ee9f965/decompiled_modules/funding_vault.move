module 0x7dab89563066afa000ee154738aac2cc8e7d3e26cd0b470183db63630ee9f965::funding_vault {
    struct FUNDING_VAULT has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        vault_registry: 0x2::object::UID,
        setting: vector<u64>,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        token: 0x1::type_name::TypeName,
        info: vector<u64>,
        config: vector<u64>,
        fund: 0x2::table::Table<address, vector<Fund>>,
        refund: 0x2::table::Table<address, vector<Fund>>,
        u64_padding: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct Fund has drop, store {
        balance: u64,
        ts_ms: u64,
    }

    struct NewVaultEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct UpdateRegistrySettingEvent has copy, drop {
        log: vector<u64>,
    }

    struct UpdateInfoEvent has copy, drop {
        log: vector<u64>,
    }

    struct UpdateConfigEvent has copy, drop {
        log: vector<u64>,
    }

    struct DepositFundToDeepbookBalanceManagerEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct WithdrawFundFromDeepbookBalanceManagerEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct DepositToDeepbookBalanceManagerEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct WithdrawFromDeepbookBalanceManagerEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct IncreaseFundEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct DecreaseFundEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        log: vector<u64>,
    }

    struct BalanceManagerIdentity {
        vault_index: u64,
        balance_manager_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
    }

    struct RaiseFundEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        user: address,
        log: vector<u64>,
    }

    struct ReduceFundEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        user: address,
        log: vector<u64>,
    }

    public fun borrow_deepbook_balance_manager(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, BalanceManagerIdentity) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg3);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        let v2 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v1.id, 0x1::string::utf8(b"deepbook_balance_manager"));
        let v3 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut v1.id, 0x1::string::utf8(b"deepbook_trade_cap"));
        let v4 = BalanceManagerIdentity{
            vault_index        : arg2,
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&v2),
            trade_cap_id       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&v3),
        };
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(&v2) != 0x2::tx_context::sender(arg3), invalid_trader());
        (v2, v3, v4)
    }

    fun capacity_reached() : u64 {
        abort 0
    }

    entry fun decrease_fund<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg5);
        let v3 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v3);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(v1.token == v0, invalid_token());
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg3), arg5);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, 0x2::coin::value<T0>(&v4));
        let v6 = DecreaseFundEvent{
            token : v0,
            log   : v5,
        };
        0x2::event::emit<DecreaseFundEvent>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg4);
    }

    entry fun delegate_raise_fund<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg6);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        raise_fund_<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    entry fun delegate_reduce_fund<T0>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: address, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg7);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(reduce_fund_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), arg3);
    }

    entry fun deposit_fund_to_deepbook_balance_manager<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg3);
        let v3 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v3);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(v1.token == v0, invalid_token());
        if (0x2::balance::value<T0>(v2) <= *0x1::vector::borrow<u64>(&v1.info, 2)) {
            return
        };
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(v2), arg3);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, 0x2::coin::value<T0>(&v4));
        let v6 = DepositFundToDeepbookBalanceManagerEvent{
            token : v0,
            log   : v5,
        };
        0x2::event::emit<DepositFundToDeepbookBalanceManagerEvent>(v6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v1.id, 0x1::string::utf8(b"deepbook_balance_manager")), v4, arg3);
    }

    entry fun deposit_to_deepbook_balance_manager<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v2 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v2);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(v1.token != v0, invalid_token());
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, 0x2::coin::value<T0>(&arg3));
        let v4 = DepositToDeepbookBalanceManagerEvent{
            token : v0,
            log   : v3,
        };
        0x2::event::emit<DepositToDeepbookBalanceManagerEvent>(v4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v1.id, 0x1::string::utf8(b"deepbook_balance_manager")), arg3, arg4);
    }

    fun expired() : u64 {
        abort 0
    }

    public(friend) fun get_fund_bcs(arg0: &Registry, arg1: u64, arg2: address) : vector<u8> {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.vault_registry, arg1)) {
            let v0 = 0x2::dynamic_object_field::borrow<u64, Vault>(&arg0.vault_registry, arg1);
            if (0x2::table::contains<address, vector<Fund>>(&v0.fund, arg2)) {
                return 0x1::bcs::to_bytes<vector<Fund>>(0x2::table::borrow<address, vector<Fund>>(&v0.fund, arg2))
            };
        };
        b""
    }

    public(friend) fun get_refund_bcs(arg0: &Registry, arg1: u64, arg2: address) : vector<u8> {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.vault_registry, arg1)) {
            let v0 = 0x2::dynamic_object_field::borrow<u64, Vault>(&arg0.vault_registry, arg1);
            if (0x2::table::contains<address, vector<Fund>>(&v0.refund, arg2)) {
                return 0x1::bcs::to_bytes<vector<Fund>>(0x2::table::borrow<address, vector<Fund>>(&v0.refund, arg2))
            };
        };
        b""
    }

    public(friend) fun get_vault_bcs(arg0: &Registry, arg1: u64) : vector<u8> {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.vault_registry, arg1)) {
            return 0x1::bcs::to_bytes<Vault>(0x2::dynamic_object_field::borrow<u64, Vault>(&arg0.vault_registry, arg1))
        };
        b""
    }

    entry fun increase_fund<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v2 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v2);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(v1.token == v0, invalid_token());
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, 0x2::coin::value<T0>(&arg3));
        let v4 = IncreaseFundEvent{
            token : v0,
            log   : v3,
        };
        0x2::event::emit<IncreaseFundEvent>(v4);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), 0x2::coin::into_balance<T0>(arg3));
    }

    fun init(arg0: FUNDING_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<FUNDING_VAULT, VERSION>(&arg0, v0, arg1);
        let v1 = Registry{
            id             : 0x2::object::new(arg1),
            vault_registry : 0x2::object::new(arg1),
            setting        : vector[0, 0],
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    fun invalid_identity() : u64 {
        abort 0
    }

    fun invalid_index() : u64 {
        abort 0
    }

    fun invalid_token() : u64 {
        abort 0
    }

    fun invalid_trader() : u64 {
        abort 0
    }

    fun lot_size_violation() : u64 {
        abort 0
    }

    fun min_size_violation() : u64 {
        abort 0
    }

    entry fun new_vault<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg3);
        let v1 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v1);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&arg1.setting, 0));
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, 0);
        let v4 = Vault{
            id          : 0x2::object::new(arg3),
            token       : v0,
            info        : v2,
            config      : arg2,
            fund        : 0x2::table::new<address, vector<Fund>>(arg3),
            refund      : 0x2::table::new<address, vector<Fund>>(arg3),
            u64_padding : vector[],
            bcs_padding : vector[],
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v4.id, v0, 0x2::balance::zero<T0>());
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg3);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v4.id, 0x1::string::utf8(b"deepbook_balance_manager"), v5);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut v4.id, 0x1::string::utf8(b"deepbook_trade_cap"), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v5, arg3));
        0x2::dynamic_object_field::add<u64, Vault>(&mut arg1.vault_registry, *0x1::vector::borrow<u64>(&v4.info, 0), v4);
        *0x1::vector::borrow_mut<u64>(&mut arg1.setting, 0) = *0x1::vector::borrow<u64>(&arg1.setting, 0) + 1;
        0x1::vector::append<u64>(&mut v2, arg2);
        let v6 = NewVaultEvent{
            token : v0,
            log   : v2,
        };
        0x2::event::emit<NewVaultEvent>(v6);
    }

    fun not_yet_activated() : u64 {
        abort 0
    }

    public fun raise_fund<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        raise_fund_<T0>(arg1, arg2, 0x2::tx_context::sender(arg5), arg3, arg4);
    }

    fun raise_fund_<T0>(arg0: &mut Registry, arg1: u64, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg0.vault_registry, arg1);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(*0x1::vector::borrow<u64>(&arg0.setting, 1) == 0, transaction_suspended());
        assert!(v1.token == v0, invalid_token());
        assert!(v2 > 0, zero_value());
        assert!(v2 >= *0x1::vector::borrow<u64>(&v1.config, 4), min_size_violation());
        assert!(v2 % *0x1::vector::borrow<u64>(&v1.config, 3) == 0, lot_size_violation());
        assert!(*0x1::vector::borrow<u64>(&v1.info, 1) + v2 <= *0x1::vector::borrow<u64>(&v1.config, 2), capacity_reached());
        assert!(0x2::clock::timestamp_ms(arg4) >= *0x1::vector::borrow<u64>(&v1.config, 0), not_yet_activated());
        assert!(0x2::clock::timestamp_ms(arg4) < *0x1::vector::borrow<u64>(&v1.config, 1), expired());
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, v2);
        let v4 = RaiseFundEvent{
            token : v0,
            user  : arg2,
            log   : v3,
        };
        0x2::event::emit<RaiseFundEvent>(v4);
        if (!0x2::table::contains<address, vector<Fund>>(&v1.fund, arg2)) {
            0x2::table::add<address, vector<Fund>>(&mut v1.fund, arg2, 0x1::vector::empty<Fund>());
        };
        let v5 = Fund{
            balance : v2,
            ts_ms   : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<Fund>(0x2::table::borrow_mut<address, vector<Fund>>(&mut v1.fund, arg2), v5);
        *0x1::vector::borrow_mut<u64>(&mut v1.info, 1) = *0x1::vector::borrow<u64>(&v1.info, 1) + v2;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), 0x2::coin::into_balance<T0>(arg3));
    }

    public fun reduce_fund<T0>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        reduce_fund_<T0>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6)
    }

    fun reduce_fund_<T0>(arg0: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: address, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(*0x1::vector::borrow<u64>(&arg1.setting, 1) == 0, transaction_suspended());
        assert!(v1.token == v0, invalid_token());
        assert!(0x2::clock::timestamp_ms(arg6) >= *0x1::vector::borrow<u64>(&v1.config, 0), not_yet_activated());
        let v3 = 0x2::balance::zero<T0>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = v6;
        let v8 = 0;
        let v9 = v8;
        if (v2 >= *0x1::vector::borrow<u64>(&v1.config, 1)) {
            if (0x2::table::contains<address, vector<Fund>>(&v1.fund, arg3)) {
                let v10 = 0x2::table::remove<address, vector<Fund>>(&mut v1.fund, arg3);
                0x1::vector::reverse<Fund>(&mut v10);
                while (0x1::vector::length<Fund>(&v10) != 0) {
                    let v11 = 0x1::vector::pop_back<Fund>(&mut v10);
                    let v12 = (((v11.balance as u256) * (*0x1::vector::borrow<u64>(&v1.config, 7) as u256) * ((*0x1::vector::borrow<u64>(&v1.config, 1) - v11.ts_ms) as u256) / (10000 as u256) / (*0x1::vector::borrow<u64>(&v1.config, 8) as u256)) as u64);
                    let v13 = (((v12 as u128) * (*0x1::vector::borrow<u64>(&v1.config, 5) as u128) / (10000 as u128)) as u64);
                    v4 = v4 + v11.balance;
                    let v14 = v7 - v13;
                    v7 = v14 + v12;
                    v9 = v9 + v13;
                };
                0x1::vector::destroy_empty<Fund>(v10);
                0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), v4 + v7));
                0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<T0>(arg0, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), v9));
                *0x1::vector::borrow_mut<u64>(&mut v1.info, 1) = *0x1::vector::borrow<u64>(&v1.info, 1) - v4;
            };
            if (0x2::table::contains<address, vector<Fund>>(&v1.refund, arg3)) {
                let v15 = 0x2::table::remove<address, vector<Fund>>(&mut v1.refund, arg3);
                0x1::vector::reverse<Fund>(&mut v15);
                while (0x1::vector::length<Fund>(&v15) != 0) {
                    let v16 = 0x1::vector::pop_back<Fund>(&mut v15);
                    v5 = v5 + v16.balance;
                };
                0x1::vector::destroy_empty<Fund>(v15);
                0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), v5));
                *0x1::vector::borrow_mut<u64>(&mut v1.info, 2) = *0x1::vector::borrow<u64>(&v1.info, 2) - v5;
            };
            let v17 = 0x1::vector::empty<u64>();
            let v18 = &mut v17;
            0x1::vector::push_back<u64>(v18, v4);
            0x1::vector::push_back<u64>(v18, v5);
            0x1::vector::push_back<u64>(v18, v7);
            0x1::vector::push_back<u64>(v18, v9);
            let v19 = ReduceFundEvent{
                token : v0,
                user  : arg3,
                log   : v17,
            };
            0x2::event::emit<ReduceFundEvent>(v19);
            return 0x2::coin::from_balance<T0>(v3, arg7)
        };
        if (arg4 > 0) {
            if (0x2::table::contains<address, vector<Fund>>(&v1.fund, arg3)) {
                let v20 = 0x2::table::remove<address, vector<Fund>>(&mut v1.fund, arg3);
                let v21 = 0x1::vector::empty<Fund>();
                while (!0x1::vector::is_empty<Fund>(&v20)) {
                    let v22 = 0x1::vector::pop_back<Fund>(&mut v20);
                    if (arg4 == 0) {
                        0x1::vector::push_back<Fund>(&mut v21, v22);
                        continue
                    };
                    if (arg4 >= v22.balance) {
                        v4 = v4 + v22.balance;
                        arg4 = arg4 - v22.balance;
                        continue
                    };
                    v4 = v4 + arg4;
                    v22.balance = v22.balance - arg4;
                    arg4 = 0;
                    0x1::vector::push_back<Fund>(&mut v21, v22);
                };
                0x1::vector::reverse<Fund>(&mut v21);
                if (0x1::vector::length<Fund>(&v21) > 0) {
                    0x2::table::add<address, vector<Fund>>(&mut v1.fund, arg3, v21);
                };
                if (!0x2::table::contains<address, vector<Fund>>(&v1.refund, arg3)) {
                    0x2::table::add<address, vector<Fund>>(&mut v1.refund, arg3, 0x1::vector::empty<Fund>());
                };
                let v23 = Fund{
                    balance : v4,
                    ts_ms   : v2,
                };
                0x1::vector::push_back<Fund>(0x2::table::borrow_mut<address, vector<Fund>>(&mut v1.refund, arg3), v23);
                *0x1::vector::borrow_mut<u64>(&mut v1.info, 1) = *0x1::vector::borrow<u64>(&v1.info, 1) - v4;
                *0x1::vector::borrow_mut<u64>(&mut v1.info, 2) = *0x1::vector::borrow<u64>(&v1.info, 2) + v4;
            };
        };
        if (arg5) {
            if (0x2::table::contains<address, vector<Fund>>(&v1.refund, arg3)) {
                let v24 = 0x1::vector::empty<Fund>();
                let v25 = 0x2::table::remove<address, vector<Fund>>(&mut v1.refund, arg3);
                0x1::vector::reverse<Fund>(&mut v25);
                while (0x1::vector::length<Fund>(&v25) != 0) {
                    let v26 = 0x1::vector::pop_back<Fund>(&mut v25);
                    let v27 = &v26;
                    let v28 = if (v2 >= v27.ts_ms + *0x1::vector::borrow<u64>(&v1.config, 6)) {
                        v5 = v5 + v27.balance;
                        false
                    } else {
                        true
                    };
                    if (v28) {
                        0x1::vector::push_back<Fund>(&mut v24, v26);
                    };
                };
                0x1::vector::destroy_empty<Fund>(v25);
                if (0x1::vector::length<Fund>(&v24) > 0) {
                    0x2::table::add<address, vector<Fund>>(&mut v1.refund, arg3, v24);
                };
                0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), v5));
                *0x1::vector::borrow_mut<u64>(&mut v1.info, 2) = *0x1::vector::borrow<u64>(&v1.info, 2) - v5;
            };
        };
        assert!(v4 + v5 > 0, zero_value());
        let v29 = 0x1::vector::empty<u64>();
        let v30 = &mut v29;
        0x1::vector::push_back<u64>(v30, v4);
        0x1::vector::push_back<u64>(v30, v5);
        0x1::vector::push_back<u64>(v30, v6);
        0x1::vector::push_back<u64>(v30, v8);
        let v31 = ReduceFundEvent{
            token : v0,
            user  : arg3,
            log   : v29,
        };
        0x2::event::emit<ReduceFundEvent>(v31);
        0x2::coin::from_balance<T0>(v3, arg7)
    }

    public fun return_deepbook_balance_manager(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg5: BalanceManagerIdentity, arg6: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg6);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        let BalanceManagerIdentity {
            vault_index        : v1,
            balance_manager_id : v2,
            trade_cap_id       : v3,
        } = arg5;
        let v4 = if (v1 == arg2) {
            if (v2 == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg3)) {
                v3 == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, invalid_identity());
        let v5 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v5.id, 0x1::string::utf8(b"deepbook_balance_manager"), arg3);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut v5.id, 0x1::string::utf8(b"deepbook_trade_cap"), arg4);
    }

    fun transaction_suspended() : u64 {
        abort 0
    }

    entry fun update_config(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg5);
        let v1 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v1);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        while (0x1::vector::length<u64>(&v0.config) < arg3 + 1) {
            0x1::vector::push_back<u64>(&mut v0.config, 0);
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.config, arg3));
        0x1::vector::push_back<u64>(v3, arg4);
        let v4 = UpdateConfigEvent{log: v2};
        0x2::event::emit<UpdateConfigEvent>(v4);
        *0x1::vector::borrow_mut<u64>(&mut v0.config, arg3) = arg4;
    }

    entry fun update_info(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg5);
        let v1 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v1);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(arg3 != 0, invalid_index());
        while (0x1::vector::length<u64>(&v0.info) < arg3 + 1) {
            0x1::vector::push_back<u64>(&mut v0.info, 0);
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, arg3));
        0x1::vector::push_back<u64>(v3, arg4);
        let v4 = UpdateInfoEvent{log: v2};
        0x2::event::emit<UpdateInfoEvent>(v4);
        *0x1::vector::borrow_mut<u64>(&mut v0.info, arg3) = arg4;
    }

    entry fun update_registry_setting(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(arg2 != 0, invalid_index());
        while (0x1::vector::length<u64>(&arg1.setting) < arg2 + 1) {
            0x1::vector::push_back<u64>(&mut arg1.setting, 0);
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&arg1.setting, arg2));
        0x1::vector::push_back<u64>(v2, arg3);
        let v3 = UpdateRegistrySettingEvent{log: v1};
        0x2::event::emit<UpdateRegistrySettingEvent>(v3);
        *0x1::vector::borrow_mut<u64>(&mut arg1.setting, arg2) = arg3;
    }

    entry fun withdraw_from_deepbook_balance_manager<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v1.id, 0x1::string::utf8(b"deepbook_balance_manager"));
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg5);
        let v3 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v3);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(v1.token != v0, invalid_token());
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v2) == 0) {
            return
        };
        let v4 = if (0x1::option::is_some<u64>(&arg3)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(v2, 0x1::option::destroy_some<u64>(arg3), arg5)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(v2, arg5)
        };
        let v5 = v4;
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, 0x2::coin::value<T0>(&v5));
        let v7 = WithdrawFromDeepbookBalanceManagerEvent{
            token : v0,
            log   : v6,
        };
        0x2::event::emit<WithdrawFromDeepbookBalanceManagerEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, arg4);
    }

    entry fun withdraw_fund_from_deepbook_balance_manager<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.vault_registry, arg2);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&mut v1.id, 0x1::string::utf8(b"deepbook_balance_manager"));
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v3 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v3);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(v1.token == v0, invalid_token());
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(v2) == 0) {
            return
        };
        let v4 = if (0x1::option::is_some<u64>(&arg3)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(v2, 0x1::option::destroy_some<u64>(arg3), arg4)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(v2, arg4)
        };
        let v5 = v4;
        let v6 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v6, 0x2::coin::value<T0>(&v5));
        let v7 = WithdrawFundFromDeepbookBalanceManagerEvent{
            token : v0,
            log   : v6,
        };
        0x2::event::emit<WithdrawFundFromDeepbookBalanceManagerEvent>(v7);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0), 0x2::coin::into_balance<T0>(v5));
    }

    fun zero_value() : u64 {
        abort 0
    }

    // decompiled from Move bytecode v6
}

