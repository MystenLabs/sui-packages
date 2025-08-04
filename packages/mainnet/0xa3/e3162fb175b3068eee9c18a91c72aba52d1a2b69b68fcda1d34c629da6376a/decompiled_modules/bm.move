module 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm {
    struct CBM has store, key {
        id: 0x2::object::UID,
        o: address,
        b: 0x2::bag::Bag,
        aw: 0x2::vec_set::VecSet<address>,
        tc: 0x2::table::Table<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
        wc: 0x2::table::Table<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>,
        dc: 0x2::table::Table<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>,
        iv: u64,
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
            wc : 0x2::table::new<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(arg1),
            dc : 0x2::table::new<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(arg1),
            iv : 0,
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

    public fun bdc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc, arg1), 308);
        0x2::table::borrow<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc, arg1)
    }

    public fun btc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1), 304);
        0x2::table::borrow<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1)
    }

    public fun bwc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc, arg1), 306);
        0x2::table::borrow<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc, arg1)
    }

    public fun daw(arg0: &mut CBM, arg1: &AC, arg2: address) {
        van(arg0, arg1);
        0x2::vec_set::remove<address>(&mut arg0.aw, &arg2);
    }

    public fun dbkwo<T0>(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = twc(arg0, v1, arg3);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, &v2, arg2, arg3);
        dwc(arg0, v1, v2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.o);
    }

    public fun ddc(arg0: &mut CBM, arg1: address, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg3: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg3);
        assert!(!0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc, arg1), 309);
        0x2::table::add<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.dc, arg1, arg2);
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
        assert!(!0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1), 305);
        0x2::table::add<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc, arg1, arg2);
    }

    public fun dwc(arg0: &mut CBM, arg1: address, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg3: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg3);
        assert!(!0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc, arg1), 307);
        0x2::table::add<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.wc, arg1, arg2);
    }

    public fun gdtp(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        vaw(arg0, arg2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1);
        let v1 = btc(arg0, 0x2::object::id_to_address(&v0), arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg1, v1, arg2)
    }

    public fun giv(arg0: &CBM) : u64 {
        arg0.iv
    }

    public fun iaw(arg0: &mut CBM, arg1: &AC, arg2: address) {
        van(arg0, arg1);
        0x2::vec_set::insert<address>(&mut arg0.aw, arg2);
    }

    public fun siv(arg0: &mut CBM, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg2);
        arg0.iv = arg1;
    }

    public fun tac(arg0: AC, arg1: address) {
        0x2::transfer::public_transfer<AC>(arg0, arg1);
    }

    public fun tdc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc, arg1), 308);
        0x2::table::remove<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.dc, arg1)
    }

    public fun ttc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc, arg1), 304);
        0x2::table::remove<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc, arg1)
    }

    public fun twc(arg0: &mut CBM, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        vaw(arg0, arg2);
        assert!(0x2::table::contains<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc, arg1), 306);
        0x2::table::remove<address, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.wc, arg1)
    }

    fun van(arg0: &CBM, arg1: &AC) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.bma, 301);
    }

    fun vaw(arg0: &CBM, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.aw, &v0), 301);
    }

    public fun wd<T0>(arg0: &mut CBM, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        vaw(arg0, arg2);
        let v0 = BK<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BK<T0>>(&arg0.b, v0), 303);
        let v1 = 0x2::bag::borrow_mut<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 >= arg1, 302);
        if (arg1 == v2) {
            0x2::coin::from_balance<T0>(0x2::bag::remove<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
        }
    }

    public fun wda<T0>(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        vaw(arg0, arg1);
        let v0 = BK<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BK<T0>>(&arg0.b, v0), 303);
        0x2::coin::from_balance<T0>(0x2::bag::remove<BK<T0>, 0x2::balance::Balance<T0>>(&mut arg0.b, v0), arg1)
    }

    // decompiled from Move bytecode v6
}

