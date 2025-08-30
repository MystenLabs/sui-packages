module 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suilpool {
    struct SwapLiquidity has store, key {
        id: 0x2::object::UID,
        swap_id: u64,
        fee_rate: u64,
        suil_usd_value: u64,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_suil: 0x2::balance::Balance<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>,
        version: u64,
    }

    struct SUILPool has store, key {
        id: 0x2::object::UID,
        locked_suil: 0x2::balance::Balance<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>,
        used_withdraw_ids: 0x2::table::Table<u64, bool>,
        eth_signer: address,
        version: u64,
    }

    struct TopUpSUIPool has store, key {
        id: 0x2::object::UID,
        sequence: u64,
        receipt: address,
        version: u64,
    }

    struct NewSwap has copy, drop {
        id: u64,
        suil_amount: u64,
        suil_fee_amount: u64,
        suil_swap_value: u64,
        sui_amount_out: u64,
        user: address,
    }

    struct TopUpSui has copy, drop {
        id: u64,
        amount: u64,
        value: u64,
        user: address,
    }

    struct Withdrawn has copy, drop {
        id: u64,
        amount: u64,
        destination: address,
    }

    public entry fun swap<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut SwapLiquidity, arg2: 0x2::coin::Coin<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&arg2);
        let v2 = v1 * arg1.fee_rate / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>>(0x2::coin::split<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&mut arg2, v2, arg3), @0x0);
        };
        0x2::balance::join<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&mut arg1.balance_suil, 0x2::coin::into_balance<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(arg2));
        let v3 = ((((v1 - v2) as u128) * (arg1.suil_usd_value as u128) / 1000000000) as u64);
        let v4 = 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice::get_amount_out_v3<T0>(arg0, v3, false);
        assert!(v4 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_sui, v4), arg3), v0);
        let v5 = arg1.swap_id + 1;
        arg1.swap_id = v5;
        let v6 = NewSwap{
            id              : v5,
            suil_amount     : v1,
            suil_fee_amount : v2,
            suil_swap_value : v3,
            sui_amount_out  : v4,
            user            : v0,
        };
        0x2::event::emit<NewSwap>(v6);
    }

    public entry fun add_swap_sui_liquidity(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        check_swap_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    fun check_suipool_version(arg0: &TopUpSUIPool) {
        assert!(arg0.version == 3, 1);
    }

    fun check_swap_version(arg0: &SwapLiquidity) {
        assert!(arg0.version == 3, 1);
    }

    fun check_version(arg0: &SUILPool) {
        assert!(arg0.version == 3, 1);
    }

    public entry fun claim_suil(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: &mut 0x2::tx_context::TxContext) {
        check_swap_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>>(0x2::coin::from_balance<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(0x2::balance::split<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&mut arg1.balance_suil, 0x2::balance::value<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&arg1.balance_suil)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_swap_sui_liquidity(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_swap_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_sui, arg2), arg4), arg3);
    }

    public entry fun increase_locked_suil(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SUILPool, arg2: 0x2::coin::Coin<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>) {
        0x2::balance::join<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&mut arg1.locked_suil, 0x2::coin::into_balance<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(arg2));
    }

    public entry fun init_suil_pool(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapLiquidity{
            id             : 0x2::object::new(arg1),
            swap_id        : 0,
            fee_rate       : 300,
            suil_usd_value : 100000,
            balance_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_suil   : 0x2::balance::zero<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(),
            version        : 3,
        };
        let v1 = SUILPool{
            id                : 0x2::object::new(arg1),
            locked_suil       : 0x2::balance::zero<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(),
            used_withdraw_ids : 0x2::table::new<u64, bool>(arg1),
            eth_signer        : @0x4ad11e8453ffa026534f18d5757389b6a795ba23,
            version           : 3,
        };
        let v2 = TopUpSUIPool{
            id       : 0x2::object::new(arg1),
            sequence : 0,
            receipt  : @0xfd1f7a86630b6e5b88d4ad58920774a6fb75cfe5f9b3da587ba16c4e2ea246e1,
            version  : 3,
        };
        0x2::transfer::public_share_object<SwapLiquidity>(v0);
        0x2::transfer::public_share_object<SUILPool>(v1);
        0x2::transfer::public_share_object<TopUpSUIPool>(v2);
    }

    public entry fun migrate(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SUILPool, arg2: &mut SwapLiquidity, arg3: &mut TopUpSUIPool) {
        assert!(arg1.version < 3, 2);
        arg1.version = 3;
        arg2.version = 3;
        arg3.version = 3;
    }

    public entry fun modify_eth_signer(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SUILPool, arg2: address) {
        arg1.eth_signer = arg2;
    }

    public fun swap_view<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut SwapLiquidity, arg2: u64) : (u64, u64, u64) {
        let v0 = arg2 * arg1.fee_rate / 10000;
        let v1 = ((((arg2 - v0) as u128) * (arg1.suil_usd_value as u128) / 1000000000) as u64);
        (v0, v1, 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice::get_amount_out_v3<T0>(arg0, v1, false))
    }

    public entry fun topup<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut TopUpSUIPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        check_suipool_version(arg1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.receipt);
        let v1 = arg1.sequence + 1;
        arg1.sequence = v1;
        let v2 = TopUpSui{
            id     : v1,
            amount : v0,
            value  : 0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::suiprice::get_amount_out_v3<T0>(arg0, v0, true),
            user   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TopUpSui>(v2);
    }

    public entry fun update_swap_fee(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: u64) {
        check_swap_version(arg1);
        arg1.fee_rate = arg2;
    }

    public entry fun update_swap_suil_usd_value(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: u64) {
        check_swap_version(arg1);
        arg1.suil_usd_value = arg2;
    }

    public entry fun update_topup_sui_receipt(arg0: &0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::finance::FinanceCap, arg1: &mut TopUpSUIPool, arg2: address) {
        arg1.receipt = arg2;
    }

    public entry fun withdraw(arg0: &mut SUILPool, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_withdraw_ids, arg1), 3);
        0x71c8bd7e35cf235c00dc3bd358abd96fb53d8c009e13e3717631c377ef6c8ca::sign::verify_withdraw_message(arg1, arg3, arg2, &arg4, arg0.eth_signer);
        assert!(0x2::balance::value<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&arg0.locked_suil) >= arg2, 4);
        0x2::table::add<u64, bool>(&mut arg0.used_withdraw_ids, arg1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>>(0x2::coin::from_balance<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(0x2::balance::split<0x11f15e1c9e1a49cd26d4c442b5911dc87585440969f9a18d9c171e2acd21ac1b::suil::SUIL>(&mut arg0.locked_suil, arg2), arg5), arg3);
        let v0 = Withdrawn{
            id          : arg1,
            amount      : arg2,
            destination : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

