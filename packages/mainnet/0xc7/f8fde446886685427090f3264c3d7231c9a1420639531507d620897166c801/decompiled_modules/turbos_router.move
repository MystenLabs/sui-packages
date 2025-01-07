module 0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::turbos_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public entry fun buy_exact_in<T0, T1>(arg0: &FeeObject, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u128, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * arg0.buy_fee / 10000;
        let v1 = arg3 - v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 3);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>();
        0x1::vector::insert<0x2::coin::Coin<0x2::sui::SUI>>(&mut v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg10), 0);
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, 0x2::sui::SUI, T1>(arg1, v2, v1, arg4, arg5, true, arg6, arg7, arg8, arg9, arg10);
        let v5 = v3;
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= arg3, 4);
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<T0>(v5, 0x2::tx_context::sender(arg10));
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg10));
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<0x2::sui::SUI>(v4, 0x2::tx_context::sender(arg10));
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg10), arg0.admin);
        let v7 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : v1,
            amount_out : v6,
        };
        0x2::event::emit<BuyEvent<T0>>(v7);
        let v8 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v8);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 90,
            sell_fee : 90,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0, T1>(arg0: &FeeObject, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 3);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::insert<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::split<T0>(&mut arg2, arg3, arg10), 0);
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, 0x2::sui::SUI, T1>(arg1, v0, arg3, arg4, arg5, true, arg6, arg7, arg8, arg9, arg10);
        let v3 = v1;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg4, 4);
        let v5 = v4 * arg0.sell_fee / 10000;
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg10));
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<T0>(v2, 0x2::tx_context::sender(arg10));
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg10));
        0xc7f8fde446886685427090f3264c3d7231c9a1420639531507d620897166c801::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v5, arg10), arg0.admin);
        let v6 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : arg3,
            amount_out : v4 - v5,
        };
        0x2::event::emit<SellEvent<T0>>(v6);
        let v7 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v5,
        };
        0x2::event::emit<FeeCollectedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

