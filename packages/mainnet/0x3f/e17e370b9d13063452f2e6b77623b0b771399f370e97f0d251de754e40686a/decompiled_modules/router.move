module 0x3fe17e370b9d13063452f2e6b77623b0b771399f370e97f0d251de754e40686a::router {
    struct SwapPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        partners: vector<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SwapEvent has copy, drop {
        value: u64,
    }

    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg4) {
            4295048018
        } else {
            79226673515401279992447579054
        };
        let v1 = if (arg4) {
            0x2::coin::value<T0>(&arg2)
        } else {
            0x2::coin::value<T1>(&arg3)
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, v1, v0, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg4) {
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5), arg7)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v6, arg7));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v7, arg7));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v5);
        (arg2, arg3)
    }

    public fun flash_swap(arg0: &SwapPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun add_treasury(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun check_min_amount_out(arg0: &SwapPool, arg1: u64) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > arg1, 2);
        let v0 = SwapEvent{value: 0x2::balance::value<0x2::sui::SUI>(&arg0.balance) - arg1};
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun get_treasury(arg0: &mut SwapPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapPool{
            id       : 0x2::object::new(arg0),
            balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            partners : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<SwapPool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted(arg0: &SwapPool, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.partners, &arg1)
    }

    public entry fun remove_pool(arg0: &AdminCap, arg1: &mut SwapPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun update_partner(arg0: &AdminCap, arg1: &mut SwapPool, arg2: vector<address>) {
        0x1::vector::append<address>(&mut arg1.partners, arg2);
    }

    // decompiled from Move bytecode v6
}

