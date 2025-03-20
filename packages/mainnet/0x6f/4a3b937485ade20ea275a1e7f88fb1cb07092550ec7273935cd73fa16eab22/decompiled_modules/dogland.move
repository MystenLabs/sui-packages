module 0x6f4a3b937485ade20ea275a1e7f88fb1cb07092550ec7273935cd73fa16eab22::dogland {
    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xff5383d8148673d6b1f93b126982d3c5850aa4cf2ed891c09ce99468992b9172);
        let v1 = DepositEvent{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

