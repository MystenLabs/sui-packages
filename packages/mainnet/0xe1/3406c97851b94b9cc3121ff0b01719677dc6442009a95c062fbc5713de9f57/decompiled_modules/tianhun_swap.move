module 0xe13406c97851b94b9cc3121ff0b01719677dc6442009a95c062fbc5713de9f57::tianhun_swap {
    struct LP has drop {
        dummy_field: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        coin_tianhun: 0x2::balance::Balance<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>,
        cion_faucet: 0x2::balance::Balance<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>,
        lp_supply: 0x2::balance::Supply<LP>,
    }

    struct Pocket has store, key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<0x2::object::ID, vector<u64>>,
    }

    public fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>, arg2: 0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP>, vector<u64>) {
        let v0 = 0x2::coin::value<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&arg1);
        let v1 = 0x2::coin::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        0x2::coin::put<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut arg0.coin_tianhun, arg1);
        0x2::coin::put<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.cion_faucet, arg2);
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, v0);
        0x1::vector::push_back<u64>(&mut v2, v1);
        (0x2::coin::from_balance<LP>(0x2::balance::increase_supply<LP>(&mut arg0.lp_supply, v0 + v1), arg3), v2)
    }

    public entry fun create_pocket(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pocket{
            id     : 0x2::object::new(arg0),
            record : 0x2::table::new<0x2::object::ID, vector<u64>>(arg0),
        };
        0x2::transfer::public_transfer<Pocket>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit_partially(arg0: &mut Pool, arg1: vector<0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>>, arg2: vector<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>, arg3: u64, arg4: u64, arg5: &mut Pocket, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(arg6);
        let v1 = 0x2::coin::zero<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(arg6);
        0x2::pay::join_vec<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut v0, arg1);
        0x2::pay::join_vec<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut v1, arg2);
        let v2 = 0x2::coin::split<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut v0, arg3, arg6);
        let v3 = 0x2::coin::split<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut v1, arg4, arg6);
        let (v4, v5) = add_liquidity(arg0, v2, v3, arg6);
        let v6 = v4;
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg5.record, 0x2::object::id<0x2::coin::Coin<LP>>(&v6), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP>>(v6, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(v1, 0x2::tx_context::sender(arg6));
    }

    public entry fun deposit_totally(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>, arg2: 0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>, arg3: &mut Pocket, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = add_liquidity(arg0, arg1, arg2, arg4);
        let v2 = v0;
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg3.record, 0x2::object::id<0x2::coin::Coin<LP>>(&v2), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP>>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun generate_pool(arg0: &mut 0x2::tx_context::TxContext) {
        new_pool(arg0);
    }

    public fun new_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LP{dummy_field: false};
        let v1 = Pool{
            id           : 0x2::object::new(arg0),
            coin_tianhun : 0x2::balance::zero<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(),
            cion_faucet  : 0x2::balance::zero<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(),
            lp_supply    : 0x2::balance::create_supply<LP>(v0),
        };
        0x2::transfer::share_object<Pool>(v1);
    }

    public fun remove_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<LP>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>, 0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>) {
        assert!(0x1::vector::length<u64>(&arg2) == 2, 1);
        let v0 = *0x1::vector::borrow<u64>(&arg2, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg2, 1);
        assert!(0x2::coin::value<LP>(&arg1) == v0 + v1, 2);
        assert!(0x2::balance::value<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&arg0.coin_tianhun) >= v0, 3);
        assert!(0x2::balance::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg0.cion_faucet) >= v1, 3);
        0x2::balance::decrease_supply<LP>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP>(arg1));
        (0x2::coin::take<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut arg0.coin_tianhun, v0, arg3), 0x2::coin::take<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.cion_faucet, v1, arg3))
    }

    public entry fun remove_liquidity_totally(arg0: &mut Pool, arg1: 0x2::coin::Coin<LP>, arg2: &mut Pocket, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::Coin<LP>>(&arg1);
        let (v1, v2) = remove_liquidity(arg0, arg1, *0x2::table::borrow<0x2::object::ID, vector<u64>>(&arg2.record, v0), arg3);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::coin::value<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&v4) > 0 && 0x2::coin::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&v3) > 0, 4);
        0x1::vector::destroy_empty<u64>(0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg2.record, v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(v3, 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_out(arg0: &mut Pool, arg1: vector<0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(arg3);
        0x2::pay::join_vec<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut v0, arg1);
        let v1 = 0x2::coin::split<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut v0, arg2, arg3);
        let v2 = swap_faucet_outto(arg0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun swap_faucet_outto(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN> {
        let v0 = 0x2::coin::value<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::put<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut arg0.coin_tianhun, arg1);
        assert!(v0 < 0x2::balance::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg0.cion_faucet), 3);
        0x2::coin::take<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.cion_faucet, v0, arg2)
    }

    public entry fun swap_tianhun_out(arg0: &mut Pool, arg1: vector<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(arg3);
        0x2::pay::join_vec<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut v0, arg1);
        let v1 = 0x2::coin::split<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut v0, arg2, arg3);
        let v2 = swap_tianhun_outto(arg0, v1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun swap_tianhun_outto(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN> {
        let v0 = 0x2::coin::value<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::put<0xccb69f4b847c308b24ae2bae1dac2454822a091bccb87fbf1f7e910cdde9405e::tianhun_faucet_coin::TIANHUN_FAUCET_COIN>(&mut arg0.cion_faucet, arg1);
        assert!(v0 < 0x2::balance::value<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&arg0.coin_tianhun), 3);
        0x2::coin::take<0xfde7a34dc93f1401d93868361258a4b00ccf8aa0b58393eabeb5efb41ccfe66::tianhun_coin::TIANHUN_COIN>(&mut arg0.coin_tianhun, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

