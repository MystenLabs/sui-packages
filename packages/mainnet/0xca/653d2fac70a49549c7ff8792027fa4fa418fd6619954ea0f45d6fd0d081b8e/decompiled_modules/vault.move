module 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        deposit_cap: u64,
        balance: u64,
        whitelisted_app_id: 0x2::object::ID,
        priority: u64,
        min_fee: u64,
        max_fee: u64,
        flash_loan_fee: u64,
        decimals: u8,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
        meta_coin_decimals: u8,
        active_assistant_cap: 0x2::object::ID,
        metadata: 0x2::object_bag::ObjectBag,
        total_priorities: u64,
        funds: 0x2::object_bag::ObjectBag,
        fees: 0x2::object_bag::ObjectBag,
    }

    struct DepositCap<phantom T0, phantom T1> {
        exchange_rate_meta_coin_to_coin_in: u128,
    }

    struct WithdrawCap<phantom T0, phantom T1> {
        exchange_rate_meta_coin_to_coin_out: u128,
    }

    struct FlashLoanReceipt<phantom T0, phantom T1> {
        amount: u64,
        fee: u64,
    }

    public fun borrow<T0>(arg0: &Vault<T0>, arg1: 0x1::type_name::TypeName) : &Metadata {
        0x2::object_bag::borrow<0x1::type_name::TypeName, Metadata>(&arg0.metadata, arg1)
    }

    fun borrow_mut<T0>(arg0: &mut Vault<T0>, arg1: 0x1::type_name::TypeName) : &mut Metadata {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, Metadata>(&mut arg0.metadata, arg1)
    }

    public fun swap<T0, T1, T2>(arg0: &mut Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: DepositCap<T0, T1>, arg3: WithdrawCap<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let DepositCap { exchange_rate_meta_coin_to_coin_in: v0 } = arg2;
        let v1 = 0x2::coin::value<T1>(&arg4);
        join<T0, T1>(arg0, arg4);
        let WithdrawCap { exchange_rate_meta_coin_to_coin_out: v2 } = arg3;
        let v3 = convert_coin_in_amount_to_coin_out_amount<T0, T1, T2>(arg0, v1, v0, v2);
        let v4 = split<T0, T2>(arg0, v3, v2, arg6);
        let v5 = 0x2::coin::value<T2>(&v4);
        assert!(arg5 <= v5, 9223373621698887699);
        assert!(v5 != 0, 9223373630288691217);
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_swap_event<T1, T2>(0x2::object::uid_to_inner(&arg0.id), v1, balance_of<T0, T1>(arg0), v5, balance_of<T0, T2>(arg0), v3 - v5, v0, v2);
        v4
    }

    public fun balance(arg0: &Metadata) : u64 {
        arg0.balance
    }

    public fun supply_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    fun join<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 != 0, 9223376855808737291);
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.metadata, v1), 9223376877283049475);
        let v2 = borrow_mut<T0>(arg0, v1);
        let v3 = v2.balance + v0;
        assert!(v3 <= v2.deposit_cap, 9223376907347951621);
        v2.balance = v3;
        0x2::coin::join<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v1), arg1);
    }

    fun split<T0, T1>(arg0: &mut Vault<T0>, arg1: u64, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v0);
        assert!(arg1 <= 0x2::coin::value<T1>(v1), 9223377066261872647);
        let v2 = 0x2::coin::split<T1>(v1, arg1, arg3);
        let v3 = &mut v2;
        take_fee<T0, T1>(arg0, v3, arg2, arg3);
        let v4 = borrow_mut<T0>(arg0, v0);
        v4.balance = v4.balance - arg1;
        v2
    }

    public fun add_support_for_new_coin<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::coin::CoinMetadata<T1>, arg9: &mut 0x2::tx_context::TxContext) {
        add_support_for_new_coin_unsafe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::get_decimals<T1>(arg8), arg9);
    }

    public fun add_support_for_new_coin_unsafe<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223374472101756937);
        let v1 = Metadata{
            id                 : 0x2::object::new(arg9),
            vault_id           : 0x2::object::uid_to_inner(&arg2.id),
            deposit_cap        : arg4,
            balance            : 0,
            whitelisted_app_id : 0x2::object::id_from_address(arg3),
            priority           : arg7,
            min_fee            : arg5,
            max_fee            : arg6,
            flash_loan_fee     : (0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::one_hundred_percent_base_18() as u64),
            decimals           : arg8,
        };
        0x2::object_bag::add<0x1::type_name::TypeName, Metadata>(&mut arg2.metadata, v0, v1);
        arg2.total_priorities = arg2.total_priorities + arg7;
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.funds, v0, 0x2::coin::zero<T1>(arg9));
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.fees, v0, 0x2::coin::zero<T1>(arg9));
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_support_coin_event<T1>(0x2::object::uid_to_inner(&arg2.id), arg4, arg5, arg6, arg7, arg8);
    }

    fun apply_exchange_rate(arg0: u64, arg1: u128, arg2: u128, arg3: u8, arg4: u8) : u64 {
        if (arg4 <= arg3) {
            0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::normalize_decimals(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::multiply_and_divide(arg0, arg1, arg2), arg3, arg4)
        } else {
            0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::multiply_and_divide(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::normalize_decimals(arg0, arg3, arg4), arg1, arg2)
        }
    }

    public fun assistant_begin_flash_loan<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap, arg1: &mut Vault<T0>, arg2: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoanReceipt<T0, T1>) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg2);
        assert!(arg1.active_assistant_cap == 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap>(arg0), 9223375786362535957);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg1.metadata, v0), 9223375803541225475);
        let v1 = FlashLoanReceipt<T0, T1>{
            amount : arg3,
            fee    : 0,
        };
        (0x2::coin::split<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg1.funds, v0), arg3, arg4), v1)
    }

    public fun assistant_set_max_fee<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        assert!(arg2.active_assistant_cap == 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap>(arg0), 9223375691873255445);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375713346912259);
        borrow_mut<T0>(arg2, v0).max_fee = arg3;
    }

    public fun assistant_set_min_fee<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        assert!(arg2.active_assistant_cap == 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap>(arg0), 9223375601678942229);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375623152599043);
        borrow_mut<T0>(arg2, v0).min_fee = arg3;
    }

    public fun balance_of<T0, T1>(arg0: &Vault<T0>) : u64 {
        borrow<T0>(arg0, 0x1::type_name::get<T1>()).balance
    }

    public fun begin_flash_loan<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoanReceipt<T0, T1>) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.metadata, v0), 9223376383361810435);
        let v1 = FlashLoanReceipt<T0, T1>{
            amount : arg2,
            fee    : borrow<T0>(arg0, v0).flash_loan_fee,
        };
        (0x2::coin::split<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, v0), arg2, arg3), v1)
    }

    fun burn<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, 0x2::coin::into_balance<T0>(arg1));
    }

    fun convert_coin_in_amount_to_coin_out_amount<T0, T1, T2>(arg0: &Vault<T0>, arg1: u64, arg2: u128, arg3: u128) : u64 {
        apply_exchange_rate(arg1, arg2, arg3, decimals_of<T0, T1>(arg0), decimals_of<T0, T2>(arg0))
    }

    fun convert_coin_in_amount_to_meta_coin_amount<T0, T1>(arg0: &Vault<T0>, arg1: u64, arg2: u128) : u64 {
        apply_exchange_rate(arg1, arg2, 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::exchange_rate_one_to_one(), decimals_of<T0, T1>(arg0), arg0.meta_coin_decimals)
    }

    fun convert_meta_coin_amount_to_coin_out_amount<T0, T1>(arg0: &Vault<T0>, arg1: u64, arg2: u128) : u64 {
        apply_exchange_rate(arg1, 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::exchange_rate_one_to_one(), arg2, arg0.meta_coin_decimals, decimals_of<T0, T1>(arg0))
    }

    public fun create_deposit_cap<T0, T1>(arg0: &0x2::object::UID, arg1: &Vault<T0>, arg2: u128) : DepositCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::assert_app_is_authorized(arg0);
        assert!(0x2::object::uid_to_inner(arg0) == borrow<T0>(arg1, 0x1::type_name::get<T1>()).whitelisted_app_id, 9223376056944951309);
        DepositCap<T0, T1>{exchange_rate_meta_coin_to_coin_in: arg2}
    }

    public fun create_vault<T0>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x2::coin::treasury_into_supply<T0>(arg2);
        assert!(0x2::balance::supply_value<T0>(&v0) == 0, 9223373067646926849);
        let v1 = Vault<T0>{
            id                   : 0x2::object::new(arg4),
            supply               : v0,
            meta_coin_decimals   : 0x2::coin::get_decimals<T0>(arg3),
            active_assistant_cap : 0x2::object::id_from_address(@0x0),
            metadata             : 0x2::object_bag::new(arg4),
            total_priorities     : 0,
            funds                : 0x2::object_bag::new(arg4),
            fees                 : 0x2::object_bag::new(arg4),
        };
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_create_vault_event<T0>(0x2::object::uid_to_inner(&v1.id), v1.meta_coin_decimals);
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun create_withdraw_cap<T0, T1>(arg0: &0x2::object::UID, arg1: &Vault<T0>, arg2: u128) : WithdrawCap<T0, T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::assert_app_is_authorized(arg0);
        assert!(0x2::object::uid_to_inner(arg0) == borrow<T0>(arg1, 0x1::type_name::get<T1>()).whitelisted_app_id, 9223376250218610703);
        WithdrawCap<T0, T1>{exchange_rate_meta_coin_to_coin_out: arg2}
    }

    public fun decimals(arg0: &Metadata) : u8 {
        arg0.decimals
    }

    public fun decimals_of<T0, T1>(arg0: &Vault<T0>) : u8 {
        borrow<T0>(arg0, 0x1::type_name::get<T1>()).decimals
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: DepositCap<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let DepositCap { exchange_rate_meta_coin_to_coin_in: v0 } = arg2;
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = convert_coin_in_amount_to_meta_coin_amount<T0, T1>(arg0, v1, v0);
        assert!(arg4 <= v2, 9223373870806990867);
        join<T0, T1>(arg0, arg3);
        let v3 = mint<T0>(arg0, v2, arg5);
        assert!(0x2::coin::value<T0>(&v3) != 0, 9223373909461565457);
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_deposit_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v2, supply_value<T0>(arg0), v1, balance_of<T0, T1>(arg0), v0);
        v3
    }

    public fun deposit_cap(arg0: &Metadata) : u64 {
        arg0.deposit_cap
    }

    public fun finish_flash_loan<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0x2::coin::Coin<T1>, arg3: FlashLoanReceipt<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let FlashLoanReceipt {
            amount : v0,
            fee    : v1,
        } = arg3;
        let v2 = if (v1 > 0) {
            0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::multiply_and_divide(v0, (v1 as u128), 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::one_hundred_percent_base_18())
        } else {
            0
        };
        assert!(0x2::coin::value<T1>(&arg2) >= v0 + v2, 9223376589521551383);
        if (v2 > 0) {
            join_fee<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg2, v2, arg4));
        };
        0x2::coin::join<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.funds, 0x1::type_name::get<T1>()), arg2);
    }

    public fun flash_loan_fee(arg0: &Metadata) : u64 {
        arg0.flash_loan_fee
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap>(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::create_admin_cap<VAULT>(&arg0, arg1), v0);
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::create_version<VAULT>(&arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<VAULT>(arg0, arg1), v0);
    }

    fun join_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::join<T1>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.fees, 0x1::type_name::get<T1>()), arg1);
    }

    public fun max_fee(arg0: &Metadata) : u64 {
        arg0.max_fee
    }

    public fun min_fee(arg0: &Metadata) : u64 {
        arg0.min_fee
    }

    fun mint<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.supply, arg1), arg2)
    }

    public fun priority(arg0: &Metadata) : u64 {
        arg0.priority
    }

    public fun rotate_assistant_cap<T0>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::create_vault_assistant_cap(0x2::object::uid_to_inner(&arg2.id), arg4);
        arg2.active_assistant_cap = 0x2::object::id<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap>(&v0);
        0x2::transfer::public_transfer<0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault_assistant::VaultAssistantCap>(v0, arg3);
    }

    public fun set_balance<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375000382341123);
        borrow_mut<T0>(arg2, v0).balance = arg3;
    }

    public fun set_decimals<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u8) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375524368351235);
        borrow_mut<T0>(arg2, v0).decimals = arg3;
    }

    public fun set_deposit_cap<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223374935957831683);
        borrow_mut<T0>(arg2, v0).deposit_cap = arg3;
    }

    public fun set_flash_loan_fee<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375421289136131);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        let v2 = borrow_mut<T0>(arg2, v0);
        v2.flash_loan_fee = arg3;
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_update_fee_event<T1>(v1, v2.min_fee, v2.max_fee, v2.flash_loan_fee);
    }

    public fun set_max_fee<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375322504888323);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        let v2 = borrow_mut<T0>(arg2, v0);
        v2.max_fee = arg3;
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_update_fee_event<T1>(v1, v2.min_fee, v2.max_fee, v2.flash_loan_fee);
    }

    public fun set_min_fee<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375219425673219);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        let v2 = borrow_mut<T0>(arg2, v0);
        v2.min_fee = arg3;
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_update_fee_event<T1>(v1, v2.min_fee, v2.max_fee, v2.flash_loan_fee);
    }

    public fun set_priority<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: u64) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375129231360003);
        arg2.total_priorities = arg2.total_priorities + arg3 - borrow<T0>(arg2, v0).priority;
        borrow_mut<T0>(arg2, v0).priority = arg3;
    }

    public fun set_whitelisted_app_id<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: address) {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223375064806850563);
        borrow_mut<T0>(arg2, v0).whitelisted_app_id = 0x2::object::id_from_address(arg3);
    }

    fun take_fee<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, 0x1::type_name::get<T1>());
        let v1 = 0x2::coin::value<T1>(arg1);
        let v2 = 0x2::coin::split<T1>(arg1, 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::calculate_dynamic_fee(v1, convert_meta_coin_amount_to_coin_out_amount<T0, T1>(arg0, 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::math::multiply_and_divide(supply_value<T0>(arg0), (v0.priority as u128), (arg0.total_priorities as u128)), arg2), v0.balance - v1, v0.max_fee, v0.min_fee), arg3);
        join_fee<T0, T1>(arg0, v2);
    }

    public fun whitelisted_app_id(arg0: &Metadata) : 0x2::object::ID {
        arg0.whitelisted_app_id
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: WithdrawCap<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let WithdrawCap { exchange_rate_meta_coin_to_coin_out: v0 } = arg2;
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = convert_meta_coin_amount_to_coin_out_amount<T0, T1>(arg0, v1, v0);
        let v3 = split<T0, T1>(arg0, v2, v0, arg5);
        let v4 = 0x2::coin::value<T1>(&v3);
        assert!(arg4 <= v4, 9223374149979865107);
        assert!(v4 != 0, 9223374158569668625);
        burn<T0>(arg0, arg3);
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_withdraw_event<T0, T1>(0x2::object::uid_to_inner(&arg0.id), v1, supply_value<T0>(arg0), v4, balance_of<T0, T1>(arg0), v2 - v4, v0);
        v3
    }

    public fun withdraw_fees<T0, T1>(arg0: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin::AdminCap, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: &mut Vault<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::assert_correct_package(arg1);
        let v0 = 0x1::type_name::get<T1>();
        assert!(0x2::object_bag::contains<0x1::type_name::TypeName>(&arg2.metadata, v0), 9223374751274237955);
        let v1 = 0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg2.fees, v0);
        0x2::coin::split<T1>(v1, 0x2::coin::value<T1>(v1), arg3)
    }

    // decompiled from Move bytecode v6
}

