module 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::lending {
    struct DepositEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct DepositOnBehalfOfEvent has copy, drop {
        reserve: u8,
        sender: address,
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        reserve: u8,
        sender: address,
        to: address,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct RepayEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct RepayOnBehalfOfEvent has copy, drop {
        reserve: u8,
        sender: address,
        user: address,
        amount: u64,
    }

    struct LiquidationCallEvent has copy, drop {
        reserve: u8,
        sender: address,
        liquidate_user: address,
        liquidate_amount: u64,
    }

    struct LiquidationEvent has copy, drop {
        sender: address,
        user: address,
        collateral_asset: u8,
        collateral_price: u256,
        collateral_amount: u64,
        treasury: u64,
        debt_asset: u8,
        debt_price: u256,
        debt_amount: u64,
    }

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun base_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::when_not_paused(arg2);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::version_verification(arg2);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::logic::execute_borrow<T0>(arg0, arg1, arg2, arg4, arg6, (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::normal_amount<T0>(arg3, arg5) as u256));
        let v0 = BorrowEvent{
            reserve : arg4,
            sender  : arg6,
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v0);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::withdraw_balance<T0>(arg3, arg5, arg6)
    }

    fun base_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: u8, arg4: address, arg5: 0x2::balance::Balance<T0>) {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::when_not_paused(arg1);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::version_verification(arg1);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::deposit_balance<T0>(arg2, arg5, arg4);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::logic::execute_deposit<T0>(arg0, arg1, arg3, arg4, (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::normal_amount<T0>(arg2, v0) as u256));
        let v1 = DepositEvent{
            reserve : arg3,
            sender  : arg4,
            amount  : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun base_flash_loan<T0>(arg0: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Config, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg2: address, arg3: u64) : (0x2::balance::Balance<T0>, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Receipt<T0>) {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::loan<T0>(arg0, arg1, arg2, arg3)
    }

    fun base_flash_repay<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Receipt<T0>, arg4: address, arg5: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::repay<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun base_liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: u8, arg4: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T1>, arg8: address, arg9: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::when_not_paused(arg2);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::version_verification(arg2);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::deposit_balance<T0>(arg4, arg5, arg8);
        let (v1, v2, v3) = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg9, arg6, arg3, (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::normal_amount<T0>(arg4, v0) as u256));
        let v4 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::unnormal_amount<T1>(arg7, (v3 as u64));
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::deposit_treasury<T1>(arg7, v4);
        let v5 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::unnormal_amount<T1>(arg7, (v1 as u64));
        let v6 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::unnormal_amount<T0>(arg4, (v2 as u64));
        let (_, v8, _) = 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::get_token_price(arg0, arg1, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::get_oracle_id(arg2, arg6));
        let (_, v11, _) = 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::get_token_price(arg0, arg1, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::get_oracle_id(arg2, arg3));
        let v13 = LiquidationEvent{
            sender            : arg8,
            user              : arg9,
            collateral_asset  : arg6,
            collateral_price  : v8,
            collateral_amount : v5 + v4,
            treasury          : v4,
            debt_asset        : arg3,
            debt_price        : v11,
            debt_amount       : v0 - v6,
        };
        0x2::event::emit<LiquidationEvent>(v13);
        (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::withdraw_balance<T0>(arg4, v6, arg8), 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::withdraw_balance<T1>(arg7, v5, arg8))
    }

    fun base_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: address) : 0x2::balance::Balance<T0> {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::when_not_paused(arg2);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::version_verification(arg2);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::deposit_balance<T0>(arg3, arg5, arg6);
        let v1 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::unnormal_amount<T0>(arg3, (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::logic::execute_repay<T0>(arg0, arg1, arg2, arg4, arg6, (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::normal_amount<T0>(arg3, v0) as u256)) as u64));
        let v2 = RepayEvent{
            reserve : arg4,
            sender  : arg6,
            amount  : v0 - v1,
        };
        0x2::event::emit<RepayEvent>(v2);
        if (v1 > 0) {
            return 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::withdraw_balance<T0>(arg3, v1, arg6)
        };
        0x2::balance::zero<T0>()
    }

    fun base_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::when_not_paused(arg2);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::version_verification(arg2);
        let v0 = 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::unnormal_amount<T0>(arg3, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::logic::execute_withdraw<T0>(arg0, arg1, arg2, arg4, arg6, (0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::normal_amount<T0>(arg3, arg5) as u256)));
        let v1 = WithdrawEvent{
            reserve : arg4,
            sender  : arg6,
            to      : arg6,
            amount  : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::withdraw_balance<T0>(arg3, v0, arg6)
    }

    public(friend) fun borrow_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public(friend) fun borrow_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: address, arg6: u64) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg5)
    }

    public(friend) fun borrow_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::account_owner(arg6))
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::create_account_cap(arg0)
    }

    public fun delete_account(arg0: 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) {
        abort 0
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::incentive::Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun deposit_coin<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg6), 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::utils::split_coin_to_balance<T0>(arg4, arg5, arg6));
    }

    public(friend) fun deposit_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: u8, arg4: address, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, arg4, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::utils::split_coin_to_balance<T0>(arg5, arg6, arg7));
        let v0 = DepositOnBehalfOfEvent{
            reserve : arg3,
            sender  : 0x2::tx_context::sender(arg7),
            user    : arg4,
            amount  : arg6,
        };
        0x2::event::emit<DepositOnBehalfOfEvent>(v0);
    }

    public(friend) fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::account_owner(arg5), 0x2::coin::into_balance<T0>(arg4));
    }

    public fun flash_loan_with_account_cap<T0>(arg0: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Config, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg2: u64, arg3: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) : (0x2::balance::Balance<T0>, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Receipt<T0>) {
        base_flash_loan<T0>(arg0, arg1, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::account_owner(arg3), arg2)
    }

    public fun flash_loan_with_ctx<T0>(arg0: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Config, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Receipt<T0>) {
        base_flash_loan<T0>(arg0, arg1, 0x2::tx_context::sender(arg3), arg2)
    }

    public fun flash_repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Receipt<T0>, arg4: 0x2::balance::Balance<T0>, arg5: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_flash_repay<T0>(arg0, arg1, arg2, arg3, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::account_owner(arg5), arg4)
    }

    public fun flash_repay_with_ctx<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg3: 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::flash_loan::Receipt<T0>, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_flash_repay<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4)
    }

    public(friend) fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: u8, arg4: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = base_liquidation_call<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::utils::split_coin_to_balance<T0>(arg5, arg9, arg10), arg6, arg7, 0x2::tx_context::sender(arg10), arg8);
        (v1, v0)
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: u8, arg4: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T1>, arg7: 0x2::coin::Coin<T0>, arg8: address, arg9: u64, arg10: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::incentive::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun liquidation_non_entry<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: u8, arg4: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T1>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = base_liquidation_call<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::tx_context::sender(arg9), arg8);
        (v1, v0)
    }

    public(friend) fun repay_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::utils::split_coin_to_balance<T0>(arg5, arg6, arg7), 0x2::tx_context::sender(arg7))
    }

    public(friend) fun repay_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: address, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::utils::split_coin_to_balance<T0>(arg6, arg7, arg8), arg5);
        let v1 = RepayOnBehalfOfEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg8),
            user    : arg5,
            amount  : arg7 - 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<RepayOnBehalfOfEvent>(v1);
        v0
    }

    public(friend) fun repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::account_owner(arg6))
    }

    fun when_not_paused(arg0: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage) {
        assert!(!0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::pause(arg0), 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::error::paused());
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::incentive::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun withdraw_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public(friend) fun withdraw_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: address, arg6: u64) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg5)
    }

    public(friend) fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle::PriceOracle, arg2: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::storage::Storage, arg3: &mut 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::account::account_owner(arg6))
    }

    // decompiled from Move bytecode v6
}

