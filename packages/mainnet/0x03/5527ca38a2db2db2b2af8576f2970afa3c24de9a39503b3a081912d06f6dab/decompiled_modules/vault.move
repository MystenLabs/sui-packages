module 0x35527ca38a2db2db2b2af8576f2970afa3c24de9a39503b3a081912d06f6dab::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
    }

    entry fun deposit<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.id, v0), arg2);
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.id, v0, arg2);
        };
    }

    entry fun get_coin_type<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault>(v1);
    }

    entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.id, 0x1::type_name::get<T0>()), arg2, 0x2::tx_context::sender(arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

