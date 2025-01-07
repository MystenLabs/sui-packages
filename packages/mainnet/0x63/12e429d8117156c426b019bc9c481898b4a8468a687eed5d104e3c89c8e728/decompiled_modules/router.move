module 0x6312e429d8117156c426b019bc9c481898b4a8468a687eed5d104e3c89c8e728::router {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Shop has key {
        id: 0x2::object::UID,
        address_table: 0x2::table::Table<address, u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
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

    // decompiled from Move bytecode v6
}

