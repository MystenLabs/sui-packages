module 0xeaf81a9984bb59db32beb3f15d19880c580eefa6ab9bc5688006acbe7f692591::bm {
    struct CBM has store, key {
        id: 0x2::object::UID,
        o: address,
        aw: 0x2::vec_set::VecSet<address>,
        tc: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>,
        wc: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>,
        dc: 0x1::option::Option<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>,
        iv: u64,
    }

    struct AC has store, key {
        id: 0x2::object::UID,
        bma: address,
    }

    public fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = CBM{
            id : 0x2::object::new(arg1),
            o  : arg0,
            aw : 0x2::vec_set::empty<address>(),
            tc : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(),
            wc : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(),
            dc : 0x1::option::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(),
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

    public fun bal<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun bdc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        vaw(arg0, arg1);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), 308);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc)
    }

    public fun btc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        vaw(arg0, arg1);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), 304);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc)
    }

    public fun bwc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        vaw(arg0, arg1);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), 306);
        0x1::option::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc)
    }

    public fun daw(arg0: &mut CBM, arg1: &AC, arg2: address) {
        van(arg0, arg1);
        0x2::vec_set::remove<address>(&mut arg0.aw, &arg2);
    }

    public fun ddc(arg0: &mut CBM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg2: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg2);
        assert!(!0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), 309);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.dc, arg1);
    }

    public fun dp<T0>(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg3);
        let v0 = tdc(arg0, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg1, &v0, arg2, arg3);
        ddc(arg0, v0, arg3);
    }

    public fun dtc(arg0: &mut CBM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg2);
        assert!(!0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), 305);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc, arg1);
    }

    public fun dwc(arg0: &mut CBM, arg1: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg2: &mut 0x2::tx_context::TxContext) {
        vaw(arg0, arg2);
        assert!(!0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), 307);
        0x1::option::fill<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.wc, arg1);
    }

    public fun gdtp(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        vaw(arg0, arg2);
        let v0 = btc(arg0, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg1, v0, arg2)
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

    public fun tdc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap {
        vaw(arg0, arg1);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&arg0.dc), 308);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(&mut arg0.dc)
    }

    public fun ttc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap {
        vaw(arg0, arg1);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&arg0.tc), 304);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(&mut arg0.tc)
    }

    public fun twc(arg0: &mut CBM, arg1: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap {
        vaw(arg0, arg1);
        assert!(0x1::option::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&arg0.wc), 306);
        0x1::option::extract<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(&mut arg0.wc)
    }

    fun van(arg0: &CBM, arg1: &AC) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.bma, 301);
    }

    fun vaw(arg0: &CBM, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.aw, &v0), 301);
    }

    public fun wd<T0>(arg0: &mut CBM, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        vaw(arg0, arg3);
        let v0 = twc(arg0, arg3);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, &v0, arg2, arg3);
        dwc(arg0, v0, arg3);
        v1
    }

    // decompiled from Move bytecode v6
}

