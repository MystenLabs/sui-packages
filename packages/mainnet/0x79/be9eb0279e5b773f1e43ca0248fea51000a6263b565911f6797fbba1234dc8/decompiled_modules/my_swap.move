module 0x79be9eb0279e5b773f1e43ca0248fea51000a6263b565911f6797fbba1234dc8::my_swap {
    struct MyBank has store, key {
        id: 0x2::object::UID,
        doc_coin: 0x2::balance::Balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>,
        faucet_coin: 0x2::balance::Balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun dao_to_faucet(arg0: &mut MyBank, arg1: 0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(arg1);
        0x2::balance::join<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(&mut arg0.doc_coin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg0.faucet_coin, 0x2::balance::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(&v0) * 7), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun faucet_to_dao(arg0: &mut MyBank, arg1: 0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(arg1);
        0x2::balance::join<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg0.faucet_coin, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>>(0x2::coin::from_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(0x2::balance::split<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(&mut arg0.doc_coin, 0x2::balance::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&v0) / 7), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun in_dao(arg0: &mut MyBank, arg1: 0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(&mut arg0.doc_coin, 0x2::coin::into_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(arg1));
    }

    public entry fun in_faucet(arg0: &mut MyBank, arg1: 0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyBank{
            id          : 0x2::object::new(arg0),
            doc_coin    : 0x2::balance::zero<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(),
            faucet_coin : 0x2::balance::zero<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<MyBank>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_dao(arg0: &AdminCap, arg1: &mut MyBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(&arg1.doc_coin) < arg2) {
            abort 101
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>>(0x2::coin::from_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(0x2::balance::split<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::dao::DAO>(&mut arg1.doc_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun remove_faucet(arg0: &AdminCap, arg1: &mut MyBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&arg1.faucet_coin) < arg2) {
            abort 102
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>>(0x2::coin::from_balance<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(0x2::balance::split<0xae412de9df987063117db968d17e8f4dfa16b92f5f9527e36af47af427070b83::faucetcoin::FAUCETCOIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

