module 0x88b16daf477260856e19e7d35e8efff4f19ec0d99afa1aa61ada3632c3cdf6a7::collect {
    struct Collect has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit<T0>(arg0: &mut Collect, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Collect{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Collect>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Collect, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

