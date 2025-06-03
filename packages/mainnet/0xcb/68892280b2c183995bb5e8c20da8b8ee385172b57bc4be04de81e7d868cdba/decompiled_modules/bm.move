module 0xcb68892280b2c183995bb5e8c20da8b8ee385172b57bc4be04de81e7d868cdba::bm {
    struct CBM has store, key {
        id: 0x2::object::UID,
        o: address,
        b: 0x2::bag::Bag,
        aw: 0x2::vec_set::VecSet<address>,
        tc: 0x2::table::Table<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
    }

    struct BK<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AC has store, key {
        id: 0x2::object::UID,
        bma: address,
    }

    public fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = CBM{
            id : 0x2::object::new(arg1),
            o  : arg0,
            b  : 0x2::bag::new(arg1),
            aw : 0x2::vec_set::empty<address>(),
            tc : 0x2::table::new<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(arg1),
        };
        let v1 = 0x2::object::uid_to_address(&v0.id);
        0x2::transfer::share_object<CBM>(v0);
        let v2 = AC{
            id  : 0x2::object::new(arg1),
            bma : v1,
        };
        0x2::transfer::public_transfer<AC>(v2, arg0);
        v1
    }

    public fun balance<T0>(arg0: &CBM) : u64 {
        let v0 = BK<T0>{dummy_field: false};
        if (!0x2::bag::contains<BK<T0>>(&arg0.b, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<BK<T0>, 0x2::balance::Balance<T0>>(&arg0.b, v0))
        }
    }

    public fun btc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1), 4);
        0x2::table::borrow<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1)
    }

    public fun daw(arg0: &mut CBM, arg1: &AC, arg2: address) {
        van(arg0, arg1);
        0x2::vec_set::remove<address>(&mut arg0.aw, &arg2);
    }

    public fun dp<T0>(arg0: &mut CBM, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg2);
        let v0 = BK<T0>{dummy_field: false};
        if (0x2::bag::contains<BK<T0>>(&arg0.b, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun dtc(arg0: &mut CBM, arg1: address, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg3: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg3);
        assert!(!0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1), 5);
        0x2::table::add<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc, arg1, arg2);
    }

    public fun gdtp(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        vaw(arg0, arg2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1);
        let v1 = btc(arg0, 0x2::object::id_to_address(&v0), arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg1, v1, arg2)
    }

    public fun iaw(arg0: &mut CBM, arg1: &AC, arg2: address) {
        van(arg0, arg1);
        0x2::vec_set::insert<address>(&mut arg0.aw, arg2);
    }

    public fun tac(arg0: AC, arg1: address) {
        0x2::transfer::public_transfer<AC>(arg0, arg1);
    }

    public fun ttc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1), 4);
        0x2::table::remove<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc, arg1)
    }

    fun van(arg0: &CBM, arg1: &AC) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.bma, 1);
    }

    fun vaw(arg0: &CBM, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.aw, &v0), 1);
    }

    public fun wd<T0>(arg0: &mut CBM, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        vaw(arg0, arg2);
        let v0 = BK<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BK<T0>>(&arg0.b, v0), 3);
        let v1 = 0x2::bag::borrow_mut<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 >= arg1, 2);
        if (arg1 == v2) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
        }
    }

    public fun wda<T0>(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        vaw(arg0, arg1);
        let v0 = BK<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BK<T0>>(&arg0.b, v0), 3);
        0x2::coin::from_balance<T0>(0x2::bag::remove<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), arg1)
    }

    // decompiled from Move bytecode v6
}

