module 0xceaf4e513bac4163386879f63ef3084022e74e328eba82448f364dba8ebd66a7::guessgame {
    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg1.balance, 0x2::coin::into_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(arg2));
    }

    entry fun gameplay(arg0: &0x2::random::Random, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&arg1.balance) >= 1000000, 2);
        let v0 = 0x2::coin::into_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(arg2);
        assert!(0x2::balance::value<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&v0) == 1000000, 1);
        0x2::balance::join<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg1.balance, v0);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        if (arg3 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>>(0x2::coin::from_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(0x2::balance::split<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg1.balance, 2000000), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&arg1.balance), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>>(0x2::coin::from_balance<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(0x2::balance::split<0x47cce79a523db24fa3f74f090f867484ab72a312cdba9afe6782f3b20cc273f::lizhecome_faucet_coin::LIZHECOME_FAUCET_COIN>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

