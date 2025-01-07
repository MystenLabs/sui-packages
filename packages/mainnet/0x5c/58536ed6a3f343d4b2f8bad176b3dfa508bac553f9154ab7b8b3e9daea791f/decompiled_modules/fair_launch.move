module 0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::fair_launch {
    struct TokenPurchased has copy, drop {
        buyer: address,
        amount: u64,
    }

    struct FairLaunch has store, key {
        id: 0x2::object::UID,
        start_timestamp_ms: u64,
        tokens: 0x2::balance::Balance<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>,
        amount: u64,
        max_tokens: u64,
        token_price: u64,
        purchased_amounts: 0x2::table::Table<address, u64>,
    }

    public entry fun new(arg0: &0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::TreasuryAdminCap, arg1: &mut 0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::Treasury, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = FairLaunch{
            id                 : 0x2::object::new(arg6),
            start_timestamp_ms : arg3,
            tokens             : 0x2::coin::into_balance<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>(0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::take_from_sales_reserve(arg0, arg1, arg2, arg6)),
            amount             : arg2,
            max_tokens         : arg4,
            token_price        : arg5,
            purchased_amounts  : 0x2::table::new<address, u64>(arg6),
        };
        0x2::transfer::share_object<FairLaunch>(v0);
    }

    fun get_purchase_limit(arg0: &FairLaunch, arg1: address, arg2: u64) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.purchased_amounts, arg1)) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.purchased_amounts, arg1);
            assert!(v1 < arg0.max_tokens, 2);
            0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::math64::min(v1, arg2)
        } else {
            assert!(arg2 > 0, 1);
            0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::math64::min(arg0.max_tokens, arg2)
        }
    }

    public entry fun make_purchase(arg0: &mut FairLaunch, arg1: &mut 0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg0.start_timestamp_ms, 3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2) * 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::math64::pow(10, 5) / arg0.token_price;
        let v2 = 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::math64::min(v1, get_purchase_limit(arg0, v0, 0x2::balance::value<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>(&arg0.tokens)));
        if (v2 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, (v1 - v2) * arg0.token_price, arg6), arg4);
        };
        update_purchased_amounts(arg0, v0, v2);
        0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::receive_sui_balance(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>>(0x2::coin::take<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>(&mut arg0.tokens, v2, arg6), arg3);
        let v3 = TokenPurchased{
            buyer  : v0,
            amount : v2,
        };
        0x2::event::emit<TokenPurchased>(v3);
    }

    public entry fun purchase(arg0: &mut FairLaunch, arg1: &mut 0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) >= arg0.start_timestamp_ms, 3);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2) / arg0.token_price;
        let v2 = 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::math64::min(v1, get_purchase_limit(arg0, v0, 0x2::balance::value<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>(&arg0.tokens)));
        if (v2 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, (v1 - v2) * arg0.token_price, arg6), arg4);
        };
        update_purchased_amounts(arg0, v0, v2);
        0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::treasury::receive_sui_balance(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>>(0x2::coin::take<0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy::CANDY>(&mut arg0.tokens, v2, arg6), arg3);
        let v3 = TokenPurchased{
            buyer  : v0,
            amount : v2,
        };
        0x2::event::emit<TokenPurchased>(v3);
    }

    fun update_purchased_amounts(arg0: &mut FairLaunch, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.purchased_amounts, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.purchased_amounts, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.purchased_amounts, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

