module 0xe5b6155a3c318ded1421427f257b7ade530beaa87e9931af2fd5b0d2a8cb7cba::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun check_sender(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906834238767890431);
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun deposit_money(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
    }

    public fun withdraw_money(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_sender(arg0, arg2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public fun withdraw_money_to_sender(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        let v0 = withdraw_money(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

