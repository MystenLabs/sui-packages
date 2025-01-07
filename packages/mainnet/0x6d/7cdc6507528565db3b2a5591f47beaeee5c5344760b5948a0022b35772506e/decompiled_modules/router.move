module 0x6d7cdc6507528565db3b2a5591f47beaeee5c5344760b5948a0022b35772506e::router {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Shop has key {
        id: 0x2::object::UID,
        address_table: 0x2::table::Table<address, u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun deposit(arg0: &OwnerCap, arg1: &mut Shop, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Shop{
            id            : 0x2::object::new(arg0),
            address_table : 0x2::table::new<address, u8>(arg0),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Shop>(v1);
    }

    public entry fun withdraw(arg0: &OwnerCap, arg1: &mut Shop, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

