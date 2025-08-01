module 0xde3ecd6c09115d84fff52b6c3b2d92f4ea6feb2724a9c266a8be7fbdba2cdc49::fake_liquidity {
    struct SpecialObject has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        blackz_balance: 0x2::balance::Balance<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>,
    }

    public entry fun close_position(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2);
        if (v0 > 0) {
            let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>(arg0, arg1, &mut arg2, v0, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>>(0x2::coin::from_balance<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>(v1, arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4), 0x2::tx_context::sender(arg4));
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>(arg0, arg1, arg2);
    }

    public entry fun add_balance_to_special_object(arg0: &mut SpecialObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
        0x2::coin::put<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>(&mut arg0.blackz_balance, arg2);
    }

    public entry fun add_liquidity_from_special_object(arg0: &mut SpecialObject, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u128, arg5: &0x2::clock::Clock) {
        add_liquidity_with_all(arg1, arg2, arg3, 0x2::balance::split<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>(&mut arg0.blackz_balance, 0x2::balance::value<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>(&arg0.blackz_balance) / 2), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) / 2), arg4, arg5);
    }

    public fun add_liquidity_with_all(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: u128, arg6: &0x2::clock::Clock) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>(arg0, arg1, arg3, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ, 0x2::sui::SUI>(arg0, arg1, arg2, arg5, arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpecialObject{
            id             : 0x2::object::new(arg0),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            blackz_balance : 0x2::balance::zero<0x25d8190a8f4c4677a7ecf395e27d6d8fa77ff37775aac7b550759acc8434c2b2::blackz::BLACKZ>(),
        };
        0x2::transfer::share_object<SpecialObject>(v0);
    }

    public entry fun retrieve_sui_from_special_object(arg0: &mut SpecialObject, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), arg1), @0xe86e9c41dca2f50ace7e646856ef3ee02f7c5754d74da95fe64a522dfc72f2a1);
    }

    // decompiled from Move bytecode v6
}

