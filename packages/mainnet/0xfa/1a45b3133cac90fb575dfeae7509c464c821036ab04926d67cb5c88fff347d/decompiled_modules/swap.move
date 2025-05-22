module 0xfa1a45b3133cac90fb575dfeae7509c464c821036ab04926d67cb5c88fff347d::swap {
    struct SWAP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct SwapPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a_balance: 0x2::balance::Balance<T0>,
        coin_b_balance: 0x2::balance::Balance<T1>,
        admin: address,
        swap_fee: u64,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminDepositEvent has copy, drop {
        admin: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        coin_a_amount: u64,
        coin_b_amount: u64,
        fee_paid: u64,
        is_large_swap: bool,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
    }

    struct AdminWithdrawalEvent has copy, drop {
        admin: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun swap<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &mut FeeCollector, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 <= 1000000000000000, 3);
        assert!(v1 > 0, 5);
        let v2 = v1 > 100000000000000;
        let v3 = if (v1 <= 100000000000000) {
            v1
        } else {
            100000000000000
        };
        assert!(0x2::balance::value<T1>(&arg0.coin_b_balance) >= v3, 1);
        let v4 = arg0.swap_fee;
        if (v2) {
            v4 = 10000000000;
            assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= 10000000000, 2);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v4, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v4, arg4)));
        0x2::balance::join<T0>(&mut arg0.coin_a_balance, 0x2::coin::into_balance<T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_balance, v3), arg4), v0);
        let v5 = SwapEvent{
            user          : v0,
            coin_a_amount : v1,
            coin_b_amount : v3,
            fee_paid      : v4,
            is_large_swap : v2,
        };
        0x2::event::emit<SwapEvent>(v5);
    }

    public entry fun admin_deposit_amount_coin_b<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &AdminCap, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.admin, 0);
        assert!(v0 == arg0.admin, 0);
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 1);
        assert!(arg3 > 0, 5);
        0x2::balance::join<T1>(&mut arg0.coin_b_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, arg3, arg4)));
        let v1 = AdminDepositEvent{
            admin     : v0,
            coin_type : 0x1::ascii::string(b"CoinB"),
            amount    : arg3,
        };
        0x2::event::emit<AdminDepositEvent>(v1);
    }

    public entry fun admin_deposit_coin_b<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.admin, 0);
        assert!(v0 == arg0.admin, 0);
        0x2::balance::join<T1>(&mut arg0.coin_b_balance, 0x2::coin::into_balance<T1>(arg2));
        let v1 = AdminDepositEvent{
            admin     : v0,
            coin_type : 0x1::ascii::string(b"CoinB"),
            amount    : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<AdminDepositEvent>(v1);
    }

    public entry fun admin_withdraw_all_fees(arg0: &mut FeeCollector, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin, 0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_fees, v1), arg2), v0);
            let v2 = FeesWithdrawn{
                amount    : v1,
                recipient : v0,
            };
            0x2::event::emit<FeesWithdrawn>(v2);
        };
    }

    public entry fun admin_withdraw_coin_a<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.admin, 0);
        assert!(v0 == arg0.admin, 0);
        assert!(0x2::balance::value<T0>(&arg0.coin_a_balance) >= arg2, 1);
        assert!(arg2 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a_balance, arg2), arg3), v0);
        let v1 = AdminWithdrawalEvent{
            admin     : v0,
            coin_type : 0x1::ascii::string(b"CoinA"),
            amount    : arg2,
        };
        0x2::event::emit<AdminWithdrawalEvent>(v1);
    }

    public entry fun admin_withdraw_coin_b<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.admin, 0);
        assert!(v0 == arg0.admin, 0);
        assert!(0x2::balance::value<T1>(&arg0.coin_b_balance) >= arg2, 1);
        assert!(arg2 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b_balance, arg2), arg3), v0);
        let v1 = AdminWithdrawalEvent{
            admin     : v0,
            coin_type : 0x1::ascii::string(b"CoinB"),
            amount    : arg2,
        };
        0x2::event::emit<AdminWithdrawalEvent>(v1);
    }

    public entry fun admin_withdraw_fees(arg0: &mut FeeCollector, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.admin, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees) >= arg2, 1);
        assert!(arg2 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_fees, arg2), arg3), v0);
        let v1 = FeesWithdrawn{
            amount    : arg2,
            recipient : v0,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    public fun calculate_fee<T0, T1>(arg0: &SwapPool<T0, T1>, arg1: u64) : u64 {
        if (arg1 > 100000000000000) {
            10000000000
        } else {
            arg0.swap_fee
        }
    }

    public fun chain_to_display_amount(arg0: u64) : u64 {
        arg0 / 1000000000
    }

    public entry fun create_pool<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 0);
        let v1 = SwapPool<T0, T1>{
            id             : 0x2::object::new(arg2),
            coin_a_balance : 0x2::balance::zero<T0>(),
            coin_b_balance : 0x2::balance::zero<T1>(),
            admin          : v0,
            swap_fee       : arg1,
        };
        0x2::transfer::share_object<SwapPool<T0, T1>>(v1);
    }

    public fun display_to_chain_amount(arg0: u64) : u64 {
        arg0 * 1000000000
    }

    public fun get_balances<T0, T1>(arg0: &SwapPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_a_balance), 0x2::balance::value<T1>(&arg0.coin_b_balance))
    }

    public fun get_collected_fees(arg0: &FeeCollector) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees)
    }

    public fun get_large_swap_fee() : u64 {
        10000000000
    }

    public fun get_large_swap_threshold() : u64 {
        100000000000000
    }

    public fun get_max_swap_amount() : u64 {
        1000000000000000
    }

    public fun get_swap_fee<T0, T1>(arg0: &SwapPool<T0, T1>) : u64 {
        arg0.swap_fee
    }

    fun init(arg0: SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SWAP>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : v0,
        };
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = FeeCollector{
            id             : 0x2::object::new(arg1),
            collected_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeCollector>(v2);
    }

    public entry fun update_swap_fee<T0, T1>(arg0: &mut SwapPool<T0, T1>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.admin, 0);
        assert!(v0 == arg0.admin, 0);
        assert!(arg2 <= 10000000000, 4);
        arg0.swap_fee = arg2;
        let v1 = FeeUpdated{
            old_fee : arg0.swap_fee,
            new_fee : arg2,
            admin   : v0,
        };
        0x2::event::emit<FeeUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

