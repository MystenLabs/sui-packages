module 0xc888ffe2045f74b787520a8379ab610d7f65f6c2e7d4d8e13d084e8e15561252::adaptor {
    struct CurrentLendingAdaptor has drop {
        dummy_field: bool,
    }

    struct CurrentObligation<phantom T0> has key {
        id: 0x2::object::UID,
        parent_wallet_identity: address,
        obligation_cap: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap,
        delegates: 0x2::vec_map::VecMap<address, u32>,
    }

    public fun adopt<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::tx_context::sender(arg3) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        let v0 = CurrentObligation<T0>{
            id                     : 0x2::object::new(arg3),
            parent_wallet_identity : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0),
            obligation_cap         : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::enter_market::enter_market_return<T0>(arg1, arg2, arg3),
            delegates              : 0x2::vec_map::empty<address, u32>(),
        };
        0x2::transfer::share_object<CurrentObligation<T0>>(v0);
        0x2::object::id<CurrentObligation<T0>>(&v0)
    }

    public fun assert_parent<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>) {
        assert!(arg1.parent_wallet_identity == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0), 1);
    }

    fun assert_perm<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0)) {
            return
        };
        assert!(has_permission<T0>(arg1, v0, arg2), 2);
    }

    public fun borrow_coin<T0, T1>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg5 > 0, 3);
        assert_parent<T0>(arg0, arg1);
        assert_perm<T0>(arg0, arg1, 4, arg8);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::borrow::borrow<T0, T1>(arg2, &arg1.obligation_cap, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun borrow_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 3);
        assert_parent<T0>(arg0, arg1);
        assert_perm<T0>(arg0, arg1, 4, arg8);
        let v0 = CurrentLendingAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<CurrentLendingAdaptor, T1>(arg0, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::borrow::borrow<T0, T1>(arg2, &arg1.obligation_cap, arg3, arg4, arg5, arg6, arg7, arg8), v0);
    }

    public fun flash_borrow<T0, T1>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::PackageCallerCap, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>) {
        assert!(arg6 > 0, 3);
        assert_parent<T0>(arg0, arg1);
        assert_perm<T0>(arg0, arg1, 4, arg7);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::flash_loan::borrow_flash_loan<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun flash_repay<T0, T1>(arg0: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::flash_loan::repay_flash_loan<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun grant_delegate<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut CurrentObligation<T0>, arg2: address, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent<T0>(arg0, arg1);
        if (0x2::vec_map::contains<address, u32>(&arg1.delegates, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, u32>(&mut arg1.delegates, &arg2);
        };
        0x2::vec_map::insert<address, u32>(&mut arg1.delegates, arg2, arg3);
    }

    public fun has_permission<T0>(arg0: &CurrentObligation<T0>, arg1: address, arg2: u32) : bool {
        if (!0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1)) {
            return false
        };
        *0x2::vec_map::get<address, u32>(&arg0.delegates, &arg1) & arg2 == arg2
    }

    public fun parent_identity<T0>(arg0: &CurrentObligation<T0>) : address {
        arg0.parent_wallet_identity
    }

    public fun perm_all() : u32 {
        1 | 2 | 4 | 8
    }

    public fun perm_borrow() : u32 {
        4
    }

    public fun perm_repay() : u32 {
        8
    }

    public fun perm_supply() : u32 {
        1
    }

    public fun perm_withdraw() : u32 {
        2
    }

    public fun reclaim<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: CurrentObligation<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent<T0>(arg0, &arg1);
        let CurrentObligation {
            id                     : v0,
            parent_wallet_identity : _,
            obligation_cap         : v2,
            delegates              : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun repay_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 3);
        assert_parent<T0>(arg0, arg1);
        let v0 = arg1.parent_wallet_identity;
        let v1 = CurrentLendingAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<CurrentLendingAdaptor, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<CurrentLendingAdaptor, T1>(v1, arg4, v0), arg6);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::repay::repay<T0, T1>(arg2, &arg1.obligation_cap, arg3, v2, arg5, arg6);
        let v4 = CurrentLendingAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<CurrentLendingAdaptor, T1>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<CurrentLendingAdaptor, T1>(v4, arg4, v0));
    }

    public fun revoke_delegate<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut CurrentObligation<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        if (0x2::vec_map::contains<address, u32>(&arg1.delegates, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, u32>(&mut arg1.delegates, &arg2);
        };
    }

    public fun supply_coin<T0, T1>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_parent<T0>(arg0, arg1);
        assert_perm<T0>(arg0, arg1, 1, arg6);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::deposit::deposit<T0, T1>(arg2, arg3, &arg1.obligation_cap, arg4, arg5, arg6);
    }

    public fun supply_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 3);
        assert_parent<T0>(arg0, arg1);
        let v0 = arg1.parent_wallet_identity;
        let v1 = CurrentLendingAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<CurrentLendingAdaptor, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<CurrentLendingAdaptor, T1>(v1, arg4, v0), arg6);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::deposit::deposit<T0, T1>(arg2, arg3, &arg1.obligation_cap, v2, arg5, arg6);
        let v4 = CurrentLendingAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<CurrentLendingAdaptor, T1>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<CurrentLendingAdaptor, T1>(v4, arg4, v0));
    }

    public fun withdraw_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &CurrentObligation<T0>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 3);
        assert_parent<T0>(arg0, arg1);
        assert_perm<T0>(arg0, arg1, 2, arg8);
        let v0 = CurrentLendingAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<CurrentLendingAdaptor, T1>(arg0, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<T0, T1>(arg2, arg3, &arg1.obligation_cap, arg4, arg5, arg6, arg7, arg8), v0);
    }

    // decompiled from Move bytecode v7
}

