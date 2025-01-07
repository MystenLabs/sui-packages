module 0x48251c536f9c06c5a68d958ce4c1ba6ee1d1bf36698ab42b0c1929d12969a840::task5_swap {
    struct LogBank has copy, drop {
        bank_value_RMB: u64,
        bank_value_USDT: u64,
        bank_value_change: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SwapBank has store, key {
        id: 0x2::object::UID,
        Coin_RMB: 0x2::balance::Balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>,
        Coin_USDT: 0x2::balance::Balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>,
    }

    public entry fun deposit_CoinRMB(arg0: &AdminCap, arg1: &mut SwapBank, arg2: 0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(arg2);
        0x2::balance::join<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&mut arg1.Coin_RMB, v0);
        let v1 = LogBank{
            bank_value_RMB    : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&arg1.Coin_RMB),
            bank_value_USDT   : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&arg1.Coin_USDT),
            bank_value_change : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&v0),
        };
        0x2::event::emit<LogBank>(v1);
    }

    public entry fun deposit_CoinUSDT(arg0: &AdminCap, arg1: &mut SwapBank, arg2: 0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(arg2);
        0x2::balance::join<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&mut arg1.Coin_USDT, v0);
        let v1 = LogBank{
            bank_value_RMB    : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&arg1.Coin_RMB),
            bank_value_USDT   : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&arg1.Coin_USDT),
            bank_value_change : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&v0),
        };
        0x2::event::emit<LogBank>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapBank{
            id        : 0x2::object::new(arg0),
            Coin_RMB  : 0x2::balance::zero<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(),
            Coin_USDT : 0x2::balance::zero<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(),
        };
        0x2::transfer::share_object<SwapBank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_RMB_TO_USDT(arg0: &mut SwapBank, arg1: 0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&mut arg0.Coin_RMB, 0x2::coin::into_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>>(0x2::coin::from_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(0x2::balance::split<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&mut arg0.Coin_USDT, 0x2::coin::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&arg1) * 730000 / 100000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_USDT_TO_RMB(arg0: &mut SwapBank, arg1: 0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&mut arg0.Coin_USDT, 0x2::coin::into_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>>(0x2::coin::from_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(0x2::balance::split<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&mut arg0.Coin_RMB, 0x2::coin::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&arg1) * 100000 / 730000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withDraw_CoinRMB(arg0: &AdminCap, arg1: &mut SwapBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>>(0x2::coin::from_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(0x2::balance::split<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&mut arg1.Coin_RMB, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = LogBank{
            bank_value_RMB    : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&arg1.Coin_RMB),
            bank_value_USDT   : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&arg1.Coin_USDT),
            bank_value_change : arg2,
        };
        0x2::event::emit<LogBank>(v0);
    }

    public entry fun withDraw_CoinUSDT(arg0: &AdminCap, arg1: &mut SwapBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>>(0x2::coin::from_balance<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(0x2::balance::split<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&mut arg1.Coin_USDT, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = LogBank{
            bank_value_RMB    : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_RMB::QWRDXER_RMB>(&arg1.Coin_RMB),
            bank_value_USDT   : 0x2::balance::value<0x624279676894ea3ea17937402ec82c0a9681fdf34dd4b5dce75ccde4dd56a8f5::qwrdxer_USDT::QWRDXER_USDT>(&arg1.Coin_USDT),
            bank_value_change : arg2,
        };
        0x2::event::emit<LogBank>(v0);
    }

    // decompiled from Move bytecode v6
}

