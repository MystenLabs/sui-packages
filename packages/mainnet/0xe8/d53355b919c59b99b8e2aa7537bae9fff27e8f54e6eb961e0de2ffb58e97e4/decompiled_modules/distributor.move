module 0xe8d53355b919c59b99b8e2aa7537bae9fff27e8f54e6eb961e0de2ffb58e97e4::distributor {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        claimed_users: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<T0>,
        claim_amount: u64,
    }

    public entry fun claim_vault<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, u64>(&arg0.claimed_users, v0), 0);
        0x2::table::add<address, u64>(&mut arg0.claimed_users, v0, arg0.claim_amount);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg0.claim_amount), arg1), v0);
    }

    public entry fun create_vault<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id            : 0x2::object::new(arg1),
            claimed_users : 0x2::table::new<address, u64>(arg1),
            balance       : 0x2::balance::zero<T0>(),
            claim_amount  : arg0,
        };
        0x2::transfer::public_share_object<Vault<T0>>(v0);
    }

    public fun deposit_to_vault<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

