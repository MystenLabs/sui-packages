module 0x7588158caac88632753d5cd50f3f0c2abfdc514f6af74c244d785c777c1779bf::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct UserStake has store, key {
        id: 0x2::object::UID,
        owner: address,
        stake: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun admin_withdraw(arg0: &Vault, arg1: UserStake, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let UserStake {
            id    : v0,
            owner : _,
            stake : v2,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg0.owner);
        0x2::object::delete(v0);
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UserStake{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            stake : arg0,
        };
        0x2::transfer::share_object<UserStake>(v0);
    }

    public entry fun init_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun withdraw_all(arg0: UserStake, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let UserStake {
            id    : v0,
            owner : v1,
            stake : v2,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

