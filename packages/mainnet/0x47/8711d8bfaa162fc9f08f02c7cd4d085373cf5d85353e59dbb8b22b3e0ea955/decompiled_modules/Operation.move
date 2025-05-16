module 0x478711d8bfaa162fc9f08f02c7cd4d085373cf5d85353e59dbb8b22b3e0ea955::Operation {
    struct SUIRC20Action has store, key {
        id: 0x2::object::UID,
        fee: u64,
        inscription: address,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        actions: vector<SUIRC20Action>,
    }

    public fun clone_suirc20_action(arg0: &mut 0x2::tx_context::TxContext, arg1: address, arg2: u64) : SUIRC20Action {
        SUIRC20Action{
            id          : 0x2::object::new(arg0),
            fee         : arg2,
            inscription : arg1,
        }
    }

    public fun new_vault(arg0: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id      : 0x2::object::new(arg0),
            actions : 0x1::vector::empty<SUIRC20Action>(),
        }
    }

    public fun send_sui_to_vault(arg0: &mut Vault, arg1: SUIRC20Action) {
        0x1::vector::push_back<SUIRC20Action>(&mut arg0.actions, arg1);
    }

    // decompiled from Move bytecode v6
}

