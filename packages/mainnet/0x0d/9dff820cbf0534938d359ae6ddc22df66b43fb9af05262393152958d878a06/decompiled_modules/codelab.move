module 0xd9dff820cbf0534938d359ae6ddc22df66b43fb9af05262393152958d878a06::codelab {
    struct Global {
        id: 0x2::object::UID,
        vault_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        vault_bag: 0x2::bag::Bag,
    }

    struct Swaping {
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        from_coin: 0x1::type_name::TypeName,
        from_amount: u64,
        middle_coin: 0x1::type_name::TypeName,
        middle_amount: u64,
        min_profit: u64,
        profit: u64,
    }

    struct Debug has copy, drop {
        pay_sui_amount: u64,
        got_sui_amount: u64,
    }

    public fun test_flash_swap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, arg2, false, false, arg4, 79226673515401279992447579055);
        let v3 = v2;
        let v4 = v0;
        let v5 = Debug{
            pay_sui_amount : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3),
            got_sui_amount : 0x2::balance::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<Debug>(v5);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg2, v4, v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

