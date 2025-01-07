module 0x220e1fb6821f2851bf8557104251b47036527f1ac35ad757db1d9a503388cf14::swap_lizhecome {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        lizhecome: 0x2::balance::Balance<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>,
        lizhecome_faucet: 0x2::balance::Balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>,
    }

    public entry fun deposit_lizhecome(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(&mut arg1.lizhecome, 0x2::coin::into_balance<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(arg2));
    }

    public entry fun deposit_lizhecome_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg1.lizhecome_faucet, 0x2::coin::into_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id               : 0x2::object::new(arg0),
            lizhecome        : 0x2::balance::zero<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(),
            lizhecome_faucet : 0x2::balance::zero<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_faucet_to_lizhecome(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg0.lizhecome_faucet, 0x2::coin::into_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>>(0x2::coin::from_balance<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(0x2::balance::split<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(&mut arg0.lizhecome, 0x2::coin::value<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&arg1) / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_lizhecome_to_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(&mut arg0.lizhecome, 0x2::coin::into_balance<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>>(0x2::coin::from_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(0x2::balance::split<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg0.lizhecome_faucet, 0x2::coin::value<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_lizhecome(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>>(0x2::coin::from_balance<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(0x2::balance::split<0xe0ac81bc9b10c46dcfbc9ca64b2991af7337e7e68cee092ee2018aa81f97945e::lizhecome_coin::LIZHECOME_COIN>(&mut arg1.lizhecome, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_lizhecome_faucet(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>>(0x2::coin::from_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(0x2::balance::split<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg1.lizhecome_faucet, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

