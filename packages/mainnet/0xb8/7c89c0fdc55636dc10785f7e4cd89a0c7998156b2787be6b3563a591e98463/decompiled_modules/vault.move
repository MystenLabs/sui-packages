module 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::vault {
    struct VaultRegistry has store, key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<0x2::object::ID, 0x1::string::String>,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        created_at: u64,
        quote_validator: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::quote_validator::QuoteValidator,
        distributor: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::Distributor,
        acl: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::ACL,
    }

    struct DepositCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct SwapReceipt<phantom T0, phantom T1> {
        source_amount: u64,
        quote_provider: 0x1::string::String,
        target_min_amount: u64,
        target_quote_amount: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        created_at: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct SwapEvent has copy, drop {
        vault_id: 0x2::object::ID,
        source_coin_type: 0x1::type_name::TypeName,
        target_coin_type: 0x1::type_name::TypeName,
        quote_provider: 0x1::string::String,
        source_amount: u64,
        target_quote_amount: u64,
        target_min_amount: u64,
        target_amount: u64,
    }

    struct SetDefaultQuoteConfigEvent has copy, drop {
        old: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        new: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct SetQuoteConfigEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        old: 0x1::option::Option<0x2::vec_map::VecMap<0x1::string::String, u64>>,
        new: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct RemoveQuoteConfigEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        old: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct SetDistributeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        old: 0x1::option::Option<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry>,
        new: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry,
    }

    struct RemoveDistributeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        old: 0x1::option::Option<0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry>,
    }

    struct SetDefaultDistributeEvent has copy, drop {
        old: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry,
        new: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry,
    }

    struct WithdrawTargetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawSourceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun remove_member(arg0: &mut Vault, arg1: address, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_admin_role(arg0, arg3);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::remove_member(&mut arg0.acl, arg1);
    }

    public fun set_roles(arg0: &mut Vault, arg1: u128, arg2: address, arg3: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg3);
        check_admin_role(arg0, arg4);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::set_roles(&mut arg0.acl, arg2, arg1);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut DepositCap, arg3: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg3);
        check_deposit_cap(arg0, arg2);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::deposit<T0>(&mut arg0.distributor, arg1);
        let v0 = DepositEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun remove_distribute<T0>(arg0: &mut Vault, arg1: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg2: &0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg1);
        check_manager_role(arg0, arg2);
        let v0 = RemoveDistributeEvent{
            coin_type : 0x1::type_name::get<T0>(),
            old       : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::remove_distribute<T0>(&mut arg0.distributor),
        };
        0x2::event::emit<RemoveDistributeEvent>(v0);
    }

    public fun set_default_distribute(arg0: &mut Vault, arg1: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_manager_role(arg0, arg3);
        let v0 = SetDefaultDistributeEvent{
            old : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::set_default_distribute(&mut arg0.distributor, arg1),
            new : arg1,
        };
        0x2::event::emit<SetDefaultDistributeEvent>(v0);
    }

    public fun set_distribute<T0>(arg0: &mut Vault, arg1: 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::DistributorEntry, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_manager_role(arg0, arg3);
        let v0 = SetDistributeEvent{
            coin_type : 0x1::type_name::get<T0>(),
            old       : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::set_distribute<T0>(&mut arg0.distributor, arg1),
            new       : arg1,
        };
        0x2::event::emit<SetDistributeEvent>(v0);
    }

    public fun withdraw_source<T0>(arg0: &mut Vault, arg1: u64, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_withdraw_role(arg0, arg3);
        let v0 = 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::withdraw_source<T0>(&mut arg0.distributor, arg1);
        let v1 = WithdrawSourceEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawSourceEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun withdraw_target<T0>(arg0: &mut Vault, arg1: u64, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_withdraw_role(arg0, arg3);
        let v0 = 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::withdraw_target<T0>(&mut arg0.distributor, arg1);
        let v1 = WithdrawTargetEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawTargetEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun remove_quote_config<T0>(arg0: &mut Vault, arg1: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg2: &0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg1);
        check_manager_role(arg0, arg2);
        let v0 = RemoveQuoteConfigEvent{
            coin_type : 0x1::type_name::get<T0>(),
            old       : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::quote_validator::remove_quote_config<T0>(&mut arg0.quote_validator),
        };
        0x2::event::emit<RemoveQuoteConfigEvent>(v0);
    }

    public fun set_default_quote_config(arg0: &mut Vault, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_manager_role(arg0, arg3);
        let v0 = SetDefaultQuoteConfigEvent{
            old : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::quote_validator::set_default_quote_config(&mut arg0.quote_validator, arg1),
            new : arg1,
        };
        0x2::event::emit<SetDefaultQuoteConfigEvent>(v0);
    }

    public fun set_quote_config<T0>(arg0: &mut Vault, arg1: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg2: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg2);
        check_manager_role(arg0, arg3);
        let v0 = SetQuoteConfigEvent{
            coin_type : 0x1::type_name::get<T0>(),
            old       : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::quote_validator::set_quote_config<T0>(&mut arg0.quote_validator, arg1),
            new       : arg1,
        };
        0x2::event::emit<SetQuoteConfigEvent>(v0);
    }

    public fun check_admin_role(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 0), 13906836012589645829);
    }

    public fun check_deposit_cap(arg0: &Vault, arg1: &mut DepositCap) {
        assert!(0x2::object::id<Vault>(arg0) == arg1.vault_id, 13906836081309122565);
    }

    public fun check_manager_role(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 1), 13906835973934940165);
    }

    public fun check_swap_role(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 2), 13906836051244351493);
    }

    public fun check_withdraw_role(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 3), 13906836119963828229);
    }

    public fun create_vault(arg0: &mut VaultRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::admin_cap::AdminCap, arg5: &0x2::clock::Clock, arg6: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg7: &mut 0x2::tx_context::TxContext) : DepositCap {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg6);
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = Vault{
            id              : 0x2::object::new(arg7),
            name            : arg1,
            description     : arg2,
            created_at      : v0,
            quote_validator : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::quote_validator::default(),
            distributor     : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::new(arg7),
            acl             : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::new(arg7),
        };
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::acl::add_role(&mut v1.acl, arg3, 0);
        0x2::table::add<0x2::object::ID, 0x1::string::String>(&mut arg0.vaults, 0x2::object::id<Vault>(&v1), arg1);
        let v2 = 0x2::object::id<Vault>(&v1);
        let v3 = VaultCreatedEvent{
            vault_id    : v2,
            name        : arg1,
            description : arg2,
            created_at  : v0,
        };
        0x2::event::emit<VaultCreatedEvent>(v3);
        0x2::transfer::share_object<Vault>(v1);
        DepositCap{
            id       : 0x2::object::new(arg7),
            vault_id : v2,
        }
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut DepositCap, arg3: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned) {
        deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3);
    }

    public fun flash_swap<T0, T1>(arg0: &mut Vault, arg1: u64, arg2: 0x6315cdc2fb51f03681f94f90b1c97b667385dedea8ac8f7d96dfe4df8d249f4c::trust_quote::TrustQuote<T0, T1>, arg3: &0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapReceipt<T0, T1>) {
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::versioned::check_version(arg3);
        check_swap_role(arg0, arg4);
        let v0 = 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::take_source_for_swap<T0, T1>(&mut arg0.distributor, arg1);
        assert!(0x2::balance::value<T0>(&v0) >= arg1, 13906835114941612039);
        let v1 = SwapReceipt<T0, T1>{
            source_amount       : arg1,
            quote_provider      : 0x6315cdc2fb51f03681f94f90b1c97b667385dedea8ac8f7d96dfe4df8d249f4c::trust_quote::provider<T0, T1>(&arg2),
            target_min_amount   : 0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::quote_validator::validate_quote<T0, T1>(&arg0.quote_validator, arg2, arg1),
            target_quote_amount : 0x6315cdc2fb51f03681f94f90b1c97b667385dedea8ac8f7d96dfe4df8d249f4c::trust_quote::amount_out<T0, T1>(&arg2),
        };
        (0x2::coin::from_balance<T0>(v0, arg4), v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::table::new<0x2::object::ID, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<VaultRegistry>(v0);
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T1>, arg2: SwapReceipt<T0, T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 >= arg2.target_min_amount, 13906835222315925513);
        0xa609c916c2c64226ee928aa55449575daf21caa95afd9a1ed10f4e237d6faaf9::distributor::merge_to_target_balances<T1>(&mut arg0.distributor, 0x2::coin::into_balance<T1>(arg1), 1);
        let SwapReceipt {
            source_amount       : v1,
            quote_provider      : v2,
            target_min_amount   : v3,
            target_quote_amount : v4,
        } = arg2;
        let v5 = SwapEvent{
            vault_id            : 0x2::object::id<Vault>(arg0),
            source_coin_type    : 0x1::type_name::get<T0>(),
            target_coin_type    : 0x1::type_name::get<T1>(),
            quote_provider      : v2,
            source_amount       : v1,
            target_quote_amount : v4,
            target_min_amount   : v3,
            target_amount       : v0,
        };
        0x2::event::emit<SwapEvent>(v5);
    }

    public fun vault_id(arg0: &DepositCap) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

