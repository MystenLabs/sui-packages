module 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suilpool {
    struct SwapLiquidity has store, key {
        id: 0x2::object::UID,
        swap_id: u64,
        fee_rate: u64,
        suil_usd_value: u64,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        balance_suil: 0x2::balance::Balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>,
        version: u64,
    }

    struct SUILPool has store, key {
        id: 0x2::object::UID,
        locked_suil: 0x2::balance::Balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>,
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

    struct TopUpSUILPool has store, key {
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

    struct TopUpSuil has copy, drop {
        id: u64,
        amount: u64,
        usd_amount: u64,
        sui_amount: u64,
        user: address,
    }

    public entry fun swap<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut SwapLiquidity, arg2: 0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 404
    }

    public entry fun add_swap_sui_liquidity(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        check_swap_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun calculate_suil_usd_sui<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL, 0x2::sui::SUI>, arg2: u64) : (u64, u64) {
        let v0 = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_suil_amount_out(arg1, arg2, false);
        (0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg0, v0, true), v0)
    }

    fun check_suilpool_version(arg0: &TopUpSUILPool) {
        assert!(arg0.version == 6, 1);
    }

    fun check_suipool_version(arg0: &TopUpSUIPool) {
        assert!(arg0.version == 6, 1);
    }

    fun check_swap_version(arg0: &SwapLiquidity) {
        assert!(arg0.version == 6, 1);
    }

    fun check_version(arg0: &SUILPool) {
        assert!(arg0.version == 6, 1);
    }

    public entry fun claim_suil(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: &mut 0x2::tx_context::TxContext) {
        check_swap_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>>(0x2::coin::from_balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(0x2::balance::split<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&mut arg1.balance_suil, 0x2::balance::value<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&arg1.balance_suil)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_swap_sui_liquidity(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_swap_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance_sui, arg2), arg4), arg3);
    }

    public entry fun increase_locked_suil(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SUILPool, arg2: 0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>) {
        0x2::balance::join<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&mut arg1.locked_suil, 0x2::coin::into_balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SwapLiquidity{
            id             : 0x2::object::new(arg0),
            swap_id        : 0,
            fee_rate       : 300,
            suil_usd_value : 100000,
            balance_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            balance_suil   : 0x2::balance::zero<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(),
            version        : 6,
        };
        let v2 = SUILPool{
            id                : 0x2::object::new(arg0),
            locked_suil       : 0x2::balance::zero<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(),
            used_withdraw_ids : 0x2::table::new<u64, bool>(arg0),
            eth_signer        : @0x4ad11e8453ffa026534f18d5757389b6a795ba23,
            version           : 6,
        };
        let v3 = TopUpSUIPool{
            id       : 0x2::object::new(arg0),
            sequence : 0,
            receipt  : v0,
            version  : 6,
        };
        0x2::transfer::public_share_object<SwapLiquidity>(v1);
        0x2::transfer::public_share_object<SUILPool>(v2);
        0x2::transfer::public_share_object<TopUpSUIPool>(v3);
        let v4 = TopUpSUILPool{
            id       : 0x2::object::new(arg0),
            sequence : 0,
            receipt  : v0,
            version  : 6,
        };
        0x2::transfer::public_share_object<TopUpSUILPool>(v4);
    }

    public entry fun migrate(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SUILPool, arg2: &mut SwapLiquidity, arg3: &mut TopUpSUIPool) {
        assert!(arg1.version < 6, 2);
        arg1.version = 6;
        arg2.version = 6;
        arg3.version = 6;
    }

    public entry fun migrate_topup_suil_pool(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut TopUpSUILPool) {
        assert!(arg1.version < 6, 2);
        arg1.version = 6;
    }

    public entry fun modify_eth_signer(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SUILPool, arg2: address) {
        arg1.eth_signer = arg2;
    }

    public entry fun reward(arg0: &mut 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SUILPool, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 6);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>>(0x2::coin::from_balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(0x2::balance::split<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&mut arg1.locked_suil, *0x1::vector::borrow<u64>(&arg3, v1)), arg4), *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun swap_v2<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL, 0x2::sui::SUI>, arg2: &mut SwapLiquidity, arg3: 0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&arg3);
        let (v2, v3, v4) = swap_view_v2<T0>(arg0, arg1, arg2, v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>>(0x2::coin::split<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&mut arg3, v2, arg4), @0x0);
        };
        0x2::balance::join<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&mut arg2.balance_suil, 0x2::coin::into_balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(arg3));
        assert!(v4 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance_sui, v4), arg4), v0);
        let v5 = arg2.swap_id + 1;
        arg2.swap_id = v5;
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

    public fun swap_view<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut SwapLiquidity, arg2: u64) : (u64, u64, u64) {
        abort 404
    }

    public fun swap_view_v2<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL, 0x2::sui::SUI>, arg2: &mut SwapLiquidity, arg3: u64) : (u64, u64, u64) {
        let v0 = arg3 * arg2.fee_rate / 10000;
        let (v1, v2) = calculate_suil_usd_sui<T0>(arg0, arg1, arg3 - v0);
        (v0, v1, v2)
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
            value  : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg0, v0, true),
            user   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TopUpSui>(v2);
    }

    public entry fun topup_suil<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL, 0x2::sui::SUI>, arg2: &mut TopUpSUILPool, arg3: 0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>, arg4: &mut 0x2::tx_context::TxContext) {
        check_suilpool_version(arg2);
        let v0 = 0x2::coin::value<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&arg3);
        let (v1, v2) = calculate_suil_usd_sui<T0>(arg0, arg1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>>(arg3, arg2.receipt);
        let v3 = arg2.sequence + 1;
        arg2.sequence = v3;
        let v4 = TopUpSuil{
            id         : v3,
            amount     : v0,
            usd_amount : v1,
            sui_amount : v2,
            user       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TopUpSuil>(v4);
    }

    public entry fun update_swap_fee(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: u64) {
        check_swap_version(arg1);
        arg1.fee_rate = arg2;
    }

    public entry fun update_swap_suil_usd_value(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut SwapLiquidity, arg2: u64) {
        check_swap_version(arg1);
        arg1.suil_usd_value = arg2;
    }

    public entry fun update_topup_sui_receipt(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut TopUpSUIPool, arg2: address) {
        arg1.receipt = arg2;
    }

    public entry fun update_topup_suil_receipt(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut TopUpSUILPool, arg2: address) {
        arg1.receipt = arg2;
    }

    public entry fun withdraw(arg0: &mut SUILPool, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_withdraw_ids, arg1), 3);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::sign::verify_withdraw_message(arg1, arg3, arg2, &arg4, arg0.eth_signer);
        assert!(0x2::balance::value<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&arg0.locked_suil) >= arg2, 4);
        0x2::table::add<u64, bool>(&mut arg0.used_withdraw_ids, arg1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>>(0x2::coin::from_balance<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(0x2::balance::split<0x62b571aedf46d3d715cc059639ea34da91fef024d936a9bbed419d537925ccc2::suil::SUIL>(&mut arg0.locked_suil, arg2), arg5), arg3);
        let v0 = Withdrawn{
            id          : arg1,
            amount      : arg2,
            destination : arg3,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

