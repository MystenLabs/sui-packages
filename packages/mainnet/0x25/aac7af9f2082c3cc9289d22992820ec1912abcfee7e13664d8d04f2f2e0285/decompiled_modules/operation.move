module 0x25aac7af9f2082c3cc9289d22992820ec1912abcfee7e13664d8d04f2f2e0285::operation {
    struct SUIRC20Action has store, key {
        id: 0x2::object::UID,
        fee: u64,
        inscription: address,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        actions: vector<SUIRC20Action>,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun clone_suirc20_action(arg0: &mut 0x2::tx_context::TxContext, arg1: address, arg2: u64) : SUIRC20Action {
        assert!(arg2 <= 1000000000000, 1);
        SUIRC20Action{
            id          : 0x2::object::new(arg0),
            fee         : arg2,
            inscription : arg1,
        }
    }

    public fun new_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id      : 0x2::object::new(arg2),
            owner   : arg1,
            actions : 0x1::vector::empty<SUIRC20Action>(),
            balance : arg0,
        }
    }

    public fun new_vault_with_fixed_deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Vault {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 4319421160000000000, 0);
        Vault{
            id      : 0x2::object::new(arg2),
            owner   : arg1,
            actions : 0x1::vector::empty<SUIRC20Action>(),
            balance : arg0,
        }
    }

    public fun send_sui_to_vault(arg0: &mut Vault, arg1: SUIRC20Action, arg2: address) {
        assert!(arg2 == arg0.owner, 2);
        assert!(0x1::vector::length<SUIRC20Action>(&arg0.actions) < 100, 3);
        0x1::vector::push_back<SUIRC20Action>(&mut arg0.actions, arg1);
    }

    // decompiled from Move bytecode v6
}

