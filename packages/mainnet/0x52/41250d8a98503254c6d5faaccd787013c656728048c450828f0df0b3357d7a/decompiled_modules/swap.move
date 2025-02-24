module 0x5241250d8a98503254c6d5faaccd787013c656728048c450828f0df0b3357d7a::swap {
    struct Bank has key {
        id: 0x2::object::UID,
        my_coin: 0x2::balance::Balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>,
        faucet_coin: 0x2::balance::Balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>,
    }

    struct BankCap has key {
        id: 0x2::object::UID,
    }

    public fun deposit_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(arg1));
    }

    public fun deposit_my_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::coin::into_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(arg1));
    }

    public fun faucet_to_my(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>>(0x2::coin::from_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(0x2::balance::split<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::coin::value<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&arg1) / 10), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id          : 0x2::object::new(arg0),
            my_coin     : 0x2::balance::zero<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(),
            faucet_coin : 0x2::balance::zero<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = BankCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BankCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun my_to_faucet(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(&mut arg0.my_coin, 0x2::coin::into_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::value<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(&arg1) * 10), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_faucet_coin(arg0: &BankCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(0x2::balance::split<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::faucet_coin::FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_my_coin(arg0: &BankCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>>(0x2::coin::from_balance<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(0x2::balance::split<0xf9896d706d2461eb997a42f53ef8ddcd1b77e622516ae95166e9cad1e102723e::my_coin::MY_COIN>(&mut arg1.my_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

