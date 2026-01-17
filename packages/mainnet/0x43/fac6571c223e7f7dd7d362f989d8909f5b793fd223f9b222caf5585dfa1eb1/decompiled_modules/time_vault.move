module 0x43fac6571c223e7f7dd7d362f989d8909f5b793fd223f9b222caf5585dfa1eb1::time_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        unlock_time_ms: u64,
    }

    public entry fun lock_funds(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Vault{
            id             : 0x2::object::new(arg3),
            owner          : v0,
            funds          : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            unlock_time_ms : 0x2::clock::timestamp_ms(arg2) + arg1,
        };
        0x2::transfer::transfer<Vault>(v1, v0);
    }

    public entry fun withdraw(arg0: Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Vault {
            id             : v0,
            owner          : v1,
            funds          : v2,
            unlock_time_ms : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) >= v3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2), v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

