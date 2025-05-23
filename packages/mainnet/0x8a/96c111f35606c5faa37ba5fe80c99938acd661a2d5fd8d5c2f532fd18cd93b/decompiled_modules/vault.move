module 0x8a96c111f35606c5faa37ba5fe80c99938acd661a2d5fd8d5c2f532fd18cd93b::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun deposit(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    entry fun get_coin_type<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg0)),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault>(v1);
    }

    entry fun withdraw(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

