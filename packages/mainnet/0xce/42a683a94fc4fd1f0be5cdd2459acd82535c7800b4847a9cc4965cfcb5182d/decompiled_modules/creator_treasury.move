module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::creator_treasury {
    struct CreatorTreasury has key {
        id: 0x2::object::UID,
        owner: address,
        bal: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = CreatorTreasury{
            id    : 0x2::object::new(arg0),
            owner : v0,
            bal   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<CreatorTreasury>(v1, v0);
    }

    public fun deposit_usde(arg0: &mut CreatorTreasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bal, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun owner(arg0: &CreatorTreasury) : address {
        arg0.owner
    }

    entry fun withdraw_all(arg0: &mut CreatorTreasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bal, 0x2::balance::value<0x2::sui::SUI>(&arg0.bal)), arg1), v0);
    }

    entry fun withdraw_amount(arg0: &mut CreatorTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bal, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

