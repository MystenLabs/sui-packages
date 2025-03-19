module 0xc6fe3e883e6deb9dff386ecb3e54bb3cf521a1e9dc9894c44c87587d4b5139b4::flashloan {
    struct BalanceRecord has key {
        id: 0x2::object::UID,
    }

    struct BalanceManager<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee: u64,
        version: u64,
    }

    struct FlashLoanRecipient<phantom T0> {
        amount: u64,
    }

    struct WithdrawInfo has drop {
        balance_id: 0x2::object::ID,
        amount: u64,
        sender: address,
        version: u64,
    }

    struct SetFeeInfo has drop {
        balance_id: 0x2::object::ID,
        fee: u64,
        sender: address,
        version: u64,
    }

    public fun calc_coin_to_scoin<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock, arg3: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats<T0>(arg0, arg1, arg2);
        let v4 = if (v3 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg3, v3, v0 + v1 - v2)
        } else {
            arg3
        };
        assert!(v4 > 0, 1001);
        v4
    }

    public fun create_balance_manager<T0>(arg0: &mut BalanceRecord, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceManager<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
            fee     : arg1,
            version : 0,
        };
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()), 0x2::object::id<BalanceManager<T0>>(&v0));
        0x2::transfer::share_object<BalanceManager<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut BalanceManager<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_balance_manager_id<T0>(arg0: &BalanceRecord) : &0x2::object::ID {
        0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    fun get_reserve_stats<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg2);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::get<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceRecord{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BalanceRecord>(v0);
    }

    public fun loan<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanRecipient<T0>) {
        let v0 = FlashLoanRecipient<T0>{amount: arg1};
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), v0)
    }

    public fun repay<T0>(arg0: &mut BalanceManager<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanRecipient<T0>) {
        let FlashLoanRecipient { amount: v0 } = arg2;
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        assert!(0x2::balance::value<T0>(&v1) >= v0 + arg0.fee, 9223372951682809855);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
    }

    public fun sca_loan<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg3: &mut BalanceManager<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoanRecipient<T0>) {
        let v0 = calc_coin_to_scoin<T1>(arg0, arg1, arg5, arg4);
        let v1 = FlashLoanRecipient<T0>{amount: v0};
        (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg0, arg1, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.balance, v0), arg6), arg6), arg5, arg6), v1)
    }

    public fun sca_repay<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg3: &mut BalanceManager<T0>, arg4: 0x2::coin::Coin<T1>, arg5: FlashLoanRecipient<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let FlashLoanRecipient { amount: v0 } = arg5;
        let v1 = 0x2::coin::into_balance<T0>(0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T0, T1>(arg2, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg0, arg1, arg4, arg6, arg7), arg7));
        assert!(0x2::balance::value<T0>(&v1) >= v0 + arg3.fee, 9223372835718692863);
        0x2::balance::join<T0>(&mut arg3.balance, v1);
    }

    public fun set_fee<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = SetFeeInfo{
            balance_id : 0x2::object::id<BalanceManager<T0>>(arg0),
            fee        : arg1,
            sender     : 0x2::tx_context::sender(arg4),
            version    : arg0.version,
        };
        let v1 = 0x2::bcs::to_bytes<SetFeeInfo>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = x"27a4e35bea88ed8517159382f01335e8bc2c29c6aaae2b8f73588849fe30b4f0";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v3, &v2) == true, 1);
        arg0.fee = arg1;
        arg0.version = 0x2::clock::timestamp_ms(arg3);
    }

    public fun withdraw<T0>(arg0: &mut BalanceManager<T0>, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawInfo{
            balance_id : 0x2::object::id<BalanceManager<T0>>(arg0),
            amount     : arg1,
            sender     : 0x2::tx_context::sender(arg4),
            version    : arg0.version,
        };
        let v1 = 0x2::bcs::to_bytes<WithdrawInfo>(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = x"27a4e35bea88ed8517159382f01335e8bc2c29c6aaae2b8f73588849fe30b4f0";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v3, &v2) == true, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg4), 0x2::tx_context::sender(arg4));
        arg0.version = 0x2::clock::timestamp_ms(arg3);
    }

    // decompiled from Move bytecode v6
}

