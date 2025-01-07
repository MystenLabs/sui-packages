module 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    struct Data<phantom T0> has store {
        cap: 0x2::coin::TreasuryCap<T0>,
        faucet_lock: 0x2::table::Table<address, u64>,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        dex_supply: 0x2::balance::Supply<DEX>,
        swaps: 0x2::table::Table<address, u64>,
        account_cap: 0xdee9::custodian_v2::AccountCap,
        client_id: u64,
    }

    public fun create_pool(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0xdee9::clob_v2::create_pool<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(1 * 1000000000, 1, arg0, arg1);
    }

    public fun place_market_order(arg0: &mut Storage, arg1: &mut 0xdee9::clob_v2::Pool<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>, arg6: 0x2::coin::Coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>, 0x2::coin::Coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, 0x2::coin::Coin<DEX>) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0;
        let v2 = 0x2::coin::zero<DEX>(arg8);
        if (0x2::table::contains<address, u64>(&arg0.swaps, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.swaps, v0);
            let v4 = *v3 + 1;
            *v3 = v4;
            v1 = v4;
            if (v4 % 2 == 0) {
                0x2::coin::join<DEX>(&mut v2, 0x2::coin::from_balance<DEX>(0x2::balance::increase_supply<DEX>(&mut arg0.dex_supply, 1000000000), arg8));
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.swaps, v0, 1);
        };
        let (v5, v6) = 0xdee9::clob_v2::place_market_order<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8);
        (v5, v6, v2)
    }

    fun create_ask_orders(arg0: &mut Storage, arg1: &mut 0xdee9::clob_v2::Pool<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdee9::clob_v2::deposit_base<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(arg1, 0x2::coin::mint<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>(&mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Data<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>>(&mut arg0.id, 0x1::type_name::get<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>()).cap, 60000000000000, arg3), &arg0.account_cap);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(arg1, arg0.client_id, 120 * 1000000000, 60000000000000, 0, false, 18446744073709551615, 0, arg2, &arg0.account_cap, arg3);
        arg0.client_id = arg0.client_id + 1;
    }

    fun create_bid_orders(arg0: &mut Storage, arg1: &mut 0xdee9::clob_v2::Pool<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xdee9::clob_v2::deposit_quote<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(arg1, 0x2::coin::mint<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(&mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Data<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>>(&mut arg0.id, 0x1::type_name::get<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>()).cap, 6000000000000000, arg3), &arg0.account_cap);
        let (_, _, _, _) = 0xdee9::clob_v2::place_limit_order<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(arg1, arg0.client_id, 100 * 1000000000, 60000000000000, 0, true, 18446744073709551615, 0, arg2, &arg0.account_cap, arg3);
        arg0.client_id = arg0.client_id + 1;
    }

    public fun create_state(arg0: &mut Storage, arg1: 0x2::coin::TreasuryCap<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>, arg2: 0x2::coin::TreasuryCap<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Data<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>{
            cap         : arg1,
            faucet_lock : 0x2::table::new<address, u64>(arg3),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Data<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>>(&mut arg0.id, 0x1::type_name::get<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>(), v0);
        let v1 = Data<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>{
            cap         : arg2,
            faucet_lock : 0x2::table::new<address, u64>(arg3),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Data<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>>(&mut arg0.id, 0x1::type_name::get<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(), v1);
    }

    public fun entry_place_market_order(arg0: &mut Storage, arg1: &mut 0xdee9::clob_v2::Pool<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: u64, arg4: bool, arg5: 0x2::coin::Coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>, arg6: 0x2::coin::Coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = place_market_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v3 = 0x2::tx_context::sender(arg8);
        transfer_coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH>(v0, v3);
        transfer_coin<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>(v1, v3);
        transfer_coin<DEX>(v2, v3);
    }

    public fun fill_pool(arg0: &mut Storage, arg1: &mut 0xdee9::clob_v2::Pool<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::eth::ETH, 0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        create_ask_orders(arg0, arg1, arg2, arg3);
        create_bid_orders(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 9, b"DEX", b"DEX Coin", b"Coin of SUI DEX", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEX>>(v1);
        let v2 = Storage{
            id          : 0x2::object::new(arg1),
            dex_supply  : 0x2::coin::treasury_into_supply<DEX>(v0),
            swaps       : 0x2::table::new<address, u64>(arg1),
            account_cap : 0xdee9::clob_v2::create_account(arg1),
            client_id   : 122227,
        };
        0x2::transfer::share_object<Storage>(v2);
    }

    public fun mint_coin<T0>(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Data<T0>>(&mut arg0.id, v1);
        if (0x2::table::contains<address, u64>(&v2.faucet_lock, v0)) {
            assert!(0x2::tx_context::epoch(arg1) > *0x2::table::borrow<address, u64>(&v2.faucet_lock, 0x2::tx_context::sender(arg1)), 0);
        } else {
            0x2::table::add<address, u64>(&mut v2.faucet_lock, v0, 0);
        };
        *0x2::table::borrow_mut<address, u64>(&mut v2.faucet_lock, v0) = 0x2::tx_context::epoch(arg1);
        let v3 = if (v1 == 0x1::type_name::get<0xb1a65917c77f8eb9b21107068778e7116d00b9dd935c6be277bf82050f944b2b::usdc::USDC>()) {
            100 * 1000000000
        } else {
            1 * 1000000000
        };
        0x2::coin::mint<T0>(&mut v2.cap, v3, arg1)
    }

    fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun user_last_mint_epoch<T0>(arg0: &Storage, arg1: address) : u64 {
        let v0 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, Data<T0>>(&arg0.id, 0x1::type_name::get<T0>());
        if (0x2::table::contains<address, u64>(&v0.faucet_lock, arg1)) {
            return *0x2::table::borrow<address, u64>(&v0.faucet_lock, arg1)
        };
        0
    }

    public fun user_swap_count(arg0: &Storage, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.swaps, arg1)) {
            return *0x2::table::borrow<address, u64>(&arg0.swaps, arg1)
        };
        0
    }

    // decompiled from Move bytecode v6
}

