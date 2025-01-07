module 0x677f64ffb2d8e5ce7b6336fe53776c86f98b688cd20645b79129c5eb4b3245f2::swap {
    struct Bank has key {
        id: 0x2::object::UID,
        USD: 0x2::balance::Balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>,
        RMB: 0x2::balance::Balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>,
        rate: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_RMB(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(arg1));
    }

    public entry fun deposit_USD(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(arg1));
    }

    public fun get_rate(arg0: &Bank) : u64 {
        arg0.rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            USD  : 0x2::balance::zero<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(),
            RMB  : 0x2::balance::zero<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(),
            rate : 7,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rate = arg2;
    }

    public entry fun swap_rmb2usd(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>>(0x2::coin::from_balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(0x2::balance::split<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(&mut arg0.USD, 0x2::coin::value<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(&arg1) / arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_usd2rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>>(0x2::coin::from_balance<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(0x2::balance::split<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_faucet_coin::LINKTIMES_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::value<0xc805c954af8e35a19e01b755689ae393dfa9ed57c3012f413fc3744b6bfdba21::linktimes_coin::LINKTIMES_COIN>(&arg1) * arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

