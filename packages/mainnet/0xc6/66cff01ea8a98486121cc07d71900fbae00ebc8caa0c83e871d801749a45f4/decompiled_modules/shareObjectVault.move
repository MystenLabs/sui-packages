module 0xc666cff01ea8a98486121cc07d71900fbae00ebc8caa0c83e871d801749a45f4::shareObjectVault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        sui_coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct WithdrawEvent has copy, drop {
        admin: address,
        recipient: address,
        amount: u64,
    }

    public fun deposit_sui(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_coin, arg1);
    }

    public fun new_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg1),
            sui_coin : arg0,
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public fun withdraw_sui(arg0: &mut Vault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x1975d66c272b33c1614f219a223a24db133b5a61287f90d76fff6c76aa958585, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_coin, arg1, arg3), arg2);
        let v0 = WithdrawEvent{
            admin     : @0x1975d66c272b33c1614f219a223a24db133b5a61287f90d76fff6c76aa958585,
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

