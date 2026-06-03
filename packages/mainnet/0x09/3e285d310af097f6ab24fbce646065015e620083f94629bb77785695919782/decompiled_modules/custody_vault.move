module 0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::custody_vault {
    struct NativeCustody has drop {
        dummy_field: bool,
    }

    struct FeeConfig has copy, drop, store {
        mint_fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        burn_fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
    }

    struct SingleVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimal: u8,
        default_fee_config: FeeConfig,
        partner_fee_configs: 0x2::vec_map::VecMap<address, FeeConfig>,
        min_burn_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        balance_amount: u64,
        credit_backing: u64,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NativeCustody>,
        deprecated: bool,
    }

    struct CustodyVault<phantom T0> has key {
        id: 0x2::object::UID,
        credit_supply: u64,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
    }

    struct VaultKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun balance<T0>(arg0: &SingleVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun sheet<T0>(arg0: &SingleVault<T0>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, NativeCustody> {
        &arg0.sheet
    }

    public fun mint<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::DepositRequest<T1> {
        assert_valid_package<T1>(arg1);
        let v0 = mint_fee_rate<T0, T1>(arg0, 0x2::object::id_to_address(&arg3));
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::request_deposit<T1>(arg2, arg3, mint_internal<T0, T1>(arg0, arg1, arg4, v0, arg6), arg5)
    }

    public fun add_asset<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u8, arg3: u128, arg4: u128, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T1>(arg0);
        assert!(!has_asset<T0, T1>(arg0), 13906834951733444624);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg3);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg4);
        assert_fee_rate(v0);
        assert_fee_rate(v1);
        let v2 = FeeConfig{
            mint_fee_rate : v0,
            burn_fee_rate : v1,
        };
        let v3 = SingleVault<T0>{
            id                  : 0x2::object::new(arg6),
            decimal             : arg2,
            default_fee_config  : v2,
            partner_fee_configs : 0x2::vec_map::empty<address, FeeConfig>(),
            min_burn_amount     : arg5,
            balance             : 0x2::balance::zero<T0>(),
            balance_amount      : 0,
            credit_backing      : 0,
            sheet               : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, NativeCustody>(witness()),
            deprecated          : false,
        };
        let v4 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<VaultKey<T0>, SingleVault<T0>>(&mut arg0.id, v4, v3);
        0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::events::emit_asset_added<T1, T0>(0x2::object::id<CustodyVault<T1>>(arg0), 0x2::object::id<SingleVault<T0>>(&v3), arg2, v0, v1, arg5);
    }

    public fun add_version<T0>(arg0: &mut CustodyVault<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
    }

    fun assert_fee_rate(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one())) {
            abort 13906836652539576322
        };
    }

    public(friend) fun assert_valid_package<T0>(arg0: &0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T0>) {
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::assert_valid_module_version<T0, NativeCustody>(arg0, package_version());
    }

    fun assert_valid_package_version<T0>(arg0: &CustodyVault<T0>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0), 13906834548006780948);
    }

    public fun balance_amount<T0>(arg0: &SingleVault<T0>) : u64 {
        arg0.balance_amount
    }

    fun borrow_single_mut<T0, T1>(arg0: &mut CustodyVault<T1>) : &mut SingleVault<T0> {
        assert!(has_asset<T0, T1>(arg0), 13906835956755660814);
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<VaultKey<T0>, SingleVault<T0>>(&mut arg0.id, v0)
    }

    public fun burn_authorized<T0, T1, T2: drop>(arg0: &mut CustodyVault<T1>, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: T2, arg3: u16, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package<T1>(arg1);
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::assert_valid_module_version<T1, T2>(arg1, arg3);
        let v0 = burn_fee_rate<T0, T1>(arg0, 0x2::object::id_to_address(&arg4));
        burn_internal<T0, T1>(arg0, arg1, arg4, arg5, v0, arg6, arg7)
    }

    public fun burn_fee_rate<T0, T1>(arg0: &CustodyVault<T1>, arg1: address) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = single_vault<T0, T1>(arg0);
        if (0x2::vec_map::contains<address, FeeConfig>(&v0.partner_fee_configs, &arg1)) {
            0x2::vec_map::get<address, FeeConfig>(&v0.partner_fee_configs, &arg1).burn_fee_rate
        } else {
            v0.default_fee_config.burn_fee_rate
        }
    }

    fun burn_internal<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T1>, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        if (v0 == 0) {
            abort 13906836257402716164
        };
        let v1 = borrow_single_mut<T0, T1>(arg0);
        if (v0 < v1.min_burn_amount) {
            abort 13906836270288142348
        };
        let v2 = convert_credit_to_asset_amount(v0, v1.decimal);
        if (v2 == 0) {
            abort 13906836278877945866
        };
        if (convert_asset_to_credit_amount(v2, v1.decimal) != v0) {
            abort 13906836321827225604
        };
        if (v2 > 0x2::balance::value<T0>(&v1.balance)) {
            abort 13906836326122323974
        };
        if (v1.credit_backing < v0) {
            abort 13906836330417291270
        };
        v1.credit_backing = v1.credit_backing - v0;
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, v2), arg6);
        v1.balance_amount = convert_credit_to_asset_amount(v1.credit_backing, v1.decimal);
        arg0.credit_supply = arg0.credit_supply - v0;
        0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::burn<T1, NativeCustody>(arg1, arg2, witness(), package_version(), arg3, arg5);
        let v4 = fee_from_amount(v2, arg4);
        if (v4 > 0) {
            0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::collect<T1, T0, NativeCustody>(arg1, witness(), package_version(), memo_burn(), 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v3), v4));
        };
        0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::events::emit_burn<T1, T0>(v0, v1.credit_backing, v2, v1.balance_amount, arg0.credit_supply, v4);
        v3
    }

    fun checked_mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 > 18446744073709551615) {
            abort 13906836631065133064
        };
        (v0 as u64)
    }

    fun convert_asset_to_credit_amount(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 6) {
            return arg0
        };
        if (arg1 < 6) {
            checked_mul(arg0, pow10(((6 - arg1) as u64)))
        } else {
            arg0 / pow10(((arg1 - 6) as u64))
        }
    }

    fun convert_credit_to_asset_amount(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 6) {
            return arg0
        };
        if (arg1 < 6) {
            arg0 / pow10(((6 - arg1) as u64))
        } else {
            checked_mul(arg0, pow10(((arg1 - 6) as u64)))
        }
    }

    public fun create_vault<T0>(arg0: &0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_package<T0>(arg0);
        let v0 = CustodyVault<T0>{
            id               : 0x2::object::new(arg2),
            credit_supply    : 0,
            allowed_versions : 0x2::vec_set::singleton<u16>(1),
        };
        0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::events::emit_new_custody_vault<T0>(0x2::object::id<CustodyVault<T0>>(&v0));
        0x2::transfer::share_object<CustodyVault<T0>>(v0);
    }

    public fun credit_backing<T0>(arg0: &SingleVault<T0>) : u64 {
        arg0.credit_backing
    }

    public fun credit_supply<T0>(arg0: &CustodyVault<T0>) : u64 {
        arg0.credit_supply
    }

    public fun decimal<T0>(arg0: &SingleVault<T0>) : u8 {
        arg0.decimal
    }

    public fun deposit_liquidity<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg3: 0x2::coin::Coin<T0>) {
        assert_valid_package<T1>(arg1);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            abort 13906835338279714820
        };
        0x2::balance::join<T0>(&mut borrow_single_mut<T0, T1>(arg0).balance, 0x2::coin::into_balance<T0>(arg3));
    }

    public fun deprecated<T0>(arg0: &SingleVault<T0>) : bool {
        arg0.deprecated
    }

    fun fee_from_amount(arg0: u64, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : u64 {
        if (arg0 == 0 || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg1, arg0))
    }

    public fun has_asset<T0, T1>(arg0: &CustodyVault<T1>) : bool {
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<VaultKey<T0>, SingleVault<T0>>(&arg0.id, v0)
    }

    public fun memo_burn() : 0x1::string::String {
        0x1::string::utf8(b"custody_burn")
    }

    public fun memo_mint() : 0x1::string::String {
        0x1::string::utf8(b"custody_mint")
    }

    public fun min_burn_amount<T0>(arg0: &SingleVault<T0>) : u64 {
        arg0.min_burn_amount
    }

    public fun mint_fee_rate<T0, T1>(arg0: &CustodyVault<T1>, arg1: address) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = single_vault<T0, T1>(arg0);
        if (0x2::vec_map::contains<address, FeeConfig>(&v0.partner_fee_configs, &arg1)) {
            0x2::vec_map::get<address, FeeConfig>(&v0.partner_fee_configs, &arg1).mint_fee_rate
        } else {
            v0.default_fee_config.mint_fee_rate
        }
    }

    public fun mint_from_request<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::DepositRequest<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::DepositRequest<T1> {
        let (v0, v1, v2) = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::consume_deposit<T0, NativeCustody>(arg2, arg3, witness());
        let v3 = 0x2::coin::from_balance<T0>(v1, arg4);
        mint<T0, T1>(arg0, arg1, arg2, v0, v3, v2, arg4)
    }

    fun mint_internal<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            abort 13906836008294612996
        };
        let v1 = borrow_single_mut<T0, T1>(arg0);
        if (v1.deprecated) {
            abort 13906836021180432402
        };
        let v2 = convert_asset_to_credit_amount(v0, v1.decimal);
        if (v2 == 0) {
            abort 13906836029769449476
        };
        if (convert_credit_to_asset_amount(v2, v1.decimal) != v0) {
            abort 13906836046949318660
        };
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg2));
        v1.credit_backing = v1.credit_backing + v2;
        v1.balance_amount = convert_credit_to_asset_amount(v1.credit_backing, v1.decimal);
        arg0.credit_supply = arg0.credit_supply + v2;
        let v3 = 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::mint<T1, NativeCustody>(arg1, witness(), package_version(), v2, arg4);
        let v4 = fee_from_amount(v2, arg3);
        if (v4 > 0) {
            0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::collect<T1, T1, NativeCustody>(arg1, witness(), package_version(), memo_mint(), 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v3), v4));
        };
        0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::events::emit_mint<T1, T0>(v0, v1.balance_amount, v2, v1.credit_backing, arg0.credit_supply, v4);
        v3
    }

    public fun package_version() : u16 {
        1
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = checked_mul(v0, 10);
            v1 = v1 + 1;
        };
        v0
    }

    public fun remove_version<T0>(arg0: &mut CustodyVault<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
    }

    public fun set_asset_deprecated<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: bool) {
        assert_valid_package_version<T1>(arg0);
        borrow_single_mut<T0, T1>(arg0).deprecated = arg2;
    }

    public fun set_fee_config<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: 0x1::option::Option<address>, arg3: u128, arg4: u128) {
        assert_valid_package_version<T1>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg3);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg4);
        assert_fee_rate(v0);
        assert_fee_rate(v1);
        let v2 = borrow_single_mut<T0, T1>(arg0);
        if (0x1::option::is_some<address>(&arg2)) {
            let v3 = 0x1::option::destroy_some<address>(arg2);
            let v4 = FeeConfig{
                mint_fee_rate : v0,
                burn_fee_rate : v1,
            };
            if (0x2::vec_map::contains<address, FeeConfig>(&v2.partner_fee_configs, &v3)) {
                let v5 = 0x2::vec_map::get_mut<address, FeeConfig>(&mut v2.partner_fee_configs, &v3);
                v5.mint_fee_rate = v0;
                v5.burn_fee_rate = v1;
            } else {
                0x2::vec_map::insert<address, FeeConfig>(&mut v2.partner_fee_configs, v3, v4);
            };
        } else {
            v2.default_fee_config.mint_fee_rate = v0;
            v2.default_fee_config.burn_fee_rate = v1;
        };
    }

    public fun set_min_burn_amount<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u64) {
        assert_valid_package_version<T1>(arg0);
        borrow_single_mut<T0, T1>(arg0).min_burn_amount = arg2;
    }

    public fun single_vault<T0, T1>(arg0: &CustodyVault<T1>) : &SingleVault<T0> {
        assert!(has_asset<T0, T1>(arg0), 13906835789251936270);
        let v0 = VaultKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<VaultKey<T0>, SingleVault<T0>>(&arg0.id, v0)
    }

    public fun withdraw_liquidity<T0, T1>(arg0: &mut CustodyVault<T1>, arg1: &0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg2: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package<T1>(arg1);
        if (arg3 == 0) {
            abort 13906835394114289668
        };
        let v0 = borrow_single_mut<T0, T1>(arg0);
        if (arg3 + convert_credit_to_asset_amount(v0.credit_backing, v0.decimal) > 0x2::balance::value<T0>(&v0.balance)) {
            abort 13906835411294289926
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, arg3), arg4)
    }

    public(friend) fun witness() : NativeCustody {
        NativeCustody{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

