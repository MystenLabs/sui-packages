module 0xabbff0b16be6e256720defcbdc6cd58473f0e5d238910e76f53139f0e4db87b5::dogland {
    struct DepositEvent has copy, drop, store {
        user: address,
        amount: u64,
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x5fcfa003043765ec58d74534b84e8c3a6f7533f0ca0a94ddee7b53ea89755a26);
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

