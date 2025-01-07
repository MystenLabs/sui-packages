module 0x4623775b932a4bbd5b3c6b93ab61ddc492c0ed19c81e9d6da59c4815aa7981de::lazy_forever_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>,
        coin_b: 0x2::balance::Balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>,
    }

    public entry fun a_swap_b(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>>(0x2::coin::from_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(0x2::balance::split<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(&mut arg0.coin_b, 0x2::coin::value<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun b_swap_a(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(&mut arg0.coin_b, 0x2::coin::into_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>>(0x2::coin::from_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(0x2::balance::split<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(&mut arg0.coin_a, 0x2::coin::value<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(&arg1) * 100000 / 200000), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit_coin_a(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(arg1));
    }

    public entry fun deposit_coin_b(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(&mut arg0.coin_b, 0x2::coin::into_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(),
            coin_b : 0x2::balance::zero<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw_coin_a(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>>(0x2::coin::from_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(0x2::balance::split<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin::LAZY_FOREVER_COIN>(&mut arg1.coin_a, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin_b(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>>(0x2::coin::from_balance<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(0x2::balance::split<0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet::LAZY_FOREVER_FAUCET>(&mut arg1.coin_b, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

