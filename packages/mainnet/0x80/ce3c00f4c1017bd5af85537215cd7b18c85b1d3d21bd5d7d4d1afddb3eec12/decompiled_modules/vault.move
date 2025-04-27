module 0x80ce3c00f4c1017bd5af85537215cd7b18c85b1d3d21bd5d7d4d1afddb3eec12::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct UserStake has store, key {
        id: 0x2::object::UID,
        owner: address,
        stake: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserStake{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            stake : arg0,
        };
        0x2::transfer::public_transfer<UserStake>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<Vault>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw_all(arg0: UserStake, arg1: &mut 0x2::tx_context::TxContext) {
        let UserStake {
            id    : v0,
            owner : _,
            stake : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

