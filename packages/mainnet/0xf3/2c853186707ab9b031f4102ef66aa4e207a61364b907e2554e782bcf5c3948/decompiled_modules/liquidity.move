module 0xf32c853186707ab9b031f4102ef66aa4e207a61364b907e2554e782bcf5c3948::liquidity {
    struct BluefinSpotAdaptor has drop {
        dummy_field: bool,
    }

    struct BluefinSpotPosition has key {
        id: 0x2::object::UID,
        parent_wallet_identity: address,
        position: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position,
        delegates: 0x2::vec_map::VecMap<address, u32>,
    }

    public fun add_from_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut BluefinSpotPosition, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0 && arg5 > 0, 3);
        assert_parent(arg0, arg1);
        assert_perm(arg0, arg1, 1, arg9);
        let v0 = arg1.parent_wallet_identity;
        let v1 = pull_from_vault<T0>(arg0, arg4, v0, arg9);
        let v2 = pull_from_vault<T1>(arg0, arg5, v0, arg9);
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg8, arg2, arg3, &mut arg1.position, v1, v2, arg6, arg7);
        credit_or_destroy<T0>(arg0, v5, arg9);
        credit_or_destroy<T1>(arg0, v6, arg9);
    }

    public fun adopt<T0, T1>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::tx_context::sender(arg5) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        let v0 = BluefinSpotPosition{
            id                     : 0x2::object::new(arg5),
            parent_wallet_identity : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0),
            position               : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg5),
            delegates              : 0x2::vec_map::empty<address, u32>(),
        };
        0x2::transfer::share_object<BluefinSpotPosition>(v0);
        0x2::object::id<BluefinSpotPosition>(&v0)
    }

    public fun assert_parent(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &BluefinSpotPosition) {
        assert!(arg1.parent_wallet_identity == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0), 1);
    }

    fun assert_perm(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &BluefinSpotPosition, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (v0 == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0)) {
            return
        };
        assert!(has_permission(arg1, v0, arg2), 2);
    }

    public fun collect_fees_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut BluefinSpotPosition, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_parent(arg0, arg1);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg2, arg3, &mut arg1.position);
        credit_or_destroy<T0>(arg0, v2, arg5);
        credit_or_destroy<T1>(arg0, v3, arg5);
    }

    fun credit_or_destroy<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            let v0 = BluefinSpotAdaptor{dummy_field: false};
            0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<BluefinSpotAdaptor, T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), v0);
        };
    }

    public fun grant_delegate(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut BluefinSpotPosition, arg2: address, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent(arg0, arg1);
        if (0x2::vec_map::contains<address, u32>(&arg1.delegates, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, u32>(&mut arg1.delegates, &arg2);
        };
        0x2::vec_map::insert<address, u32>(&mut arg1.delegates, arg2, arg3);
    }

    public fun has_permission(arg0: &BluefinSpotPosition, arg1: address, arg2: u32) : bool {
        if (!0x2::vec_map::contains<address, u32>(&arg0.delegates, &arg1)) {
            return false
        };
        *0x2::vec_map::get<address, u32>(&arg0.delegates, &arg1) & arg2 == arg2
    }

    public fun parent_identity(arg0: &BluefinSpotPosition) : address {
        arg0.parent_wallet_identity
    }

    public fun perm_add() : u32 {
        1
    }

    public fun perm_add_and_remove() : u32 {
        1 | 2
    }

    public fun perm_remove() : u32 {
        2
    }

    fun pull_from_vault<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = BluefinSpotAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BluefinSpotAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BluefinSpotAdaptor, T0>(v0, arg1, arg2), arg3);
        let v3 = BluefinSpotAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BluefinSpotAdaptor, T0>(v2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BluefinSpotAdaptor, T0>(v3, arg1, arg2));
        0x2::coin::into_balance<T0>(v1)
    }

    public fun reclaim(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: BluefinSpotPosition, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent(arg0, &arg1);
        let BluefinSpotPosition {
            id                     : v0,
            parent_wallet_identity : _,
            position               : v2,
            delegates              : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun remove_to_vault<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut BluefinSpotPosition, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 3);
        assert_parent(arg0, arg1);
        assert_perm(arg0, arg1, 2, arg6);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut arg1.position, arg4, arg5);
        credit_or_destroy<T0>(arg0, v2, arg6);
        credit_or_destroy<T1>(arg0, v3, arg6);
    }

    public fun revoke_delegate(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut BluefinSpotPosition, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        if (0x2::vec_map::contains<address, u32>(&arg1.delegates, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<address, u32>(&mut arg1.delegates, &arg2);
        };
    }

    // decompiled from Move bytecode v7
}

